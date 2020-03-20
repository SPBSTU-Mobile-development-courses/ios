//
//  Tree.swift
//  tree
//
//  Created by Котов Иван on 12.03.2020.
//  Copyright © 2020 Котов Иван. All rights reserved.
//

import Foundation

class Tree< Value> {
    private class Node {
        public var key: String
        public var value: Value
        public var left:Node? = nil
        public var right:Node? = nil
        public var height:Int = 0
        init(_key: String, _value: Value) {
            self.key = _key
            self.value = _value
        }
    }
    private var root:Node? = nil
    init() {
    }
    init(key: String, value: Value)
    {
        self.root = Node(_key: key,_value: value)
    }
    
    private func _height(node:Node?) -> Int
    {
        return node?.height ?? 0
    }
    
    private func recalcHeight(node: Node)
    {
        node.height = max(_height(node: node.left), _height(node: node.right)) + 1
    }
    
    private func deltaHeight(node: Node) -> Int
    {
        return _height(node: node.right) - _height(node:node.left)
    }
    private func rotateLeft(node:Node) -> Node
    {
        let newRoot = node.right
        node.right = newRoot!.left
        newRoot!.left = node
        recalcHeight(node: node)
        recalcHeight(node: newRoot!)
        return newRoot!
    }
    
    private func rotateRight(node: Node) -> Node
    {
        let newRoot = node.left
        node.left = newRoot?.right
        newRoot?.right = node
        recalcHeight(node: node)
        recalcHeight(node: newRoot!)
        return newRoot!
    }
    
    private func balance(node: Node) -> Node
    {
        recalcHeight(node: node)
        if (deltaHeight(node: node) < -1)
        {
            if (node.left != nil && deltaHeight(node: node.left!) > 0)
            {
                node.left = rotateLeft(node: node.left!)
            }
            return rotateRight(node: node)
        } else if (deltaHeight(node: node) > 1)
        {
            if (node.right != nil && deltaHeight(node: node.right!) < 0)
            {
                node.right = rotateRight(node: node.right!)
            }
            return rotateLeft(node: node)
        }
        return node
    }
    private func _add(key: String, value: Value, node: Node?) -> Node
    {
        guard let tmp = node else {
            return Node(_key: key, _value: value)
        }
        if (key < tmp.key) {
            tmp.left = _add(key: key, value: value, node: tmp.left)
        } else if (key == tmp.key)
        {
            tmp.value = value
            return tmp
        } else
        {
            tmp.right = _add(key: key, value: value, node: tmp.right)
        }
        return balance(node: tmp)
    }
    
    func add(key: String, value: Value)
    {
        if (key != "") {
            root = _add(key: key, value: value, node: root)
        }
    }
    
    private func findmin(node: Node) -> Node
    {
        guard let tmp = node.left else
        {
            return node
        }
        return findmin(node: tmp)
    }

    private func removemin(node: Node) -> Node?
    {
        guard let tmp = node.left else {
            return node.right;
        }
        node.left = removemin(node: tmp);
        return balance(node: node);
    }

    private func _remove(node: Node?, key: String) -> Node?
    {
        guard let tmp = node else {
            return nil
        }
        if( key < node!.key )
        {
            tmp.left = _remove(node: tmp.left,key: key);
        }
        else if( key > node!.key )
        {
            tmp.right = _remove(node: tmp.right,key: key);
        }
        else
        {
            let q = tmp.left;
            let r = tmp.right;
            guard let right = r else {
                return q;
            }
            let min = findmin(node:right);
            min.right = removemin(node:right);
            min.left = q;
            return balance(node:min);
        }
        return balance(node:tmp);
    }
    func remove(key:String)
    {
        if (key != "") {
            root = _remove(node: root, key: key)
        }
    }
    
    func get(key:String) -> Value?
    {
        if (key == "") {
            return nil
        }
        var cur = root
        while cur != nil {
            if ( cur?.key == key)
            {
                return cur?.value
            } else if (key < cur!.key)
            {
                cur = cur?.left
            } else {
                cur = cur?.right
            }
        }
        return nil
    }
}
