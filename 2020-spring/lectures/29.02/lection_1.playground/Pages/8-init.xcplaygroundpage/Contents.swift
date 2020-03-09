/*:
 * все поля должны быть заданы до обращения
 * у struct есть конструктор по умолчанию memberwise
 * конструктор можно наследовать
 * memberwise, designated, required, convenience
 https://docs.swift.org/swift-book/LanguageGuide/Initialization.html
 * конструктор может быть ”failable”
 
 */

class Foo {
    let a: String
    var b: Int
    
    init(a: String = "String", b: Int = 5) {
        self.a = a
        self.b = b
        cantDoThis()
    }
    
    init(a: String) {
        self.a = a
        self.b = 6
    }
    
    func cantDoThis() {
    }
}


class Boring {
    let a: String
    
    init(a: String) {
        self.a = a
    }
    
    convenience init() {
        self.init(a: "a")
    }
    
    init?(checked: String) {
        if checked != "a" {
            return nil
        }
        self.a = checked
    }
}

let boring = Boring(checked: "b")


struct MyStruct {
    var a: String
    var b: String
    
    public init(a: String, b: String) {
        
    }
}

let my = MyStruct(a: "a", b: "b")
