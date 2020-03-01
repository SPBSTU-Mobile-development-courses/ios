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
        var left: TreeNode? = nil
        var right: TreeNode? = nil
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
        if(curr == nil)
        {
            return TreeNode(data: element)
        }
        if(element < curr!.data)
        {
            curr!.left = insert(curr: curr!.left, element: element)
        }
        else
        {
            curr!.right = insert(curr: curr!.right, element: element)
        }
        return balance(node: curr!)
    }
    private func rmv(curr: TreeNode?, element: DataType) -> TreeNode?{
        if(curr == nil)
        {
            return nil
        }
        if(element < curr!.data)
        {
            curr!.left = rmv(curr: curr!.left, element: element)
        }
        else if(element > curr!.data)
        {
            curr!.right = rmv(curr: curr!.right,element: element)
        }
        else
        {
            let q = curr!.left
            let r = curr!.right
            if (r == nil)
            {
                return q
            }
            let min = findMinimalNode(node: r!)
            min.right = removeMinimalNode(node: r!)
            min.left = q
            return balance(node: min)
        }
        return balance(node: curr!)
    }
    
    private func find(element: DataType, curr: TreeNode?)-> TreeNode? {
        if(curr == nil)
        {
            return nil
        }
        if(curr!.data == element){
            return curr
        }
        let l = find(element: element, curr: curr?.left)
        let r = find(element: element, curr: curr?.right)
        if(l != nil)
        {
            return l
        }
        if(r != nil)
        {
            return r
        }
        return nil
    }
    private func findParent(element: DataType, curr: TreeNode?) -> TreeNode?{
        if(curr == nil)
        {
            return nil
        }
        if(curr!.left?.data == element)
        {
            return curr
        }
        if(curr!.right?.data == element)
        {
            return curr
        }
        let l = findParent(element: element, curr: curr!.left)
        let r = findParent(element: element, curr: curr!.right)
        if(l != nil )
        {
            return l
        }
        if(r != nil)
        {
            return r
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
        let hl = height(node: node.left)
        let hr = height(node: node.right)
        node.height = max(hl,hr)+1
        
    }
    private func rotateRight(node: TreeNode) -> TreeNode?{
        let q = node.left
        node.left = q?.right
        q?.right = node
        fixHeight(node: node)
        if(q != nil)
        {
            fixHeight(node: q!)
        }
        return q
    }
    private func rotateLeft(node: TreeNode) -> TreeNode?{
        let p = node.right
        node.right = p?.left
        p?.left = node
        if(p != nil)
        {
            fixHeight(node: p!)
        }
        fixHeight(node: node)
        return p
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
