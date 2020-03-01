/*:
 * ссылочный тип
 * живут в куче
 * при присвоении копируется указатель на объект в памяти
 * изменение части не меняет переменную
 * поддерживает наследование
 */

class Foo {
    var property: Int
    
    init(property: Int) {
        self.property = property
    }
}

let one = Foo(property: 1)
let two = one
two.property = 2
//
print(one.property)
print(two.property)



//________________

func changeToFive(foo: Foo) {
    foo.property = 5
}

let zero = Foo(property: 0)
changeToFive(foo: zero)
print(zero.property)
