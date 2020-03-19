//
//  main.swift
//  Tree
//
//  Created by Kirill Chistyakov on 06.03.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//
class HappyTree<T: Comparable> {
    class Node<T: Comparable> {
        private(set) var value: T?
        var parent: Node?
        var left: Node?
        var right: Node?
        var balanceFactor: Int {
            return (right?.height() ?? 0) - (left?.height() ?? 0)
        }
        init(value: T? = nil) {
            self.value = value
        }
        public func height() -> Int {
            if left == nil && right == nil { return 0 }
            return 1 + Swift.max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }

    private(set) var root: Node<T>
    private(set) var size = 0
    public init(value: T? = nil) {
        self.root = Node(value: value)
    }

    private func insert(node: Node<T>?, value: T) -> Node<T> {
        guard let node = node else {
            return Node(value: value)
        }
        guard let nodeValue = node.value else { return Node() }
        if value < nodeValue {
            if node.left == nil {
                let newNode = Node(value: value)
                newNode.parent = node
                node.left = newNode
            } else {
                node.left = insert(node: node.left, value: value)
            }
        } else {
            if node.right == nil {
                let newNode = Node(value: value)
                newNode.parent = node
                node.right = newNode
            } else {
                node.right = insert(node: node.right, value: value)
            }
        }

        return balance(node: node)
    }
    public func delete(value: T) {
        let nodeToDelete = search(value: value)
        if let nodeToDelete = nodeToDelete {
            delete(node: nodeToDelete)
        } else {
            return
        }
    }

    private func delete(node: Node<T>) {
        let replacement: Node<T>?

        if let right = node.right {
            replacement = min(node: right)
        } else if let left = node.left {
            replacement = max(node: left)
        } else {
            replacement = nil
        }

        if let replacement = replacement {
            delete(node: replacement)
        }

        replacement?.right = node.right
        replacement?.left = node.left
        node.right?.parent = replacement
        node.left?.parent = replacement
        if let parent = node.parent {
            if parent.left === node {
                parent.left = replacement
            } else {
                parent.right = replacement
            }
        }

        if let parent = replacement?.parent {
            if parent.left === node {
                parent.left = nil
            } else {
                parent.right = nil
            }
        }

        replacement?.parent = node

        if node === root, let replacement = replacement {
            root = replacement
            replacement.parent = nil
        }

        var balanceNode = replacement != nil ? replacement : node
        while balanceNode != nil {
            if var balanceNode = balanceNode {
                balanceNode = balance(node: balanceNode)
            }
            balanceNode = balanceNode?.parent
        }

        node.parent = nil
        node.left = nil
        node.right = nil
    }

    public func getSuccessor(node: Node<T>) -> Node<T> {
        var leftSuccess: Node = node
        var rightSuccess: Node = node
        if let left = node.left {
            leftSuccess = max(node: left)
        }
        if let right = node.right {
            rightSuccess = min(node: right)
        }

        if leftSuccess !== node && rightSuccess !== node {
            guard let leftSuccessValue = leftSuccess.value, rightSuccess.value != nil  else {
                return node
            }
            return leftSuccessValue < leftSuccessValue ? leftSuccess : rightSuccess
        } else if leftSuccess !== node {
            return leftSuccess
        } else if rightSuccess !== node {
            return rightSuccess
        } else {
            return node
        }

    }

    public func min() -> Node<T> {
        return min(node: root)

    }
    private func min(node: Node<T>) -> Node<T> {
        var next = node.left
        while next?.left != nil {
            next = next?.left
      }
        guard let returnValue = next else {
            return node
        }
        return returnValue
    }

    public func max() -> T {
        let maxNode = max(node: root)
        return maxNode.value!
    }
    private func max(node: Node<T>) -> Node<T> {
            var next = node.right
            while next?.right != nil {
                next = next?.right
          }
            guard let returnValue = next else {
                return node
            }
            return returnValue
    }

    private func balance(node: Node<T>) -> Node<T> {
        if node.balanceFactor == -2, let left = node.left {
            if left.balanceFactor <= 0 {
                return leftLeftCase(node: node)
            } else {
                return leftRightCase(node: node)
            }
        } else if node.balanceFactor == 2, let right = node.right {
            if right.balanceFactor >= 0 {
                return rightRightCase(node: node)
            } else {
                return rightLeftCase(node: node)
            }
        }
        return node
    }

