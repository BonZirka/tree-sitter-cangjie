import std.math.*
//^ @keyword.import
//     ^ @module
//              ^ @operator
import std.io as Io
//     ^ @module
//               ^ @module

class Shape<T> <: Pane {
//^ @keyword.type
//    ^ @type
//          ^ @type
//             ^ @operator
//                ^ @type

    let area: Float64 = 1.5
//  ^ @keyword
//      ^ @variable
//            ^ @type.builtin
//                    ^ @operator
//                      ^ @number.float

    func scale<F, R>(k: F, v: Int64): Unit where F <: Number {
//  ^ @keyword.function
//       ^ @function
//             ^ @type
//                ^ @type
//                   ^ @variable.parameter
//             ^ @type
//                         ^ @variable.parameter
//                            ^ @type.builtin
//                                    ^ @type.builtin
//                                         ^ @keyword
//             ^ @type
//                                                 ^ @operator
//                                                    ^ @type
        this.area = k ?? 1.5
//      ^ @variable.builtin
//           ^ @variable.member
//                ^ @operator
//                    ^ @operator
//                       ^ @number.float
        let msg = "pi=${k} end"
//      ^ @keyword
//          ^ @variable
//                 ^ @string
//                    ^ @punctuation.special
//                       ^ @punctuation.special
        let q = quote(var $v = $(w.x))
//              ^ @keyword
//                        ^ @variable.builtin
//                         ^ @variable.parameter
//                             ^ @variable.builtin
//                                 ^ @variable.member
//                                  ^ @variable.builtin
    }
}

enum Color { Red | Green }
//^ @keyword.type
//   ^ @type
//           ^ @constant
//               ^ @operator
//                 ^ @constant

main() {
//^ @function
    let f = obj.field()
//  ^ @keyword
//      ^ @variable
//              ^ @function.method.call
}

macro mk(x: Expr) { @body(1) }
//^ @keyword
//    ^ @function.macro
//                  ^ @attribute
//                   ^ @attribute
//                       ^ @attribute
//                         ^ @attribute

  @Attr[flag = true]
//^ @attribute
// ^ @attribute
//     ^ @attribute
//      ^ @markup.raw

let r = quote(1 + @PlusOne(x) * 2)
//                     ^ @function.macro
//               ^ @markup.raw
