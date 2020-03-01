/*:
 * Array<T>, Dictionary<Key, Value>, Set<T>, String
 * Value types
 * замыкания (closure)
 * map, reduce, filter
 * Copy-on-write
 */

var numbers = [1, 2, 3]

print(numbers.map { $0 * 2 }.reduce(5, +))
