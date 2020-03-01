/*:
 * дженерик позволяет сделать «заготовку» типа, функции, переменной
 * использование дженерик-типов без однозначной спецификации запрещено
 * определенные условия на дженерики
 * SomeClass<String> и SomeClass<Int> - разные типы
 * дженерик типы не могут иметь статических методов/функций
 */

func swapTwoDoubles<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<Int>()
stackOfStrings.push(1)
//stackOfStrings.push("dos")
//stackOfStrings.push("tres")
//stackOfStrings.push("cuatro")







func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}


