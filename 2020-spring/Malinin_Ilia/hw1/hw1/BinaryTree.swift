/*
 
 HW1: Realization of Binary Tree
 by Ilia I. Malinin
 gr. 3530904/80006
 
 */

import Foundation

class BinaryTree<T: Comparable> {
    private class Node {
        var value: T
        var height: Int
        var left: Node?
        var right: Node?
        
        init(_ val: T, _ h: Int) {
            self.value = val
            self.height = h
            self.left = nil
            self.right = nil
        }
    }
    private var root: Node?
    
    init() {
        self.root = nil
    }
    
    /* Node Insertion */
    func insert(_ val: T) {
        let newNode = Node(val, 0)
        guard let currentNode = root else {
            root = newNode
            return
        }
        
        insertLogic(newNode, currentNode)
        balance()
    }
    
    private func insertLogic(_ newNode: Node, _ currentNode: Node) {
        if(newNode.value < currentNode.value) {
            guard let newCurrent = currentNode.left else {
                currentNode.left = newNode
                return
            }
            insertLogic(newNode, newCurrent)
        } else if(newNode.value > currentNode.value) {
            guard let newCurrent = currentNode.right else {
                currentNode.right = newNode
                fixHeight(currentNode.right)
                return
            }
            insertLogic(newNode, newCurrent)
        } else {
            print("Element with provided value is exist!")
            return
        }
    }
    
    /* Node Deleting */
    func delete(_ val: T) {
        if root != nil {
            if(root?.value == val) {
                guard let leftSubtree = root?.left else {
                    root = root?.right
                    balance()
                    return
                }
                guard let rightSubtree = root?.right else {
                    root = root?.left
                    balance()
                    return
                }
                
                insertLogic(leftSubtree, rightSubtree)
                root = rightSubtree
                balance()
            } else {
                deleteLogic(val, root!)
                balance()
            }
        } else {
            print("Tree is Empty")
            return
        }
    }
    
    private func deleteLogic(_ val: T, _ current: Node) {
        if(val < current.value) {
            if let left = current.left {
                if(val == left.value) {
                    let nl = left.left
                    let nr = left.right
                    current.left = nil
                    
                    if(nl != nil) {
                        insertLogic(nl!, root!)
                    }
                    
                    if(nr != nil) {
                        insertLogic(nr!, root!)
                    }
                } else {
                    deleteLogic(val, left)
                }
            } else {
                print("Node with provided value doesn't exist")
            }
        } else if(val > current.value) {
            if let right = current.right {
                if(val == right.value) {
                    let nl = right.left
                    let nr = right.right
                    current.right = nil
                    
                    if(nl != nil) {
                        insertLogic(nl!, root!)
                    }
                    
                    if(nr != nil) {
                        insertLogic(nr!, root!)
                    }
                } else {
                    deleteLogic(val, right)
                }
            } else {
                print("Node with provided value doesn't exist")
            }
        } else {
            print("Node with provided value doesn't exist")
        }
    }
    
    /* Searching in Tree by value */
    func contains(_ val: T) -> Bool {
        guard let current = root else {
            return false
        }
        
        return containsLogic(val, current)
    }
    
    private func containsLogic(_ val: T, _ node: Node) -> Bool {
        if(val == node.value) {
            return true
        } else if(val < node.value) {
            guard let current = node.left else {
                return false
            }
            return containsLogic(val, current)
        } else if(val > node.value) {
            guard let current = node.right else {
                return false
            }
            return containsLogic(val, current)
        }
        return false
    }
    
    /* Tree traversal */
    func printVals() {
        guard let currentNode = root else {
            print("Tree is Empty")
            return
        }
        printLogic(currentNode)
    }
    
    private func printLogic(_ node: Node) {
        if(node.left != nil) {
            printLogic(node.left!)
        }
        
        print("Val: \(node.value) H: \(node.height)")
        
        if(node.right != nil) {
            printLogic(node.right!)
        }
    }
    
    /* Auto-balancing */
    private func height(_ node: Node?) -> Int {
        return node?.height ?? 0
    }
    
    private func bfactor(_ node: Node?) -> Int {
        return height(node?.right) - height(node?.left)
    }
    
    private func fixHeight(_ node: Node?) {
        let leftHeight = height(node?.left)
        let rightHeight = height(node?.right)
        node?.height = max(leftHeight, rightHeight) + 1
    }
    
    private func rightRotate(_ node: Node) -> Node {
        let tmp = node.left
        node.left = tmp?.right
        tmp?.right = node
        fixHeight(node)
        fixHeight(tmp)
        return tmp!
    }
    
    private func leftRotate(_ node: Node) -> Node {
        let tmp = node.right
        node.right = tmp?.left
        tmp?.left = node
        fixHeight(node)
        fixHeight(tmp)
        return tmp!
    }
    
    func balance() {
        guard var currentNode = root else {
            print("Tree is Empty")
            return
        }
        balanceLogic(&currentNode)
    }
    
    private func balanceLogic(_ node: inout Node) {
        if(node.left != nil) {
            balanceLogic(&(node.left)!)
        }
        
        node = autobalance(node)!
        
        if(node.right != nil) {
            balanceLogic(&(node.right)!)
        }
    }
    
    private func autobalance(_ node: Node?) -> Node? {
        guard let node = node else {
            return nil
        }
        fixHeight(node)
        if bfactor(node) == 2 {
            if bfactor(node) < 0 {
                node.right = rightRotate(node.right!)
            }
            return leftRotate(node)
        }
        if bfactor(node) == -2 {
            if bfactor(node) < 0 {
                node.left = leftRotate(node.left!)
            }
            return rightRotate(node)
        }
        return node
    }
}
