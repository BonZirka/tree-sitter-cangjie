// BREAK: trailing binary operator with no right operand
// EXPECT: localized — MISSING operand or small ERROR at end of line
func f() {
    a = b +
}
