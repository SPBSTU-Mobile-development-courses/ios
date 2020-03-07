//
//  main.swift
//  f_homework
//
//  Created by Никита on 06/03/2020.
//  Copyright © 2020 Никита. All rights reserved.
//


import Foundation

var tree = Tree<Int>(value: 13)
var root = tree.getRoot()
print(tree.getRoot()!.value)
tree.add(value: 15, root: &root)
tree.add(value: 11, root: &root)
print(tree.findNode(nodeValue: 15)!.value)
tree.remove(nodeValue: 15, root: &root)
tree.add(value: 10, root: &root)
print(tree.getRoot()!.value)
tree.add(value: 20, root: &root)
tree.add(value: 21, root: &root)
tree.add(value: 12, root: &root)
print(root!.value)
