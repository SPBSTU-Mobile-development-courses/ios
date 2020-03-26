import Foundation
 
class Node<T: Comparable> {
    var value: T
    var height: Int
    var left: Node?
    var right: Node?
   
    init(value: T, height: Int, left: Node?, right: Node?) {
        self.value = value
        self.height = height
        self.left = left
        self.right = right
    }
}
 
class Tree<T: Comparable> {
    var root: Node<T>?
   
    init(value: T) {
        root = Node<T>(value: value, height: 1, left: nil, right: nil)
    }
   
    init () {
        root = nil
    }
   
    func remove(value: T) {
      print("\n REMOVING \(value)")
      root = remove(node: root, value: value)
    }
   
    func insert(value: T) {
        root = insert(node: root, value: value)
    }
   
    func search(value: T) {
      if (!search(node: root, value: value))
         {print("Tree does not contain element \(value)")}
  }
    
    func printTree(){
        print(" PREORDER")
        preOrder(self.root)
    }
   
    private func height(node: Node<T>?) -> Int {
        return node?.height ?? 0
    }
   
    private func balanceFactor(node: Node<T>?) -> Int {
        return height(node: node?.right) - height(node: node?.left)
    }
   
    private func fixHeight(node: Node<T>?) {
        let leftHeight = height(node: node?.left)
        let rightHeight = height(node: node?.right)
        node?.height = max(leftHeight, rightHeight) + 1
    }
   
    private func rightRotate(node: Node<T>) -> Node<T> {
        let tmp = node.left
        node.left = tmp?.right
        tmp?.right = node
        fixHeight(node: node)
        fixHeight(node: tmp)
        return tmp!
    }
   
    private func leftRotate(node: Node<T>) -> Node<T> {
        let tmp = node.right
        node.right = tmp?.left
        tmp?.left = node
        fixHeight(node: node)
        fixHeight(node: tmp)
        return tmp!
    }
   
    private func balance(node: Node<T>?) -> Node<T>? {
      guard let node = node else {return nil}
        fixHeight(node: node)
        if balanceFactor(node: node) == 2 {
            if balanceFactor(node: node) < 0 {
              node.right = rightRotate(node: node.right!)
            }
            return leftRotate(node: node)
        }
        if balanceFactor(node: node) == -2 {
            if balanceFactor(node: node) < 0 {
                node.left = leftRotate(node: node.left!)
            }
            return rightRotate(node: node)
        }
        return node
    }
  
   
    private func search(node: Node<T>?, value: T) -> Bool {
      guard let node = node else {return false}
      let nodeValue = node.value
      if value == node.value {
        print("Tree contains element \(value)")
        return true
      } else if value < nodeValue {
        search(node: node.left, value: value)
      } else if value > nodeValue {
        search(node: node.right, value: value)
      }
      return false
    }

   
    private func insert(node: Node<T>?, value: T) -> Node<T>? {
        if node == nil {
            return Node(value: value, height: 1, left: nil, right: nil)
        }
        if value < node!.value {
            node?.left = insert(node: node?.left, value: value)
        } else {
            node?.right = insert(node: node?.right, value: value)
        }
        return balance(node: node)
    }
   
    private func findMin(node: Node<T>?) -> Node<T>? {
      guard let node = node else {return nil}
      if node.left == nil {
          return node
      }
      node.left = findMin(node: node.left)
      fixHeight(node: node)
      return balance(node: node)
    }
    
   
    private func removeMin(node: Node<T>?) -> Node<T>? {
      guard let node = node else {return nil}
      if node.left == nil {
        return node.right
      }
      node.left = removeMin(node: node.left!)
      return balance(node: node)
    }
   
    private func remove(node: Node<T>?, value: T) -> Node<T>? {
        if node == nil {return nil}
        if value < node!.value {
            node?.left = remove(node: node?.left, value: value)
        } else if (value > node!.value) {
            node?.right = remove(node: node?.right, value: value)
        } else {
            let tmp1 = node?.left
            let tmp2 = node?.right
            if tmp2 == nil {return tmp1}
            let min = findMin(node: tmp2)
            min!.right = removeMin(node: tmp2)
            min!.left = tmp1
            return balance(node: min!)
        }
        return balance(node: node!)
    }
   
    private func preOrder(_ node: Node<T>?) {
        if node == nil { return } else {
            print("\(node!.value)", terminator: " ")
            self.preOrder(node?.left)
            self.preOrder(node?.right)
        }
    }
}
 
var tree = Tree<Int>(value: 1)
tree.insert(value: 2)
tree.insert(value: 3)
tree.insert(value: 4)
tree.insert(value: 5)
tree.search(value: 2)
tree.search(value: 7)
tree.printTree()
tree.remove(value: 1)
tree.printTree()
