// BREAK: ASI failure — two assignments with no separating newline/terminator
// EXPECT: localized — each `a`/`b` should form a small construct, not one ERROR spanning the line
func f() {
    a = 1 b = 2
}
