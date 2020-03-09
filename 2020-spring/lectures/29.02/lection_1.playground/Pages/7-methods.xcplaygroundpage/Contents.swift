/*: [Previous](@previous)

 * private / fileprivate / internal / open / public
 * «внешнее» и «внутреннее» именование параметров
 * значения параметров по умолчанию
 * принадлежат как экземпляру, так и типу
 * при наследовании могут быть переопределены
 * у value-типов делятся на mutating и non-mutating
 */
class Utils {
    static func print(value: Int) {
        print("[DEBUG] \(value)")
    }
}

Utils.print(value: 10)

//func count(fromStart start: Int = 5, to end: Int = 6) {
//    var counter = start
//    while counter < end {
//        counter += 1
//        print(counter)
//    }
//}
//
//count(to: 5)
//count()

//struct MyStruct {
//    var variable = "String"
//
//    mutating func updateVariable(_ variable: String) {
//        self.variable = variable
//    }
//}
