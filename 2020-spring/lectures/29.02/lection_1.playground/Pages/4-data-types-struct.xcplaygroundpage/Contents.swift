/*:
 * при присваивании копируется
 * живут в стеке
 * изменение части = перезапись всей переменной целиком
 * не поддерживают наследование
 */

struct Foo {
    var property: Int

}

let one = Foo(property: 1)
var two = one
two.property = 2

print(one.property)
print(two.property)


//________________
func changeToFive(foo: inout Foo) {  //inout для того чтоб менять можно было, иначе констатанта
    foo.property = 5
}

var zero = Foo(property: 0)
changeToFive(foo: &zero)
print(zero.property)
