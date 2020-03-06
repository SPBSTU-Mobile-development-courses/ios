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
        let node:TreeNode = TreeNode(data: element)
        
        if let rootNode:TreeNode = self.rootNode {
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
}
