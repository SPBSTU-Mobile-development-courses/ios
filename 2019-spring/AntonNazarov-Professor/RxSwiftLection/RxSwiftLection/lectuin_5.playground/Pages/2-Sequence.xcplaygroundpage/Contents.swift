/*
 public protocol IteratorProtocol {
    associatedtype Element

    public mutating func next() -> Self.Element?
 }
 */

/*
 public protocol Sequence {
    associatedtype Iterator : IteratorProtocol

    func makeIterator() -> Self.Iterator
 }
 */

let array = [1, 2, 3, 4]

var iterator = array.makeIterator()

while let element = iterator.next() {
    print(element)
}
