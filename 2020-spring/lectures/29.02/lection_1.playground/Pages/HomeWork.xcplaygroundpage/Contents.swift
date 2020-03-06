/*:
### Самостоятельно прочитать про:
* Protocol Oriented Programming
* Closures
* Automatic Reference Counting (ARC)
* Copy-on-write

### Реализовать структуру данных Бинарное дерево. Что должно уметь:
* добавлять элемент;
* удалять элемент;
* искать элемент;
* выполнять балансировку;
* работать с разными типами данных

### Материалы
* [Swift.org](https://swift.org)/[swiftbook.ru](https://swiftbook.ru/content/languageguide)
* [iOS-Developer-Roadmap](https://github.com/BohdanOrlov/iOS-Developer-Roadmap)

*/





var i = Int.random(in: 1..<1000)


class Node {

	var data: Int
	var leftNode: Node?
	var rightNode: Node?

	init(data: Int,
		leftNode: Node? = nil,
		rightNode: Node? = nil) {
		self.data = data
		self.leftNode = leftNode
		self.rightNode = rightNode
	}

}

var rootMain = Node(data: 50, leftNode: nil, rightNode: nil)

var elem = Node(data: 40, leftNode: nil, rightNode: nil)


func push(root: Node, data: Node) {
	if (data.data > root.data)
	{
		if (root.rightNode == nil) {
			root.rightNode = data
		}
		else {
			push(root: root.rightNode!, data: data)
		}

	}
	else {
		if (root.leftNode == nil) {
			root.leftNode = data
		}
		else {
			push(root: root.leftNode!, data: data)
		}
	}
}


for _ in 1...50 {

	i = Int.random(in: 1..<100)
	push(root: rootMain, data: Node(data: i, leftNode: nil, rightNode: nil))
}

push(root: rootMain, data: elem)
print(rootMain.leftNode!.data)

/////////////////////// FIND FIND FIND FIND FIND FIND ///////////////////////////
func find(root: Node, data: Int) {
	if (data == root.data)
	{
		print("exist")
	} else if (data > root.data) {


			if (root.rightNode == nil) {
				print("\(data) is not exist")
			} else {
				find(root: root.rightNode!, data: data)
			}

	}
	else {

			if (root.leftNode == nil) {
				print("\(data) not exist")
			}
			else {
				find(root: root.leftNode!, data: data)
			}
		}
}

find(root: rootMain, data: 67)

//////////////////// DELETE DELETE DELETE DELETE DELETE ////////////



func delete1(root: inout Node, data: Int) {
	if root.data == data
	{
		if (root.rightNode == nil) {
			if (root.leftNode == nil) {
				root = nil
			}
		} 
		push(root: root.rightNode!, data: root.leftNode!)
		root = rootMain.rightNode!
		print("\(data) not exist")
	}else if (data > root.data) {

			if (root.rightNode == nil) {
				print("\(data) is not exist")
			} else {
				delete1(root: &root.rightNode!, data: data)
			}

	}
	else {

			if (root.leftNode == nil) {
				print("\(data) is not exist")
			}
			else {
				delete1(root: &root.leftNode!, data: data)
			}
	}
}


delete(root: &rootMain, data: 67)