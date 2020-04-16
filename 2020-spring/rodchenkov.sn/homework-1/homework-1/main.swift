import Foundation

var mySet = MySet(1, 2, 3, 4, 5)
assert(mySet.size == 5)
for i in 1...5 {
    assert(mySet.contains(i))
}
assert(mySet.remove(3))
assert(mySet.contains(3) == false)
for i in [1, 2, 4, 5] {
    assert(mySet.contains(i))
}
for i in 1...2 {
    assert(mySet.remove(i))
}
assert(mySet.size == 2)
