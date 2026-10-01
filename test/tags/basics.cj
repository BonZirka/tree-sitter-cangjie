enum Color {
//   ^definition.enum
    Red | Green
//  ^definition.class
//        ^definition.class
}

struct Money {
//     ^definition.struct
    let cents: Int64
//      ^definition.variable
}

class Account {
//    ^definition.class
    prop balance: Money {
//       ^definition.property
//                ^reference.type
        get() { 0 }
    }
    func deposit(amount: Money): Money {
//       ^definition.function
//               ^definition.parameter
//                       ^reference.type
//                       ^reference.type
        self.balance = amount
    }
}

interface Visitor {
//        ^definition.interface
    func visit(e: Empty): Unit
//       ^definition.function
}

func make(): Account {
//   ^definition.function
//           ^reference.type
    return Account()
//         ^reference.call
}

main() {
    let acc = make()
//            ^reference.call
    acc.deposit(10)
}
