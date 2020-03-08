import Foundation


let treeInt = BinaryTree<Int>()
let treeChar = BinaryTree<Character>()

treeInt.insert(element: 3)
treeInt.getInfo()

treeInt.insert(element: 4)
treeInt.insert(element: 2)
treeInt.insert(element: 1)

treeInt.remove(treeNode: treeInt.rootNode, value: 4)
treeInt.getInfo()



