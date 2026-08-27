// BREAK: unclosed string literal (external scanner stress test)
// EXPECT: localized — ERROR confined to the string; the following call recovers
func f() {
    s = "unclosed
    g()
}
