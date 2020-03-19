import UIKit

class AvlTree<T: Comparable> {
    
    private class Node<T: Comparable> {
        var element: T
        var left: Node<T>?
        var right: Node<T>?
        var height: Int
        
        public init (element: T, left: Node<T>? = nil, right: Node<T>? = nil, height: Int = 1) {
            self.element = element
            self.left = left
            self.right = right
            self.height = height
        }
    }
    
    private var root: Node<T>?
    
    public init () {
        self.root = nil
    }
    
    private func searchNode(element: T) -> Node<T>? {
        guard var currentRoot : AvlTree<T>.Node<T>? = root else {
            return nil
        }
        while currentRoot != nil {
            if (currentRoot!.element > element) {
                currentRoot = currentRoot!.left
            } else if (currentRoot!.element < element) {
                currentRoot = currentRoot!.right
            } else {
                return currentRoot
            }
        }
        return nil
    }
    
    private func height(rootNode: Node<T>?) -> Int {
        return rootNode?.height ?? 0
    }
    
    private func fixHeight(rootNode: Node<T>?) {
        rootNode!.height = 1 + Swift.max(height(rootNode: rootNode!.left), height(rootNode: rootNode!.right))
    }
    
    private func rotateRight(rootNode: Node<T>) -> Node<T>{
        guard let left = rootNode.left else {
            return rootNode
        }
        rootNode.left = left.right
        left.right = rootNode
        fixHeight(rootNode: rootNode)
        fixHeight(rootNode: left)
        return left
    }
    
    private func rotateLeft(rootNode: Node<T>) -> Node<T> {
        guard let right = rootNode.right else {
            return rootNode
        }
        rootNode.right = right.left
        right.left = rootNode
        fixHeight(rootNode: rootNode)
        fixHeight(rootNode: right)
        return right
    }
    
    private func disbalanceHeight(rootNode: Node<T>?) -> Int {
        guard let rootNode = rootNode else {
            return 0
        }
        return height(rootNode: rootNode.left) - height(rootNode: rootNode.right)
    }
    
    private func balance(rootNode: Node<T>) -> Node<T> {
        if disbalanceHeight(rootNode: rootNode) == -2 {
            if disbalanceHeight(rootNode: rootNode.right!) > 0 {
                rootNode.right = rotateRight(rootNode: rootNode.right!)
            }
            return rotateLeft(rootNode: rootNode)
        }
        if (disbalanceHeight(rootNode: rootNode) == 2) {
            if disbalanceHeight(rootNode: rootNode.left!) < 0 {
                rootNode.left = rotateLeft(rootNode: rootNode.left!)
            }
            return rotateRight(rootNode: rootNode)
        }
        return rootNode
    }
    
    private func insertNode(rootNode: Node<T>?, element: T) -> Node<T> {
        if let rootNode = rootNode {
            if rootNode.element < element {
                rootNode.right = insertNode(rootNode: rootNode.right, element: element)
            } else if rootNode.element > element {
                rootNode.left = insertNode(rootNode: rootNode.left, element: element)
            } else {
                rootNode.element = element
                return rootNode
            }
            
            fixHeight(rootNode: rootNode)
            return balance(rootNode: rootNode)
        } else {
            return Node(element: element)
        }
    }
    
    private func removeMax(node: Node<T>?) -> Node<T>? {
        if let node = node {
            if node.right == nil {
                return node.left
            }
            node.right = removeMax(node: node.right)
            fixHeight(rootNode: node)
            return balance(rootNode: node)
        } else {
            return nil
        }
    }
    
    private func max(node: Node<T>) -> Node<T> {
        return node.right == nil ? node : max(node: node.right!)
    }
    
    private func deleteNode(rootNode: Node<T>?, element: T) -> Node<T>? {
        guard let rootNode = rootNode else {
            return nil
        }
        if element > rootNode.element {
            rootNode.right = deleteNode(rootNode: rootNode.right, element: element)
        } else if element < rootNode.element {
            rootNode.left = deleteNode(rootNode: rootNode.left, element: element)
        } else {
            if rootNode.left == nil {
                return rootNode.right
            }
            if rootNode.right == nil {
                return rootNode.left
            }
            let temp = max(node: rootNode.left!)
            temp.left = removeMax(node: rootNode.left!)
            temp.right = rootNode.right!
            
            return balance(rootNode: temp)
        }
        
        fixHeight(rootNode: rootNode)
        return balance(rootNode: rootNode)
    }
    
    public func deleteElement(element: T) -> Bool {
        if !searchElement(element: element) {
            return false
        }
        root = deleteNode(rootNode: root, element: element)
        return true
    }
    
    public func insert(element: T) {
        root = insertNode(rootNode: root, element: element)
    }
    
    public func searchElement(element: T) -> Bool {
        return searchNode(element: element) != nil;
    }
    
    private func walk(root: Node<T>?) {
        if root != nil {
            print(root!.element,separator: " ", terminator: " ")
            walk(root: root?.left)
            walk(root: root?.right)
        }
    }
    
    public func walk() {
        walk(root: root)
    }
    
}
var avlTree: AvlTree<Int> = AvlTree()

avlTree.insert(element: 4)
avlTree.insert(element: 8)
avlTree.insert(element: 7)
avlTree.insert(element: 9)
avlTree.insert(element: 10)
avlTree.insert(element: 11)
avlTree.insert(element: 3)
avlTree.insert(element: 2)
avlTree.insert(element: 1)
avlTree.walk()
//         9
//      3    10
//    2   7     11
//   1   4 8
//
avlTree.deleteElement(element: 9)
print()
avlTree.walk()
print()

//      8
//   3    10
//  2  7    11
// 1  4
//
var avlTree2: AvlTree<Int> = AvlTree()
avlTree2.insert(element: 1)
avlTree2.insert(element: 2)
avlTree2.insert(element: 3)
avlTree2.insert(element: 4)
avlTree2.insert(element: 6)
avlTree2.walk()
