// BREAK: match case missing '=>'
// EXPECT: localized — small ERROR around the broken case, other cases still parse
func f(x: T) {
    match (x) {
        case A => 1
        case B 2
        case C => 3
    }
}
