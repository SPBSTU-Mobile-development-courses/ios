//
//  main.swift
//  BinaryTree
//
//  Created by alexander on 01.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Foundation

class BinaryTree<DataType: Comparable>{
    private class TreeNode{
        var left: TreeNode?
        var right: TreeNode?
        var height: Int = 1
        let data: DataType
        init(data: DataType){
            self.data = data
        }
    }
    private var head: TreeNode? = nil
    public func add(element: DataType){
        head = insert(curr: head, element: element)
    }
    
    public func contains(element: DataType)-> Bool{
        return find(element: element, curr: head) != nil
    }
    public func remove(element: DataType){
        if(head != nil && head!.data == element)
        {
            head = nil
        }
        rmv(curr: head,element: element)
    }
    private func insert(curr: TreeNode?, element: DataType) -> TreeNode? {
        guard let currentElement = curr else
        {
            return TreeNode(data: element)
        }
        if(element < currentElement.data)
        {
            currentElement.left = insert(curr: currentElement.left, element: element)
        }
        else
        {
            currentElement.right = insert(curr: currentElement.right, element: element)
        }
        return balance(node: currentElement)
    }
    private func rmv(curr: TreeNode?, element: DataType) -> TreeNode?{
        guard let currentElement = curr else
        {
            return nil
        }
        if(element < currentElement.data)
        {
            currentElement.left = rmv(curr: currentElement.left, element: element)
        }
        else if(element > currentElement.data)
        {
            currentElement.right = rmv(curr: currentElement.right,element: element)
        }
        else
        {
            let left = currentElement.left
            guard let right = currentElement.right else
            {
                return left
            }
            let min = findMinimalNode(node: right)
            min.right = removeMinimalNode(node: right)
            min.left = left
            return balance(node: min)
        }
        return balance(node: currentElement)
    }
    
    private func find(element: DataType, curr: TreeNode?)-> TreeNode? {
        guard let currentElement = curr else
        {
            return nil
        }
        if(currentElement.data == element){
            return currentElement
        }
        let left = find(element: element, curr: currentElement.left)
        let right = find(element: element, curr: currentElement.right)
        if(left != nil)
        {
            return left
        }
        if(right != nil)
        {
            return right
        }
        return nil
    }
    private func findParent(element: DataType, curr: TreeNode?) -> TreeNode?{
        guard let currentElement = curr else
        {
            return nil
        }
        if(currentElement.left?.data == element)
        {
            return curr
        }
        if(currentElement.right?.data == element)
        {
            return curr
        }
        let left = findParent(element: element, curr: currentElement.left)
        let right = findParent(element: element, curr: currentElement.right)
        if(left != nil )
        {
            return left
        }
        if(right != nil)
        {
            return right
        }
        return nil
    }
    
    private func height(node: TreeNode?) -> Int{
        if(node != nil){
            return node!.height
        }
        return 0
    }
    
    private func bFactor(node: TreeNode) -> Int{
        return height(node: node.right) - height(node: node.left)
    }
    
    private func fixHeight(node: TreeNode){
        let heightLeft = height(node: node.left)
        let heightRight = height(node: node.right)
        node.height = max(heightLeft,heightRight)+1
        
    }
    private func rotateRight(node: TreeNode) -> TreeNode?{
        let left = node.left
        node.left = left?.right
        left?.right = node
        fixHeight(node: node)
        if(left != nil)
        {
            fixHeight(node: left!)
        }
        return left
    }
    private func rotateLeft(node: TreeNode) -> TreeNode?{
        let right = node.right
        node.right = right?.left
        right?.left = node
        if(right != nil)
        {
            fixHeight(node: right!)
        }
        fixHeight(node: node)
        return right
    }
    private func balance(node: TreeNode) -> TreeNode?{
        fixHeight(node: node)
        if(bFactor(node: node) == 2)
        {
            if(bFactor(node: node.right!)<0)
            {
                node.right = rotateRight(node: node.right!)
            }
            return rotateLeft(node: node)
        }
        if(bFactor(node: node) == -2)
        {
            if(bFactor(node: node.left!)>0)
            {
                node.left = rotateLeft(node: node.left!)
            }
            return rotateRight(node: node)
        }
        return node
    }
    private func findMinimalNode(node: TreeNode) -> TreeNode{
        if(node.left != nil)
        {
            return findMinimalNode(node: node.left!)
        }
        else
        {
            return node
        }
    }
    private func removeMinimalNode(node: TreeNode) -> TreeNode?{
        if(node.left == nil)
        {
            return node.right
        }
        node.left = removeMinimalNode(node: node.left!)
        return balance(node: node)
    }
}
