/*: [Previous](@previous)

 * константами или изменяемыми
 * хранимые или вычисляемые
 * следим за изменением значения
 * «ленивая» инициализация
 * принадлежат экземпляру или типу
 * при наследовании могут быть переопределены
*/
class Foo {
    var string: String = "one" {
        willSet {
            print("Will change to new value - \(newValue)")
            print("Current - \(string)")
        }
        didSet {
            print("Did change from old value - \(oldValue)")
            print("Current - \(string)")
        }
    }
    
    var stringLength: Int {
        return string.count
    }
    
    lazy var stringLengthDoubled: Int = { stringLength * 2 } ()
    
    let const: Int
    var constVar: Int
    
    init() {
        const = 1
        constVar = 2
    }
}

//let foo = Foo()
//print(foo.stringLength)
//foo.string = "two"
//print(foo.stringLength)
//print(foo.stringLengthDoubled)



//_____________
class Boo: Foo {
    override var string: String {
        get { return "This is an instance of Boo" }
        set { super.string = newValue }
    }

    override var stringLength: Int {
        return string.count + 1
    }
}

let boo = Boo()
print(boo.stringLength)
