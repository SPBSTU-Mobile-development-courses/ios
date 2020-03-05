//
//  main.swift
//  BinaryTree
//
//  Created by alexander on 01.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Foundation

let a =  BinaryTree<Int>()

a.add(element: 1)
a.add(element: 2)
a.add(element: 3)
a.add(element: 4)
a.add(element: 5)
a.add(element: 6)
print(a.contains(element: 6))
a.remove(element: 6)
print(a.contains(element: 6))

