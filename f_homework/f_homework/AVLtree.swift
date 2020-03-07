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
        
        if (root == nil) {
            root = Node(value: value)
            return
        }
        
        if (value < root!.value) {
            add(value: value, root: &root!.left)
        }
        else if (value > root!.value) {
            add(value: value, root: &root!.right)
        }
        else
        {
            print("Can not insert this el, tree already contains it")
        }
        
        balance(current: &root)
        self.root = root
    }
    
    func remove(nodeValue: T, root: inout Node?){
        if (root == nil)
        {
            print("Tree does not contain such el")
            return
        }
        
        if (nodeValue > root!.value) {
            remove(nodeValue: nodeValue, root: &root!.right)
        }
        else if (nodeValue < root!.value) {
            remove(nodeValue: nodeValue, root: &root!.left)
        }
        else {
            if (root!.right == nil) {
                root = root!.left
                
            }
            else {
                var min = findMin(root: root!.right)
                removeMin(root: &root!.right)
                min!.left = root!.left
                balance(current: &min)
                root = min
            }
        }
        
        balance(current: &root)
        self.root = root
    }
    
    func findNode(nodeValue: T) -> Node? {
        var current = root
        while (current != nil) {
            if (nodeValue == current!.value) {
                return current
            }
            
            if (nodeValue > current!.value) {
                current = current!.right
            }
            else {
                current = current!.left
            }
        }
        
        return current
    }
    
    func getRoot() -> Node? {
        return root
    }
    
    private func balance(current: inout Node?) {
        if (current != nil) {
            calcHeight(current: &current)
            if (getBalanceFactor(current: current) == 2) {
                if (getBalanceFactor(current: current!.left) < 0) {
                    turnLeft(current: &current!.left)
                }
                turnRight(current: &current)
            }
            else if (getBalanceFactor(current: current) == -2) {
                if (getBalanceFactor(current: current!.right) > 0) {
                    turnRight(current: &current!.right)
                }
                turnLeft(current: &current)
            }
        }
    }
    
    private func turnRight(current: inout Node?) {
        var newRoot = current!.left
        current!.left = newRoot!.right
        newRoot!.right = current
        calcHeight(current: &current)
        calcHeight(current: &newRoot)
        swap(&newRoot, &current)
    }
    
    private func turnLeft(current: inout Node?) {
        var newRoot = current!.right
        current!.right = newRoot!.left
        newRoot!.left = current
        calcHeight(current: &current)
        calcHeight(current: &newRoot)
        swap(&newRoot, &current)
    }
    
    private func calcHeight(current: inout Node?) {
        if (current!.left != nil && current!.right != nil) {
            if (current!.left!.height > current!.right!.height) {
                current!.height = current!.left!.height + 1
            }
            else {
                current!.height = current!.right!.height + 1
            }
        }
        else if (current!.left != nil) {
            current!.height = current!.left!.height + 1
        }
        else if (current!.right != nil) {
            current!.height = current!.right!.height + 1
        }
        else {
            current!.height = 0
        }
    }
    
    private func getBalanceFactor(current: Node?) -> Int {
        if (current == nil) {
            return 0
        }
        if (current!.left != nil && current!.right != nil) {
            return current!.left!.height - current!.right!.height
        }
        else if (current!.left != nil)
        {
            return current!.left!.height + 1
        }
        else if (current!.right != nil) {
            return -(current!.right!.height + 1)
        }
        else {
            return 0
        }
        
    }
    
    private func removeMin(root: inout Node?){
        if (root!.left != nil) {
            removeMin(root: &root!.left)
        }
        else if (root!.right != nil) {
            root = root!.right
        }
        
        balance(current: &root)
    }
    
    private func findMin(root: Node?) -> Node? {
        if (root!.left != nil) {
            root!.left = findMin(root: root!.left)
        }
        
        return root
    }
}

