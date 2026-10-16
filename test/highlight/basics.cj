package demo
//^ @keyword.import
//       ^ @module

import std.math.*
//^ @keyword.import
//     ^ @module
//              ^ @punctuation.special
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
//      ^ @variable.member
//            ^ @type.builtin
//                    ^ @operator
//                      ^ @number.float

    func scale<F, R>(k: F, v: Int64): Unit where F <: Number {
//  ^ @keyword.function
//       ^ @function.method
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
//               ^ @punctuation.delimiter
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
//                  ^ @function.macro
//                   ^ @function.macro
//                        ^ @number
//                           ^ @function.macro
//                            ^ @markup.raw

  @Attr[flag = true]
//^ @function.macro
// ^ @function.macro
//     ^ @function.macro
//           ^ @operator
//             ^ @constant.builtin
//                 ^ @function.macro

let r = quote(1 + @PlusOne(x) * 2)
//                     ^ @function.macro
//               ^ @markup.raw

class Box {
    @Deprecated let y: Int64 = 0
//                  ^ @variable.member
    const c = 1
//        ^ @constant
    @Anno const d = 2
//              ^ @constant
    let u = ()
//          ^ @constant.builtin
    func m() {}
//       ^ @function.method
    static func sm() {}
//              ^ @function.method
}

main() {
    let s = f { x => x }
//          ^ @function.call
    let t = p.q { x => x }
//            ^ @function.method.call
    let v = a.b.c { x => x }
//            ^ @variable.member
//              ^ @function.method.call
}
