class Tree<T: Comparable> {
    
    private class Node<T> {
        var value: T
        var left: Node?
        var right: Node?
        var height: Int
        
        init(value: T,
             left: Node? = nil,
             right: Node? = nil,
             height: Int = 1) {
            self.value = value
            self.left = left
            self.right = right
            self.height = height
        }
    }

    private var rootNode: Node<T>?

    func search(_ value: T) -> Bool {
        let node = Node(value: value)
        if let rootNode = self.rootNode {
            if self.search(rootNode, node) {
                return true
            }
        }
        return false
    }
    
    private func search(_ root: Node<T>, _ node: Node<T>) -> Bool {
        if node.value == root.value {
            return true
        }
        if root.value > node.value {
            if let left = root.left {
                return self.search(left, node)
            }
        }
        else {
            if let right = root.right {
                return self.search(right, node)
            }
        }
        return false
    }
    
    func minValue() -> T {
        return minValue(rootNode).value
    }

    private func minValue(_ node: Node<T>?) -> Node<T> {
        var tempNode = node
        
        while let next = tempNode?.left {
            tempNode = next
        }
        return tempNode!
    }
    
    private func removeMin(_ node: Node<T>) -> Node<T>? {
        guard let leftNode = node.left else {
            return node.right
        }
        node.left = removeMin(leftNode)
        return balance(node)
    }
    
    func insert(_ value: T) {
        let node = Node(value: value)
        if let rootNode = self.rootNode {
            self.insert(rootNode, node)
        } else {
            self.rootNode = node
        }
    }
    
    private func insert(_ root: Node<T>, _ node: Node<T>) -> Node<T> {
        if root.value > node.value {
            if let left = root.left {
                self.insert(left, node)
            } else {
                root.left = node
            }
        } else {
            if let right = root.right {
                self.insert(right, node)
            } else {
                root.right = node
            }
        }
        return balance(node)
    }
    
    
    func delete(_ value: T) {
        let node = Node(value: value)
        if let rootNode = self.rootNode {
            self.delete(rootNode, node)
        } else {
            self.rootNode = node
        }
        
    }
    
    private func delete(_ root: Node<T>?, _ node: Node<T>) -> Node<T>? {
        guard var root = root else {
            return nil
        }
        if node.value < root.value {
            root.left = delete(root.left, node)
        } else if node.value > root.value {
            root.right = delete(root.right, node)
        } else {
            guard let rightNode = root.right else {
                return root.left
            }
            
            guard let leftNode = root.left else {
                return root.right
            }
            
            root = minValue(rightNode)
            root.right = removeMin(rightNode)
            root.left = leftNode
            return balance(node)
        }
        return balance(node)
    }
    
    private func height(_ node: Node<T>?) -> Int {
        if (node == nil) {
            return 0
        }
        return node!.height
    }
    
    private func balanceCoef(_ node: Node<T>?) -> Int {
        return height(node?.right) - height(node?.left)
    }
    
    private func changeHeight(_ node: Node<T>?) {
        let left = height(node?.left)
        let right = height(node?.right)
        node?.height = max(left, right) + 1
    }
    
    private func rotateRight(_ node: Node<T>) -> Node<T> {
        let temp = node.left
        node.left = temp?.right
        temp?.right = node
        changeHeight(node)
        changeHeight(temp)
        return temp!
    }
    
    private func rotateLeft(_ node: Node<T>) -> Node<T> {
        let temp = node.right
        node.right = temp?.left
        temp!.left = node
        changeHeight(node)
        changeHeight(temp)
        return temp!
    }
    
    private func balance(_ node: Node<T>) -> Node<T> {
        changeHeight(node)
        if balanceCoef(node) == 2 {
            if balanceCoef(node.right) < 0 {
                node.right = rotateRight(node.right!)
            }
            return rotateLeft(node)
        }
        if balanceCoef(node) == -2 {
            if balanceCoef(node.left) < 0 {
                node.left = rotateLeft(node.left!)
            }
            return rotateRight(node)
        }
        return node
    }
    
    func printTreeInorder() {
        self.inorder(self.rootNode)
    }
    
    func printTreePostorder() {
        self.postorder(self.rootNode)
    }
    
    func printTreePreorder() {
        self.preorder(self.rootNode)
    }
    
    private func inorder(_ node: Node<T>?) {
        guard let _ = node else {
            return
        }
        self.inorder(node?.left)
        print("\(node!.value)", terminator: " ")
        self.inorder(node?.right)
    }
    
    private func preorder(_ node: Node<T>?) {
        guard let _ = node else {
            return
        }
        print("\(node!.value)", terminator: " ")
        self.preorder(node?.left)
        self.preorder(node?.right)
    }
    
    private func postorder(_ node: Node<T>?) {
        guard let _ = node else {
            return
        }
        self.postorder(node?.left)
        self.postorder(node?.right)
        print("\(node!.value)", terminator: " ")
    }
    
}


let numberList : Array<Int> = [8, 2, 10, 9, 11, 1, 7]
var root = Tree<Int>()
for number in numberList {
    root.insert(number)
}

print("Inorder:")
root.printTreeInorder()

print("\n-------------")
print("Postorder:")
root.printTreePostorder()

print("\n-------------")
print("Preorder:")
root.printTreePreorder()

print("\n-------------")
print("Is there 7?\n")
print(root.search(7))

print("\n-------------")
print("Is there 111?\n")
print(root.search(111))


print("\n-------------")
print("min value\n")
print(root.minValue())

print("\n-------------")
print("delete 9\n")
root.delete(9)

root.printTreeInorder()
