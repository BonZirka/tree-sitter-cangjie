// BREAK: missing '(' after 'if'
// EXPECT: localized — MISSING "(" near the if, the block still parses
func f() {
    if true {
        g()
    }
}
