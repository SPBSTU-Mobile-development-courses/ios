import Foundation

class Tree<T: Comparable> {
    init(value: T, left: Tree?, right: Tree?, parent: Tree?) {
        self.value = value
        self.left = left
        self.right = right
        self.parent = parent
    }
    
    var value: T
    var left: Tree?
    var right: Tree?
    var parent: Tree?
    
    func insert(newValue: T) -> Bool? {
        if newValue < value {
            if left != nil {
                return left?.insert(newValue: newValue)
            } else {
                left = Tree(value: newValue, left: nil, right: nil, parent: self)
                return true
            }
        } else if newValue > value {
            if right != nil {
                return right?.insert(newValue: newValue)
            } else {
                right = Tree(value: newValue, left: nil, right: nil, parent: self)
                return true
            }
        }
        return false
    }
    
    private func removeFromRoot() -> Bool? {
        if left == nil && right == nil {
            return false
        } else if left != nil && right == nil {
            left?.parent = nil
        } else if left == nil && right != nil {
            right?.parent = nil
        } else {
            var temp = left
            while temp?.right != nil {
                temp = temp?.right
            }
            temp?.right = right
            right?.parent = temp
        }
        return true
    }
    
    func remove(valueToRemove: T) -> Bool? {
        if valueToRemove < value {
            if left != nil {
                if left?.value == valueToRemove {
                    if left?.removeFromRoot() == false {
                        left = nil
                    }
                    return true
                }
                return left?.remove(valueToRemove: valueToRemove)
            }
            return false
        } else if valueToRemove > value {
            if right != nil {
                if right?.value == valueToRemove {
                    if right?.removeFromRoot() == false {
                        right = nil
                    }
                    return true
                }
                return right?.remove(valueToRemove: valueToRemove)
            }
            return false
        }
        return removeFromRoot()
    }
    
    func search(valueToSearch: T) -> Bool? {
        if valueToSearch < value {
            if left != nil {
                return left?.search(valueToSearch: valueToSearch)
            }
            return false
        } else if valueToSearch > value {
            if right != nil {
                return right?.search(valueToSearch: valueToSearch)
            }
            return false
        }
        return true
    }
    
}
