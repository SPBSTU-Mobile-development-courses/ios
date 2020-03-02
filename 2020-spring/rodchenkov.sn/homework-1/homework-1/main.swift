import Foundation

func isRangeInSet(low: Int, high: Int, set: MySet<Int>) {
    for i in low...high {
        print("\(i) in set? \(set.contains(i))")
    }
}

var mySet = MySet(1, 2, 3, 4, 5)
isRangeInSet(low: 1, high: 5, set: mySet)
mySet.remove(3)
isRangeInSet(low: 1, high: 5, set: mySet)
for i in 1...4 {
    mySet.remove(i)
}
isRangeInSet(low: 1, high: 5, set: mySet)
mySet.insert(3)
isRangeInSet(low: 1, high: 5, set: mySet)
mySet.remove(3)
mySet.remove(5)
print("set empty? \(mySet.empty)")
