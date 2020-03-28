//
//  main.swift
//  Tree
//
//  Created by Andrew Raspereza on 27/03/2020.
//  Copyright © 2020 Andrew Raspereza. All rights reserved.
//

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
    
    func removeNode(value: T) {
        root = removeNode(node: root, value: value)
    }
    
    func insertNode(value: T) {
        root = insertNode(node: root, value: value)
    }
    
    func findNode(value: T) {
        findNode(node: root, value: value)
    }
    
    private func height(node: Node<T>?) -> Int {
        return node?.height ?? 0
    }
    
    private func balanceFactor(node: Node<T>?) -> Int {
        return height(node: node?.right) - height(node: node?.left)
    }
    
    private func correctHeight(node: Node<T>?) {
        node?.height = max(height(node: node?.left), height(node: node?.right)) + 1
    }
    
    private func rightRotate(node: Node<T>) -> Node<T> {
        let temp = node.left
        node.left = temp?.right
        temp?.right = node
        correctHeight(node: node)
        correctHeight(node: temp)
        return temp!
    }
    
    private func leftRotate(node: Node<T>) -> Node<T> {
        let temp = node.right
        node.right = temp?.left
        temp!.left = node
        correctHeight(node: node)
        correctHeight(node: temp)
        return temp!
    }
    
    private func balance(node: Node<T>) -> Node<T> {
        correctHeight(node: node)
        if balanceFactor(node: node) == 2 {
            if balanceFactor(node: node.right) < 0 {
                node.right = rightRotate(node: node.right!)
            }
            return leftRotate(node: node)
        }
        if balanceFactor(node: node) == -2 {
            if balanceFactor(node: node.left) < 0 {
                node.left = leftRotate(node: node.left!)
            }
            return rightRotate(node: node)
        }
        return node
    }
    
    private func insertNode(node: Node<T>?, value: T) -> Node<T> {
        if node == nil {
            return Node(value: value, height: 1, left: nil, right: nil)
        }
        if value < node!.value {
            node?.left = insertNode(node: node!.left, value: value)
        } else {
            node?.right = insertNode(node: node!.right, value: value)
        }
        return balance(node: node!)
    }
    
    private func findMin(node: Node<T>) -> Node<T> {
        if node.left == nil {
            return node
        }
        node.left = findMin(node: node.left!)
        correctHeight(node: node)
        return balance(node: node)
    }
    
    private func removeMin(node: Node<T>) -> Node<T>? {
        if node.left == nil {
            return node.right
        }
        node.left = removeMin(node: node.left!)
        return balance(node: node)
    }
    
    private func removeNode(node: Node<T>?, value: T) -> Node<T>? {
        if node == nil {
            return nil
        }
        if value < node!.value {
            node?.left = removeNode(node: node?.left, value: value)
        } else if value > node!.value {
            node?.right = removeNode(node: node?.right, value: value)
        } else {
            if node?.right == nil {
                return node?.left
            }
            let min = findMin(node: (node?.right)!)
            min.right = removeMin(node: (node?.right)!)
            min.left = node?.left
            return balance(node: min)
        }
        return balance(node: node!)
    }
    
    private func findNode(node: Node<T>?, value: T) -> Bool {
        guard let node = node else {
            return false
        }
        let nodeValue = node.value
        if value == node.value {
            print("Node \(value) found")
            return true
          } else if value < nodeValue {
            findNode(node: node.left, value: value)
          } else if value > nodeValue {
            findNode(node: node.right, value: value)
          }
        return false
        }
}

var tree = Tree<Int>(value: 1)
tree.insertNode(value: 10)
tree.insertNode(value: 22)
tree.insertNode(value: 34)
tree.insertNode(value: 6)
tree.insertNode(value: 17)
tree.insertNode(value: 5)
tree.insertNode(value: 24)
tree.insertNode(value: 40)
print(tree.root?.value)
print(tree.root?.left?.value)
print(tree.root?.right?.value)
print(tree.root?.left?.left?.value)
print(tree.root?.left?.right?.value)
print(tree.root?.right?.left?.value)
print(tree.root?.right?.right?.value)
print(tree.root?.right?.right?.left?.value)
print(tree.root?.right?.right?.right?.value)
tree.findNode(value: 6)
tree.findNode(value: 100)
tree.removeNode(value: 10)
tree.removeNode(value: 34)
tree.insertNode(value: 2)
print("After operations:")
print(tree.root?.value)
print(tree.root?.left?.value)
print(tree.root?.right?.value)
print(tree.root?.left?.left?.value)
print(tree.root?.left?.right?.value)
print(tree.root?.right?.left?.value)
print(tree.root?.right?.right?.value)
print(tree.root?.right?.right?.left?.value)
print(tree.root?.right?.right?.right?.value)
