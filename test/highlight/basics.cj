import std.math.*
//^ @keyword
//     ^ @module
//              ^ @operator
import std.io as Io
//     ^ @module
//               ^ @module

class Shape<T> <: Pane {
//^ @keyword
//    ^ @type
//          ^ @type
//             ^ @operator
//                ^ @type

    let area: Float64 = 1.5
//  ^ @keyword
//      ^ @variable
//            ^ @type.builtin
//                    ^ @operator
//                      ^ @number

    func scale<F, R>(k: F, v: Int64): Unit where F <: Number {
//  ^ @keyword
//       ^ @function
//             ^ @type
//                ^ @type
//                   ^ @parameter
//             ^ @type
//                         ^ @parameter
//                            ^ @type.builtin
//                                    ^ @type.builtin
//                                         ^ @keyword
//             ^ @type
//                                                 ^ @operator
//                                                    ^ @type
        this.area = k ?? 1.5
//      ^ @variable.builtin
//           ^ @property
//                ^ @operator
//                    ^ @operator
//                       ^ @number
        let msg = "pi=${k} end"
//      ^ @keyword
//          ^ @variable
//                 ^ @string
//                    ^ @punctuation.special
//                       ^ @punctuation.special
        let q = quote(var $v = $(w.x))
//              ^ @keyword
//                        ^ @variable.builtin
//                         ^ @parameter
//                             ^ @variable.builtin
//                                 ^ @property
//                                  ^ @variable.builtin
    }
}

enum Color { Red | Green }
//^ @keyword
//   ^ @type
//           ^ @constant
//               ^ @operator
//                 ^ @constant

main() {
//^ @keyword
    let f = obj.field()
//  ^ @keyword
//      ^ @variable
//              ^ @function
}

macro mk(x: Expr) { @body(1) }
//^ @keyword
//    ^ @function.macro
//                  ^ @punctuation.special
//                   ^ @function.macro
//                       ^ @punctuation.special
//                         ^ @punctuation.special

  @Attr[flag = true]
//^ @punctuation.special
// ^ @function.macro
//     ^ @punctuation.special
//      ^ @markup.raw

let r = quote(1 + @PlusOne(x) * 2)
//                     ^ @function.macro
//               ^ @markup.raw
