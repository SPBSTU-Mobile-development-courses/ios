//
//  TestAVL.swift
//  
//
//  Created by Kirill Kungurov on 05.03.2020.
//

import Foundation

let nums = [2,3,4,5,6,7]
var bst = BinaryTree<Int>()
for num in nums {
    bst.put(num)
}

/*
 AVL tree
                5
 
        3               6
 
    2       4               7
*/

assert(bst.height() == 3)
assert(bst.contains(6))
assert(bst.remove(6) == true)
assert(bst.contains(6) == false)
assert(bst.remove(1) == false)

bst.put(8)
bst.put(9)
bst.put(10)
/*
 AVL tree
                5
 
        3               8
 
    2       4       7       9
                                10
 */
assert(bst.height() == 4)
