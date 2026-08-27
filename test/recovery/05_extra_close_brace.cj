// BREAK: a stray extra '}' after the function
// EXPECT: localized — small ERROR around the stray brace, not the whole file
func f() {
    g()
}}
