class BinaryTree<T: Comparable> {
    private class Node<T> {
        var value: T
        var level: Int
        var counter: Int
        var left: Node?
        var right: Node?

        init(value: T, level: Int = 1, counter: Int = 1, left: Node? = nil, right:Node? = nil) {
            self.value = value
            self.level = level
            self.counter = counter
            self.left = left
            self.right = right
        }
    }

    private var root: Node<T>?

    init() {
        root = nil
    }

    init(value: T) {
        root = Node<T>(value: value)
    }

    func insert(value: T) {
        guard let root = root else {
            self.root = Node(value: value)
            return
        }
        insert(root: root, node: Node(value: value))
    }

     private func insert(root: Node<T>, node: Node<T>) -> Node<T>? {
         if root.value == node.value {
             root.counter += 1
             return nil
         } else if root.value > node.value {
             if let left = root.left {
                 self.insert(root: left, node: node)
             } else {
                 root.left = node
             }
         } else {
             if let right = root.right {
                 self.insert(root: right, node: node)
             } else {
                 root.right = node
             }
        }
        return balance(node: node)
    }

    func remove(value: T) {
        remove(node: &root, value: value)
    }

    private func remove(node: inout Node<T>?, value:T) -> Node<T>? {
        guard let tempNode = node else {
            return nil
        }
        if value < tempNode.value {
            remove(node: &tempNode.left, value: value)
        } else if value > tempNode.value {
            remove(node: &tempNode.right, value: value)
        } else if tempNode.counter > 1 {
            tempNode.counter -= 1
            return nil
        } else {
            let left = tempNode.left
            guard let right = tempNode.right else {
                return left
            }
           let min = findMin(node: right)
           min.left = left
           return balance(node: min)
        }
        return balance(node: tempNode)
    }

    func find(value: T) {
        print(value, find(node: root, value: value) != nil ? "is included in a tree" : "isn't included")
    }

     private func find(node: Node<T>?, value: T) -> Node<T>? {
         guard let tempNode = node else {
             return nil
        }
        if value == tempNode.value {
            return node
        } else if value < tempNode.value {
            return find(node: tempNode.left, value: value)
        } else {
            return find(node: tempNode.right, value: value)
        }
    }

    func printTree() {
        printInOrder(node: root)
        print()
    }

    private func printInOrder(node: Node<T>?) {
        guard let tempNode = node else {
            return
        }
        self.printInOrder(node: tempNode.left)
        for _ in 1...tempNode.counter {
            print("\(tempNode.value)", terminator:" ")
        }
        self.printInOrder(node: tempNode.right)
    }

    private func getLevel(node: Node<T>?) -> Int {
        return node?.level ?? 0
    }

    private func balanceFactor(node: Node<T>?) -> Int {
        return getLevel(node: node?.right) - getLevel(node: node?.left)
    }

    private func fixLevel(node: Node<T>?) {
        let left = getLevel(node: node?.left)
        let right = getLevel(node: node?.right)
        node?.level = max(left, right) + 1
    }

    private func rotateRight( node: Node<T>) -> Node<T> {
        guard let left = node.left else {
            return node
        }
        node.left = left.right
        left.left = node
        fixLevel(node: node)
        fixLevel(node: left)
        return left
    }

    private func rotateLeft(node: Node<T>) -> Node<T> {
        guard let right = node.right else {
            return node
        }
        node.right = right.left
        right.left = node
        fixLevel(node: node)
        fixLevel(node: right)
        return right
    }

    private func balance(node: Node<T>) -> Node<T> {
        fixLevel(node: node)
        if balanceFactor(node: node) == 2 {
            if balanceFactor(node: node.right) < 0 {
                guard let right = node.right else {
                    return node
                }
                node.right = rotateRight(node: right)
            }
            return rotateLeft(node: node)
        }
        if balanceFactor(node: node) == -2 {
            if balanceFactor(node: node.left) < 0 {
                guard let left = node.left else {
                    return node
                }
                node.left = rotateLeft(node: left)
            }
            return rotateRight(node: node)
        }
        return node
    }

    private func findMin(node: Node<T>) -> Node<T> {
        guard let left = node.left else {
            return node
        }
        return findMin(node: left)
    }

    private func removeMin(node: Node<T>) -> Node<T>? {
        guard let left = node.left else {
            return node.right
        }
        node.left = removeMin(node: left)
        return balance(node: node)
    }
}

var tree = BinaryTree<Int>(value: 1)
tree.insert(value: 5)
tree.insert(value: 5)
tree.insert(value: 2)
tree.insert(value: 4)
tree.insert(value: 3)
tree.printTree()
tree.remove(value: 5)
tree.printTree()
tree.remove(value: 2)
tree.printTree()
tree.find(value: 3)
