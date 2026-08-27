// BREAK: missing ')' in a function call
// EXPECT: localized — MISSING ")" near the call, function body still closes
func f() {
    g(1
}
