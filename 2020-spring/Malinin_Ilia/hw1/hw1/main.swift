import Foundation

var bt = BinaryTree<Int>()

/*
 Test tree structure (without auto-balancing)
 
                10
        9           15
    8           14      16
                            17
                                18
                                    19
                                        20
                                            21
 */

//Insertionm, balancing and traversing test
bt.insert(10)
bt.insert(9)
bt.insert(15)
bt.insert(16)
bt.insert(14)
bt.insert(8)
bt.insert(17)
bt.insert(18)
bt.insert(19)
bt.insert(20)
bt.insert(21)
bt.printVals()

//Deleting and searching test
print(bt.contains(15))
print(" ")
bt.delete(15)
bt.printVals()
print(bt.contains(15))
