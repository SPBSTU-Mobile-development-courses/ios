/*: [Previous](@previous)

 * private / fileprivate / internal / open / public
 * «внешнее» и «внутреннее» именование параметров
 * значения параметров по умолчанию
 * принадлежат как экземпляру, так и типу
 * при наследовании могут быть переопределены
 * у value-типов делятся на mutating и non-mutating
 */



class Utils {
    static func printing(value: Int) {
        print("\(value)")
    }
}

Utils.printing(value: 10)

func count(fromStart start: Int = 5, to end: Int = 6) {
   var counter = start
   while counter < end {
       counter += 1
       print(counter)
   }
}

count(to: 5)
count()

struct MyStruct {
   var variable = "String"
   mutating func updateVariable(_ variable: String) {  //для изменеия свойств структуры используем mutating
       self.variable = variable
   }
}
