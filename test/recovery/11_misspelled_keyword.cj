// BREAK: misspelled 'func' keyword
// EXPECT: localized — ERROR around the bad keyword, body still parses
fucn f() {
    g()
}