    private func leftLeftCase(node: Node<T>) -> Node<T> {
        return rightRotation(node: node)
    }
    private func rightRightCase(node: Node<T>) -> Node<T> {
        return leftRotation(node: node)
    }
    private func leftRightCase(node: Node<T>) -> Node<T> {
        if let left = node.left {
            node.left = leftRotation(node: left)
        }
        return leftLeftCase(node: node)
    }
    private func rightLeftCase(node: Node<T>) -> Node<T> {
        if let right = node.right {
            node.right = rightRotation(node: right)
        }
        return rightRightCase(node: node)
    }

    private func printBT(prefix: String, node: Node<T>?, isLeft: Bool) {
        if let node = node, let nodeValue = node.value {
            print(prefix, terminator: "")
            print(isLeft ? "├──" : "└──", terminator: "")
            print(nodeValue, terminator: "")
            print()
            printBT(prefix: (prefix + (isLeft ? "│   " : "    ")), node: node.left, isLeft: true)
            printBT(prefix: (prefix + (isLeft ? "│   " : "    ")), node: node.right, isLeft: false)
        }
    }

    public func printBT() {
        printBT(prefix: "", node: root, isLeft: false)
    }

    private func rightRotation(node: Node<T>) -> Node<T> {
        let parentNode = node.parent
        guard let replacement = node.left else { return Node() }
        node.parent = replacement
        if let parentNode = parentNode {
            replacement.parent = parentNode
        } else {
            replacement.parent = nil
        }

        if let parentNode = parentNode, parentNode.left === node {
            parentNode.left = replacement
        } else {
            parentNode?.right = replacement
        }
        node.left = replacement.right
        replacement.right?.parent = node
        replacement.right = node
        if node === root {
            root = replacement
            return replacement
        } else {
            return replacement

        }
    }

    private func leftRotation(node: Node<T>) -> Node<T> {
        let nodeParent = node.parent
        guard let replacement = node.right else { return Node() }
        node.parent = replacement
        if let nodeParent = nodeParent {
            replacement.parent = nodeParent
        } else {
            replacement.parent = nil
        }

        if let nodeParent = nodeParent, nodeParent.left === node {
            nodeParent.left = replacement
        } else {
            nodeParent?.right = replacement
        }
        node.right = replacement.left
        replacement.left?.parent = node
        replacement.left = node
        if node === root {
            root = replacement
            return replacement
        } else {
            return replacement

        }

    }

    public func search(value: T) -> Node<T>? {
        return search(node: root, value: value)
    }

    private func search(node: Node<T>?, value: T) -> Node<T>? {
        if let node = node, let nodeValue = node.value {
            if value == node.value {
                return node
            } else if value < nodeValue {
                return search(node: node.left, value: value)
            } else {
                return search(node: node.right, value: value)
            }
        } else {
            return nil
        }

      }

    public func insert(value: T) {
        guard root.value != nil else {
            self.root = Node(value: value)
            return
        }
        if search(value: value) == nil {
            insert(node: root, value: value)
        }
    }
}

// Балансирующее, счастливое дерево.
/*
    Получилось как-то странно, я по-моему погряз в Optional'ах.
    Десятки проверок на nil, даже не всегда нужных.
    Буду раз узнать, как можно сделать все это более swift-like.
 
    .search  для поиска
    .insert  для вставки
    .delete  для удаления
    .printBT для вывода
 */

var tree = HappyTree<Int>(value: 0)
//tree.insert(value: 15)
//tree.insert(value: 9)
//tree.insert(value: 12)
//tree.insert(value: 2)
//tree.insert(value: 8)
//tree.insert(value: 9)
//tree.insert(value: 24)
//tree.insert(value: 19)
//tree.insert(value: 20)
//tree.insert(value: 18)
//tree.insert(value: 17)
//tree.insert(value: 4)

for index in stride(from: 145, to: 1, by: -1) {
    tree.insert(value: index)
}

tree.delete(value: 4)
tree.delete(value: 2)
tree.delete(value: 3)
tree.delete(value: 3)
tree.printBT()

print()
