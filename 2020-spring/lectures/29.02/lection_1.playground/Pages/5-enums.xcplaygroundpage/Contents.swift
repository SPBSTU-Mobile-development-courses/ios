/*:
 * хранятся по значению
 * могут иметь raw value
 * могут иметь associated value
 * есть слово indirect
 */
//
//enum Mobile: String {
//    case android = "💩"
//    case ios = "🍏"
//}
//
//print(Mobile.android.rawValue)
//
//let mobile = Mobile.ios
//
//switch mobile {
////case .android:
////    print("ЗП - 100K/м")
//case .ios:
//    print("ЗП - 300K/нс")
//default:
//    print("Не нужно")
//}






//____________
//enum Barcode {
//    case upc(Int, Int, Int, Int)
//    case qrCode(String)
//}
//
//var productBarcode = Barcode.upc(8, 85909, 51226, 3)
//productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
//
//switch productBarcode {
//case let .upc(numberSystem, manufacturer, product, check):
//    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
//case let .qrCode(productCode):
//    print("QR code: \(productCode).")
//}
//





//_______________
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
//
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
//
print(evaluate(product))
