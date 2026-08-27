// BREAK: two identifiers in a row (the classic Diekmann-Tratt example)
// EXPECT: localized — small ERROR around `y`, or repairs: delete y / insert ',' / insert '='
class C {
    var x: Int y: Int
}
