import Foundation

class MySet<Key : Comparable> {
    
    // public:
    
    init(_ keys: Key...) {
        for key in keys {
            insert(key)
        }
    }
    
    public var size: Int { get { size_ } }
    public var empty: Bool { get { size_ == 0 } }
    
    public func insert(_ key: Key) -> Bool {
        guard root_ != nil else {
            root_ = Node(key)
            size_ += 1
            return true
        }
        var curr = root_!
        while true {
            if key == curr.key { return false }
            if key > curr.key {
                if curr.right != nil {
                    curr = curr.right!
                } else {
                    curr.right = Node(key, curr)
                    size_ += 1
                    splay(curr.right!)
                    return true
                }
            } else {
                if curr.left != nil {
                    curr = curr.left!
                } else {
                    curr.left = Node(key, curr)
                    size_ += 1
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
        size_ -= 1
        return true
    }
    
    public func contains(_ key: Key) -> Bool {
        guard root_ != nil else {
            return false
        }
        var curr = root_
        var prev: Node? = nil
        while curr != nil {
            prev = curr
            if curr!.key == key {
                splay(curr!)
                return true
            }
            if key > curr!.key {
                curr = curr!.right
            } else {
                curr = curr!.left
            }
        }
        splay(prev!)
        return false
    }
    
    // private:
    
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
        let p = n.parent;
        let r = n.right!;
        n.right = r.left;
        if r.left != nil {
            r.left!.parent = n;
        }
        r.left = n;
        n.parent = r;
        r.parent = p;
        if p != nil {
            if p!.left === n {
                p!.left = r;
            } else {
                p!.right = r;
            }
        }
    }

    private func rotateRight(_ n: Node)
    {
        let p = n.parent;
        let l = n.left!;
        n.left = l.right;
        if l.right != nil {
            l.right!.parent = n;
        }
        l.right = n;
        n.parent = l;
        l.parent = p;
        if p != nil {
            if p!.left === n {
                p!.left = l;
            } else {
                p!.right = l;
            }
        }
    }
    private func maximum(_ n: Node) -> Node {
        var curr = n
        while curr.right != nil {
            curr = curr.right!
        }
        return curr
    }
    
    private func splay(_ n: Node)
    {
        while n.parent != nil {
            if n === n.parent!.left {
                if n.parent!.parent == nil {
                    rotateRight(n.parent!);
                } else if n.parent! === n.parent!.parent!.left {
                    rotateRight(n.parent!.parent!);
                    rotateRight(n.parent!);
                } else {
                    rotateRight(n.parent!);
                    rotateLeft(n.parent!);
                }
            } else {
                if n.parent!.parent == nil {
                    rotateLeft(n.parent!);
                } else if n.parent! === n.parent!.parent!.right {
                    rotateLeft(n.parent!.parent!);
                    rotateLeft(n.parent!);
                } else {
                    rotateLeft(n.parent!);
                    rotateRight(n.parent!);
                }
            }
        }
        root_ = n;
    }
    private var size_ = 0
    private var root_: Node? = nil
    
}
