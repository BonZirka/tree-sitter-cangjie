// BREAK: 'else' with no matching 'if'
// EXPECT: localized — small ERROR around the stray 'else'
func f() {
    else { g() }
}
