//
//  AVLtree.swift
//  f_homework
//
//  Created by Никита on 06/03/2020.
//  Copyright © 2020 Никита. All rights reserved.
//

import Foundation

class Tree<T: Comparable> {
    class Node
    {
        public let value: T
        public var left: Node?
        public var right: Node?
        public var height: Int
        
        init(value: T) {
            self.left = nil
            self.right = nil
            self.value = value
            height = 0
        }
    }
    
    private var root: Node?
    
    init(value: T) {
        self.root = Node(value: value)
    }
    
    func add(value: T, root: inout Node?){
        guard let rootNode = root else {
            root = Node(value: value)
            return
        }
        
        if (value < rootNode.value) {
            add(value: value, root: &rootNode.left)
        }
        else if (value > rootNode.value) {
            add(value: value, root: &rootNode.right)
        }
        else
        {
            print("Can not insert this el, tree already contains it")
        }
        
        balance(current: &root)
        self.root = root
    }
    
    func remove(value: T, root: inout Node?){
        guard let rootNode = root else {
            print("Tree does not contain such el")
            return
        }
        
        if (value > rootNode.value) {
            remove(value: value, root: &rootNode.right)
        }
        else if (value < rootNode.value) {
            remove(value: value, root: &rootNode.left)
        }
        else {
            if (rootNode.right == nil) {
                root = rootNode.left
                
            }
            else {
                var min = findMin(root: rootNode.right)
                removeMin(root: &rootNode.right)
                min!.left = rootNode.left
                balance(current: &min)
                root = min
            }
        }
        
        balance(current: &root)
        self.root = root
    }
    
    func findNode(nodeValue: T, root: Node?) -> Node? {
        guard let current = root else {
            return nil
        }
    
        if (nodeValue == current.value) {
            return current
        }
        
        if (nodeValue > current.value) {
            return findNode(nodeValue: nodeValue, root: current.right)
        }
        else {
            return findNode(nodeValue: nodeValue, root: current.left)
        }
    }
    
    func getRoot() -> Node? {
        return root
    }
    
    private func balance(current: inout Node?) {
        guard let currentNode = current else { return }
        calcHeight(current: currentNode)
        if (getBalanceFactor(current: current) == 2) {
            if (getBalanceFactor(current: currentNode.left) < 0) {
                turnLeft(current: &currentNode.left)
            }
            turnRight(current: &current)
        }
        else if (getBalanceFactor(current: current) == -2) {
            if (getBalanceFactor(current: currentNode.right) > 0) {
                turnRight(current: &currentNode.right)
            }
            turnLeft(current: &current)
        }
    }
    
    private func turnRight(current: inout Node?) {
        guard let currentNode = current else { return }
        guard let newRoot = currentNode.left else { return }
        swap(&currentNode.left, &current)
        currentNode.left = newRoot.right
        newRoot.right = currentNode
        calcHeight(current: currentNode)
        calcHeight(current: newRoot)
    }
    
    private func turnLeft(current: inout Node?) {
        guard let currentNode = current else { return }
        guard let newRoot = currentNode.right else { return }
        swap(&currentNode.right, &current)
        currentNode.right = newRoot.left
        newRoot.left = currentNode
        calcHeight(current: currentNode)
        calcHeight(current: newRoot)
    }
    
    private func calcHeight(current: Node) {
        guard let right = current.right, let left = current.left else {
            guard let right = current.right else {
                guard let left = current.left else {
                    current.height = 0
                    return
                }
                current.height = left.height + 1
                return
            }
            current.height = right.height + 1
            return
        }
        
        if (left.height > right.height) {
            current.height = left.height + 1
        }
        else {
            current.height = right.height + 1
        }
    }
    
    private func getBalanceFactor(current: Node?) -> Int {
        guard let current = current else {
            return 0
        }
        guard let left = current.left, let right = current.right else {
            guard let left = current.left else {
                guard let right = current.right else {
                    return 0
                }
                return -(right.height + 1)
            }
            return left.height + 1
        }
        return left.height - right.height
    }
    
    private func removeMin(root: inout Node?){
        guard let rootNode = root else { return }
    
        if (rootNode.left != nil) {
            removeMin(root: &rootNode.left)
        }
        else if (rootNode.right != nil) {
            root = rootNode.right
        }
        
        balance(current: &root)
    }
    
    private func findMin(root: Node?) -> Node? {
        guard let root = root else { return nil }
        guard let left = root.left else { return root }
        return findMin(root: left)
    }
    
    public func traverseLNR(root: Node?) {
        guard let root = root else {
            return
        }
        traverseLNR(root: root.left)
        print(root.value)
        traverseLNR(root: root.right)
    }
}

