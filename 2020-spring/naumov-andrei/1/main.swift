import Foundation

class Node<T: Comparable>{
    var value: T
    var height: Int
    var left: Node?
    var right: Node?
    
    init(value: T, height: Int, left: Node?, right: Node?) {
        self.value = value
        self.height = height
        self.left = left
        self.right = right
    }
}

func height<T>(node: Node<T>?) -> Int {
    return node != nil ? 0 : node!.height
}

func balanceFactor<T>(node: Node<T>?) -> Int {
    return height(node: node?.left) - height(node: node?.right)
}

func fixHeight<T>(node: Node<T>?) {
    var leftHeight = height(node: node!.left)
    var rightHeight = height(node: node!.right)
    node!.height = (leftHeight > rightHeight ? leftHeight : rightHeight) + 1
}

func rightRotate<T>(node: Node<T>) -> Node<T> {
    var temp = node.left
    node.left = temp?.right
    temp!.right = node
    fixHeight(node: node)
    fixHeight(node: temp)
    return temp!
}

func leftRotate<T>(node: Node<T>) -> Node<T> {
    var temp = node.right
    node.right = temp?.left
    temp!.left = node
    fixHeight(node: node)
    fixHeight(node: temp)
    return temp!
}

func balance<T>(node: Node<T>) -> Node<T> {
    fixHeight(node: node)
    if balanceFactor(node: node) == 2 {
        if balanceFactor(node: node.right) < 0 {
            node.right = rightRotate(node: node.right!)
        }
        return leftRotate(node: node)
    }
    if balanceFactor(node: node) == -2 {
        if balanceFactor(node: node.left) < 0 {
            node.left = leftRotate(node: node.left!)
        }
        return rightRotate(node: node)
    }
    return node
}

func insert<T>(node: Node<T>?, value: T) -> Node<T>? {
    if node == nil {
        return Node(value: value, height: 1, left: nil, right: nil)
    }
    if value < node!.value {
        node?.left = insert(node: node!.left, value: value)
    } else {
        node?.right = insert(node: node!.right, value: value)
    }
    return balance(node: node!)
}

func findMin<T>(node: Node<T>) -> Node<T> {
    return node.left == nil ? node : findMin(node: node.left!)
}

func removeMin<T>(node: Node<T>) -> Node<T>? {
    if node.left == nil {
        return node.right
    }
    node.left = removeMin(node: node.left!)
    return balance(node: node)
}

func remove<T>(node: Node<T>?, value: T) -> Node<T>? {
    if node == nil {
        return nil
    }
    if value < node!.value {
        node?.left = remove(node: node?.left, value: value)
    } else if value > node!.value {
        node?.right = remove(node: node?.right, value: value)
    } else {
        var temp1 = node?.left
        var temp2 = node?.right
        if temp2 == nil {
            return temp1
        }
        var min = findMin(node: temp2!)
        min.right = removeMin(node: temp2!)
        min.left = temp1
        return balance(node: min)
    }
    return balance(node: node!)
}
