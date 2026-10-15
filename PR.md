# cjc-aligned lexing and type coverage

Ground-truth work against the cjc 1.3 compiler (lexer source + probe suite): unicode identifiers, raw package paths in imports, full-type extend targets, and dead-weight removal in the grammar.

## Unicode identifiers (XID)

The cjc lexer (`ScanIdentifierOrKeyword` + `Utils/Unicode.cpp`) accepts bare identifiers from XID_Start/XID_Continue (Unicode 15.0), NFC-normalizes values, and is ASCII-only for keywords. Backticks are raw identifiers that escape keywords.

tree-sitter constraints discovered along the way, now documented in `grammar.js`:

- the `word` token must compile to character sets **without the `u` flag** — `\p{...}` classes, explicit unicode ranges, or the flag itself silently kill keyword conversion (`Int64` lexes as a plain identifier and every type conversion collapses);
- surrogate code points are rejected inside character classes;
- aliasing anything to the word symbol overflows the generator's word analysis.

So the word token stays the ASCII regex, and `unicode_identifier`/`raw_identifier` are separate tokens joined at the identifier positions that matter (types, bindings and patterns, function/property/class/enum/type-alias names, parameters, field access, primary expressions) via per-alternative `alias()` — trees stay uniform (`identifier`, `func_name`, ...), so no query changes were needed.

The `LLT/compiler/Lexer/Unicode/NFC` good files now parse clean; `illegal.cj` still errors. Lone `_` inside backticks remains an accepted divergence.

## Raw package paths and `::` separators in imports

- `package_identifier` token: backticked import-path segments containing `-`/`.`/space (cjc's `PACKAGE_IDENTIFIER`, `ScanBackquotedIdentifier`).
- `scoped_identifier` chains accept it as any non-last segment, which structurally enforces cjc's rule that a raw **last** segment is an error (``import `a-b` as B`` fails, like cjc).
- `::` separators in import paths and package headers (`import std::io.*`, `package huawei::pro2.zoo`) — import/header syntax; `scoped_identifier` over-accepts `::` in type chains for simplicity.
- Raw-wildcard imports (`import `my-pkg`.*`).
- `@module` captures extended; corpus test in its own `imports.txt` (all five shapes cjc-verified).

## Extend targets are full types

cjc's parser accepts a full type in extend position — tuple/arrow extends are rejected by its **semantic** pass ("extending type ... is not supported"), not the parser. The narrow `extend_type` (names/primitives/prefix_type) was a patchwork predating `_type`'s primitive coverage, later patched with `prefix_type` for `extend ?Int64`. It is now `seq(optional($.type_parameters), $._type)`; tuple/arrow extends over-accept like the compiler's parser.

**Tree-shape change for consumers:** extend-target children are now `type_name`-wrapped instead of bare `identifier`s.

## Dead weight and cjc-verified fixes

- `static_init` was dead rule weight: `PREC.STATIC_INIT (-2)` made `static init()` always parse as `init(modifiers=[static])` (verified in the parse). Rule removed; `PREC.INIT`/`STATIC_INIT` are gone; the conflict list is unchanged (3 entries, no new conflicts).
- `unsafe main() {}` parses (cjc compiles it — `FFI/CFFI/type_cast/type_cast_0.cj`, whose 13 error nodes of cascade recovery all resolve).
- Queries: decorated member fields (`@Deprecated let y` → `@variable.member`/`@constant`), member functions captured as `@function.method`, unit literal capture, lambda-callee chains at any depth.

## Verification

- grammar corpus: **124/124** (incl. new `unicode_identifiers.txt` and `imports.txt`)
- cjc cross-probe matrix: soft words parse as identifiers, hard words reject, `main` reserved with the function-name exception; all five import shapes match cjc's accept/reject behavior
- std/stdlib + stdx: **767 files, zero error nodes**
- 6017-file golden corpus rebased and green: **6017/6017, 0 regressions**
- `tree-sitter generate`: no new conflicts (3 entries, unchanged)

## Test plan

- [ ] `tree-sitter generate && tree-sitter test` in the grammar repo
- [ ] golden harness run against the pinned sources (pre-warm + 10s timeout)
- [ ] spot-check unicode identifiers, ``import `pkg-with-dash`.x``, and `extend ?T` in an editor
