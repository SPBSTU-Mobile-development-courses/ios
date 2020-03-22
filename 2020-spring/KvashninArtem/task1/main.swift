import Foundation

class Node<T: Equatable>
{
    var value: T
    var leftNode: Node?
    var rightNode: Node?
    var level: Int
    
    init(value: T, leftNode: Node? = nil, rightNode: Node? = nil, level: Int)
    {
        self.value = value
        self.leftNode = leftNode
        self.rightNode = rightNode
        self.level = level
    }
    
    func equals(node: Node<T>?) -> Bool
    {
        if(value == node?.value && level == node?.level)
        {
            return true
        }
        else
        {
            return false
        }
    }
}

/**
 * AA tree 
 * @see https://en.wikipedia.org/wiki/AA_tree
 */
class BinaryTree<T: Equatable & Comparable>
{
    private var rootNode: Node<T>? = nil
    
    init(value: T)
    {
        rootNode = Node<T>(value: value, leftNode: nil, rightNode: nil, level: 1)
    }
    
    init()
    {
        rootNode = nil
    }
    
    func insert(value: T)
    {
        insert(value: value, insertNode: &rootNode)
    }
    
    private func insert(value: T, insertNode: inout Node<T>?) -> Node<T>?
    {
        if(insertNode == nil)
        {
            return Node<T>(value: value, leftNode: nil, rightNode: nil, level: 1)
        }
        else
        {
            if(value < insertNode!.value)
            {
                var lNode = insertNode?.leftNode
                insertNode?.leftNode = insert(value: value, insertNode: &lNode)
            }
            else if(value > insertNode!.value)
            {
                var rNode = insertNode?.rightNode
                insertNode?.rightNode = insert(value: value, insertNode: &rNode)
            }
            
            //value = insertNode!.value not undefined
            
            skew(node: &insertNode)
            split(node: &insertNode)
        }
        return insertNode
    }
    
    private func split(node: inout Node<T>?)
    {
        var rNode = node?.rightNode
        if(rNode != nil)
        {
            if(rNode?.rightNode != nil)
            {
                if(rNode?.rightNode?.level == node?.level)
                {
                    swap(&node, &rNode)
                    rNode?.rightNode = node?.leftNode
                    node?.leftNode = rNode
                    node?.level+=1
                }
            }
        }
    }
    
    private func skew(node: inout Node<T>?)
    {
        var lNode = node?.leftNode
        if(lNode != nil && node?.level == lNode?.level)
        {
            swap(&node, &lNode)
            lNode?.leftNode = node?.rightNode
            node?.rightNode = lNode
        }
    }
    
    func inTree(value: T) -> Bool
    {
        return inTree(value: value, node: rootNode)
    }
    
    private func inTree(value: T, node: Node<T>?) -> Bool
    {
        if(node == nil)
        {
            return false
        }
        else if(node?.value == value)
        {
            return true
        }
        else if(node!.value > value)
        {
            return inTree(value: value, node: node?.leftNode)
        }
        else
        {
            return inTree(value: value, node: node?.rightNode)
        }
    }
    
    func bypass()
    {
        bypass(node: rootNode)
    }
    private func bypass(node: Node<T>?)
    {
        print("Node Key: ", node?.value)
        print("Left Key: ", terminator: "")
        if(node?.leftNode != nil){print(node!.leftNode!.value)} else{print("nil")}
        
        print("Right Key: ", terminator: "")
        if(node?.rightNode != nil){print(node!.rightNode!.value)} else{print("nil")}
        print()
        
        if(node?.leftNode != nil)
        {
            bypass(node: node?.leftNode)
        }
        if(node?.rightNode != nil)
        {
            bypass(node: node?.rightNode)
        }
    }
    
    func height() -> Int
    {
        height(node: rootNode)
    }
    
    private func height(node: Node<T>?) -> Int
    {
        var LeftCounter, RightCounter : Int
        
        if(node?.leftNode != nil)
        {
            LeftCounter = height(node: node?.leftNode)
        }
        else
        {
            LeftCounter = -1
        }
        
        if(node?.rightNode != nil)
        {
            RightCounter = height(node: node?.rightNode)
        }
        else
        {
            RightCounter = -1
        }
        
        if(LeftCounter > RightCounter)
        {
            return LeftCounter + 1
        }
        else
        {
            return RightCounter + 1
        }
    }
    
    private var last: Node<T>?
    private var deleted: Node<T>?
    
    func delete(value: T)
    {
        delete(value: value, node: &rootNode)
    }
    
    private func delete(value: T, node: inout Node<T>?)
    {
        if(node != nil)
        {
            //1 Go down and remember last and deleted Element
            last = node
            if(value < node!.value)
            {
                var lNode = node?.leftNode
                delete(value: value, node: &lNode)
            }
            else
            {
                deleted = node
                var rNode = node?.rightNode
                delete(value: value, node: &rNode)
            }
            //2 Delete Element
            if(node!.equals(node: last) && deleted != nil && value == deleted!.value)
            {
                deleted = nil
                node = node?.rightNode
            }
            else if((height(node: node?.leftNode) < height(node: node) - 1) || (height(node: node?.rightNode) < height(node: node) - 1))
            {
                //3 Balancing
                node!.level -= 1
                if(node!.rightNode!.level > node!.level)
                {
                    node!.rightNode!.level = node!.level
                }
                skew(node: &node)
                var rNode = node?.rightNode
                var rrNode = rNode?.rightNode
                skew(node: &rNode)
                skew(node: &rrNode)
                split(node: &node)
                split(node: &rNode)
            }
        }
    }
}


var tree = BinaryTree<Int>(value: 1)
tree.insert(value: 1)
tree.insert(value: 2)
tree.insert(value: 0)
tree.insert(value: 3)
tree.bypass()

print(tree.height())
print(tree.inTree(value: 0))
print(tree.inTree(value: 1000))
