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


class Tree<T: Comparable> {

	 class Node{

		var data: T
		var leftNode: Node?
		var rightNode: Node?
		var height: Int

		init(data: T,
			leftNode: Node? = nil,
			rightNode: Node? = nil) {
			self.data = data
			self.leftNode = leftNode
			self.rightNode = rightNode
			self.height = 0
		}
	}

	private var rootMain: Node
	init(data: T) {
        self.rootMain = Node(data: data)
    }

    func getRoot() -> Node {
    	return rootMain
    }




	func push(root: inout Node, data: Node) {
		if (data.data > root.data)
		{
			if (root.rightNode == nil) {
				root.rightNode = data
			}
			else {
				push(root: &root.rightNode!, data: data)
			}

		}
		else if (data.data < root.data) {
			if (root.leftNode == nil) {
				root.leftNode = data
			}
			else {
				push(root: &root.leftNode!, data: data)
			}
		}
		balance(root: &root)
	}

/////////////////////// FIND FIND FIND FIND FIND FIND ///////////////////////////

	func find(root: Node, data: T) -> Bool {
		if (data == root.data)
		{
			print("\(data) is exist")
			return true
		} else if (data > root.data) {


		if (root.rightNode == nil) {
			print("\(data) is not exist")
			return false
			} else {
				return find(root: root.rightNode!, data: data)
			}

		}
		else {

			if (root.leftNode == nil) {
				print("\(data) is not exist")
				return false
			}
			else {
				return find(root: root.leftNode!, data: data)
			}
		}
	}


//////////////////// DELETE DELETE DELETE DELETE DELETE ////////////////////
	private enum node_info {
		case R_node, L_node, RL_node, no_node
	}

	func delete1(root: inout Node, data: T) 
	{
		if find(root: root, data:data) //проверка на удаление корня
		{
			if root.data == data 
			{
				switch check_nodes(root: root) {
					case .RL_node:
					push(root: &root.rightNode!, data: root.leftNode!)
					root = root.rightNode!
					case .L_node:
					root = root.leftNode!
					case .R_node:
					root = root.rightNode!	
					case .no_node:
					print("impossible")
				}
			} else {
					delete2(root: &root, data: data)	
			}
		}
	}

	private func delete2(root: inout Node, data: T) 
	{
		if root.data < data {
			if root.rightNode!.data == data
			{
				switch check_nodes(root: root.rightNode!) {
					case .RL_node:
					push(root: &root.rightNode!.rightNode!, data: root.rightNode!.leftNode!)
					root.rightNode = root.rightNode!.rightNode!
					case .L_node:
					root.rightNode = root.rightNode!.leftNode!
					case .R_node:
					root.rightNode = root.rightNode!.rightNode!	
					case .no_node:
					root.rightNode = nil
				}
				balance(root: &root)
				} else {
					delete2(root: &root.rightNode!, data: data)
				}
		} 
			else 
			{
				if root.leftNode!.data == data
				{
					switch check_nodes(root: root.leftNode!) {
						case .RL_node:
						push(root: &root.leftNode!.rightNode!, data: root.leftNode!.leftNode!)
						root.leftNode = root.leftNode!.rightNode!
						case .L_node:
						root.leftNode = root.leftNode!.leftNode!
						case .R_node:
						root.leftNode = root.leftNode!.rightNode!	
						case .no_node:
						root.leftNode = nil
					}
					balance(root: &root)
					} else {
						delete2(root: &root.leftNode!, data: data)	
					}	
			}
	}

	private func check_nodes(root: Node) -> node_info { // проаерка веток у ветки
		if (root.rightNode != nil) && (root.leftNode != nil)
		{
			return .RL_node
		} else if (root.rightNode != nil) {
			return .R_node
		} else if (root.leftNode != nil) {
			return .L_node
		} else {
				return .no_node
		}
	}

///////////////////////BALANCE BALANCE BALANCE BALANCE BALANCE BALANCE ////////////////////

	private func balance(root: inout Node) 
	{

		calcHeight(root: &root)

		if (getBalanceFactor(root: root) == 2) {
			if (getBalanceFactor(root: root.leftNode!) < 0) {
				turnLeft(root: &root.leftNode!)
			}
			turnRight(root: &root)
		}
		else if (getBalanceFactor(root: root) == -2) {
			if (getBalanceFactor(root: root.rightNode!) > 0) {
				turnRight(root: &root.rightNode!)
			}
			turnLeft(root: &root)
		}
	}

	private func calcHeight(root: inout Node) {
	switch check_nodes(root: root) {
		case .RL_node:
		if (root.leftNode!.height > root.rightNode!.height) {
			root.height = root.leftNode!.height + 1
			} else {
				root.height = root.rightNode!.height + 1
			}
			case .L_node:
			root.height = root.leftNode!.height + 1
			case .R_node:
			root.height = root.rightNode!.height + 1	
			case .no_node:
			root.height = 0
		}
	}

	private func getBalanceFactor(root: Node) -> Int {
		switch check_nodes(root: root) {
			case .RL_node:
			return root.leftNode!.height - root.rightNode!.height
			case .L_node:
			return root.leftNode!.height + 1
			case .R_node:
			return -(root.rightNode!.height + 1)
			case .no_node:
			return 0
		}    
	}

	private func turnRight(root: inout Node) {
		var newRoot = root.leftNode
		root.leftNode = root.leftNode!.rightNode //
		newRoot!.rightNode = root
		calcHeight(root: &root)
		calcHeight(root: &newRoot!)
		swap(&newRoot!, &root)
	}

	private func turnLeft(root: inout Node) {
		var newRoot = root.rightNode   //
		root.rightNode = root.rightNode!.leftNode
		newRoot!.leftNode = root
		calcHeight(root: &root)
		calcHeight(root: &newRoot!)
		swap(&newRoot!, &root)
	}
}


//////////////////////////////////////////////////////////////////////////////////////////////

var myTree = Tree<Int>(data: 50)
var rootMain = myTree.getRoot()
myTree.push(root: &rootMain, data: Tree<Int>.Node(data: 30, leftNode: nil, rightNode: nil))

for _ in 1...100 {

 	let i = Int.random(in: 1..<100)
 	myTree.push(root: &rootMain, data: Tree<Int>.Node(data: i, leftNode: nil, rightNode: nil))
}

print(myTree.find(root: rootMain, data: 67))

print(myTree.find(root: rootMain, data: 30))
myTree.delete1(root: &rootMain, data: 30)
print(myTree.find(root: rootMain, data: 30))

print(rootMain.data)
myTree.delete1(root: &rootMain, data: rootMain.data) //удаление корня
print(rootMain.data)