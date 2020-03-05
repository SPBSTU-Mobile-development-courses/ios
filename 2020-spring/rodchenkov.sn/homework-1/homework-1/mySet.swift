import Foundation

class MySet<Key : Comparable> {
    
    public private(set) var size = 0
    private var root_: Node? = nil
    
    public var empty: Bool { size == 0 }
    
    convenience init(_ keys: Key...) {
        self.init(keys)
    }
    
    init(_ keys: [Key] = []) {
        for key in keys {
            insert(key)
        }
    }
    
    public func insert(_ key: Key) -> Bool {
        guard var curr = root_ else {
            root_ = Node(key)
            size += 1
            return true
        }
        while true {
            if key == curr.key { return false }
            if key > curr.key {
                if curr.right != nil {
                    curr = curr.right!
                } else {
                    curr.right = Node(key, curr)
                    size += 1
                    splay(curr.right!)
                    return true
                }
            } else {
                if curr.left != nil {
                    curr = curr.left!
                } else {
                    curr.left = Node(key, curr)
                    size += 1
                    splay(curr.left!)
                    return true
                }
            }
        }
    }
    
    public func remove(_ key: Key) -> Bool {
        guard contains(key) else {
            return false
        }
        let oldRoot = root_!
        if let left = oldRoot.left {
            left.parent = nil
            splay(maximum(left))
            root_!.right = oldRoot.right
            if let right = root_!.right {
                right.parent = root_
            }
        } else {
            root_ = root_!.right
            root_?.parent = nil
        }
        size -= 1
        return true
    }
    
    public func contains(_ key: Key) -> Bool {
        guard root_ != nil else {
            return false
        }
        var curr = root_
        var prev: Node?
        while let node = curr {
            prev = node
            if node.key == key {
                splay(node)
                return true
            }
            if key > node.key {
                curr = node.right
            } else {
                curr = node.left
            }
        }
        splay(prev!)
        return false
    }
    
    private class Node {
        public var left: Node? = nil
        public var right: Node? = nil
        public var parent: Node?
        public var key: Key
        init(_ key: Key, _ parent: Node? = nil) {
            self.key = key
            self.parent = parent
        }
    }
    
    private func rotateLeft(_ n: Node)
    {
        let p = n.parent
        let r = n.right!
        n.right = r.left
        if r.left != nil {
            r.left!.parent = n
        }
        r.left = n
        n.parent = r
        r.parent = p
        if let parent = p {
            if parent.left === n {
                parent.left = r
            } else {
                parent.right = r
            }
        }
    }

    private func rotateRight(_ n: Node)
    {
        let p = n.parent
        let l = n.left!
        n.left = l.right
        if l.right != nil {
            l.right!.parent = n
        }
        l.right = n
        n.parent = l
        l.parent = p
        if let parent = p {
            if parent.left === n {
                parent.left = l
            } else {
                parent.right = l
            }
        }
    }
    private func maximum(_ n: Node) -> Node {
        var curr = n
        while let right = curr.right {
            curr = right
        }
        return curr
    }
    
    private func splay(_ n: Node)
    {
        while let parent = n.parent {
            if n === parent.left {
                if parent.parent == nil {
                    rotateRight(parent)
                } else if parent === parent.parent!.left {
                    rotateRight(parent.parent!)
                    rotateRight(parent)
                } else {
                    rotateRight(parent)
                    rotateLeft(parent)
                }
            } else {
                if parent.parent == nil {
                    rotateLeft(parent)
                } else if parent === parent.parent!.right {
                    rotateLeft(parent.parent!)
                    rotateLeft(parent)
                } else {
                    rotateLeft(parent)
                    rotateRight(parent)
                }
            }
        }
        root_ = n
    }
    
}
