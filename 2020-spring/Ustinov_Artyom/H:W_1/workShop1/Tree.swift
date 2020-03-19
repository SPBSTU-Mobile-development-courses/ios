import Foundation

class TreeNode<T> {
  
  var data: T
  var leftNode: TreeNode?
  var rightNode: TreeNode?
  
  init(data: T, leftNode: TreeNode? = nil, rightNode: TreeNode? = nil) {
    self.data = data
    self.leftNode = leftNode
    self.rightNode = rightNode
  }
}


class BinaryTree<T: Comparable & CustomStringConvertible> {
  
  var rootNode: TreeNode<T>?
  
  func insert(element: T) {
    
    let node = TreeNode(data: element)
    
    if let rootNode = self.rootNode {
      //recursion
      self.insert(rootNode, node)
    } else {
      self.rootNode = node
    }
  }
  
  private func insert(_ rootNode: TreeNode<T>, _ node: TreeNode<T>) {
    
    if rootNode.data > node.data {
      if let leftNode = rootNode.leftNode {
        self.insert(leftNode, node)
      } else {
        rootNode.leftNode = node
      }
    } else {
      if let rightNode = rootNode.rightNode {
        self.insert(rightNode, node)
      } else {
        rootNode.rightNode = node
      }
    }
  }
  
  func remove<T: Comparable>(treeNode: TreeNode<T>?, value: T) -> TreeNode<T>? {
    //        if treeNode == nil {
    //            return nil
    //        }
    guard let treeNode = treeNode else {
      return nil
    }
    if value < treeNode.data {
      treeNode.leftNode = remove(treeNode: treeNode.leftNode, value: value)
    } else if value > treeNode.data {
      treeNode.rightNode = remove(treeNode: treeNode.rightNode, value: value)
    } else {
      let temp = treeNode.leftNode
      let temp1 = treeNode.rightNode
      
      if temp1 == nil {
        return temp
      }
    }
    return treeNode
  }
  
  
  func search(element: T) {
    self.search(self.rootNode, element)
  }
  
  private func search(_ rootNode: TreeNode<T>?, _ element: T) {
    
    guard let rootNode = rootNode else {
      print("INVALID NODE : \(element)")
      return
    }
    
    //print("ROOT NODE \(rootNode.data)")
    if element > rootNode.data {
      self.search(rootNode.rightNode, element)
    } else if element < rootNode.data {
      self.search(rootNode.leftNode, element)
    } else {
      print("NODE FOUND : \(rootNode.data)")
    }
  }
  
  func getInfo() {
    print("\n NODE -> LEFT -> RIGHT")
    self.preorder(self.rootNode)
    print("\n LEFT -> NODE -> RIGHT")
    self.inorder(self.rootNode)
    print("\n LEFT -> RIGHT -> NODE")
    self.postorder(self.rootNode)
    print("\n")
  }
  
  //LRN
  private func inorder(_ node: TreeNode<T>?) {
    guard node != nil else { return }
    self.inorder(node?.leftNode)
    print("\(node!.data)", terminator: " ")
    self.inorder(node?.rightNode)
  }
  
  //NLR
  private func preorder(_ node: TreeNode<T>?) {
    guard node != nil else { return }
    print("\(node!.data)", terminator: " ")
    self.preorder(node?.leftNode)
    self.preorder(node?.rightNode)
  }
  //LRN
  private func postorder(_ node: TreeNode<T>?) {
    guard node != nil else { return }
    
    self.postorder(node?.leftNode)
    self.postorder(node?.rightNode)
    print("\(node!.data)", terminator: " ")
  }
  
}


