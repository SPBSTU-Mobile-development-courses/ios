import UIKit
import PlaygroundSupport

class Node<T>{
    var data: T
    var height: Int
    var left: Node?
    var right: Node?
    
    init(data: T)
    {
        self.data = data
        self.height = 1
        self.right = nil
        self.left = nil
    }
}

class Tree<T: Comparable>{
    
    var root:Node<T>?
    
    private func getHeight(_ node: Node<T>?)->Int {
            return node?.height ?? 0
    }
    
    private func balanceFactor(_ node: Node<T>?)->Int {
        return getHeight(node?.left) - getHeight(node?.right)
    }
    
    private func overheight(_ node: Node<T>?) {
        let left = getHeight(node?.left)
        let right = getHeight(node?.right)
        node?.height = max(left, right) + 1;
    }
    
    private func rotateRight(_ node: Node<T>)->Node<T> {
        let tmp = node.left
        node.left = tmp?.right
        overheight(node)
        overheight(tmp)
        return tmp!
    }
    private func rotateLeft(_ node: Node<T>)->Node<T> {
        let tmp = node.right
        node.left = tmp?.left
        overheight(node)
        overheight(tmp)
        return tmp!
    }
    
    private func balance(_ node: Node<T>)->Node<T> {
        overheight(node);
        if (balanceFactor(node) == 2) {
            if (balanceFactor(node.right) < 0) {
                guard let right = node.right else {
                    return node
                }
                node.right = rotateRight(right);
            }
            return rotateLeft(node)
        }
        if (balanceFactor(node) == -2) {
            if (balanceFactor(node.left) > 0) {
                guard let left = node.left else {
                    return node
                }
                node.left = rotateLeft(left);
            }
            return rotateRight(node)
        }
        return node
    }
    
    func insert(_ element: T) {
        let node = Node(data: element)
        if let rootNode = self.root {
            self.insert(rootNode, node)
        } else {
            self.root = node
        }
    }
    
    private func insert(_ root: Node<T>, _ node: Node<T>)->Node<T> {
        if node.data < root.data {
            if let leftNode = root.left {
                self.insert(leftNode, node)
            }
            else {
                root.left = node
            }
        } else {
            if let rightNode = root.right {
                self.insert(rightNode, node)
            }
            else {
                root.right = node
            }
        }
        return balance(node)
    }

    private func min_value (_ node: Node<T>?)->Node<T> {
           var tmp = node;
        while let next = tmp?.left {
               tmp =  next
           }
        return tmp!
       }
    
       private func remove_min(_ node: Node<T>)->Node<T>? {
           guard let left = node.left else {
               return node.right
           }
           node.left = remove_min(left)
           return balance(node)
       }
    
    func remove (_ data: T) {
        let node = Node(data: data)
        if let p = self.root {
            self.remove(p, node)
        }
        else {
            self.root = node
        }
    }
    
    private func remove(_ root: Node<T>?, _ node: Node<T>)->Node<T>? {
        guard var root = root else {
            return nil
        }
        if node.data < root.data {
            root.left = remove(root.left, node)
        } else if node.data > root.data {
           root.right = remove(root.right, node)
        }  else {
                   guard let right = root.right else {
                       return root.left
                   }
                   guard let left = root.left else {
                       return root.right
                   }
                   root = min_value(right)
                   root.right = remove_min(right)
                   root.left = left
                   return balance(node)
               }
               return balance(node)
    }
    
    
    func search(element: T) {
      self.search(self.root, element)
    }
    
    private func search(_ rootNode: Node<T>?, _ element: T) {
      
      guard let rootNode = rootNode else {return}
      if element > rootNode.data {
        self.search(rootNode.right, element)
      } else if element < rootNode.data {
        self.search(rootNode.left, element)
      } else {
        print("Found: \(rootNode.data)")
        }
    }
    
    private func infix(_ node: Node<T>?) {
      guard node != nil else { return }
      self.infix(node?.left)
      print("\(node!.data)", terminator: " ")
      self.infix(node?.right)
    }
    
    private func prefix(_ node: Node<T>?) {
      guard node != nil else { return }
      print("\(node!.data)", terminator: " ")
      self.prefix(node?.left)
      self.prefix(node?.right)
    }

    private func postfix(_ node: Node<T>?) {
      guard node != nil else { return }
      self.postfix(node?.left)
      self.postfix(node?.right)
      print("\(node!.data)", terminator: " ")
    }
    
    func traversal (){
        print("\n Infix:")
        self.infix(self.root)
        print("\n Prefix:")
        self.prefix(self.root)
        print("\n Postfix:")
        self.postfix(self.root)
    }
}

let tree = Tree<Int>()

tree.insert(3)
tree.insert(7)
tree.insert(2)
tree.insert(1)
tree.insert(5)
tree.insert(11)
tree.remove(2)
tree.traversal()
