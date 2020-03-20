class TreeElement<T: Comparable>{
    private var value: T
    private var left: TreeElement?
    private var right: TreeElement?
    private var height: Int
    
    init(value: T, parentHeight: Int) {
        self.value = value
        self.height = parentHeight + 1
    }
    
    func fixHeight(){
        left?.height = height + 1
        left?.fixHeight()
        right?.height = height + 1
        right?.fixHeight()
    }
    
    func getMaxHeight() -> Int{
        if (left == nil) && (right == nil) {
            return height
        }
        
        if (left == nil) && (right != nil) {
            return right!.getMaxHeight()
        }
        
        let left = self.left!
        
        guard let right = right else {
            return left.getMaxHeight()
        }
        
        if right.getMaxHeight() > left.getMaxHeight() {
            return right.getMaxHeight()
        } else {
            return left.getMaxHeight()
        }
    }
    
    func recAdd(value: T) -> Bool{
        if self.value == value {
            return false
        }
        
        if value > self.value {
            guard let tmpRight = right else {
                right = TreeElement<T>(value: value, parentHeight: self.height)
                return true
            }
            return tmpRight.recAdd(value: value)
            
        } else {
            guard let tmpLeft = left else {
                left = TreeElement<T>(value: value, parentHeight: self.height)
                return true
            }
            return tmpLeft.recAdd(value: value)
        }
    }
    
    func recPrint(){
        if height != 1
        {
            var spaces: String = ""
            for _ in 1...(self.height-1){
                spaces = spaces + " "
            }
            print(spaces.dropLast(), value, " height: ", height)
        } else {
            print(value, " height: ", height)
        }
        left?.recPrint()
        right?.recPrint()
    }
    
    func recAddHeight(height: Int){
        self.height = self.height + height
        left?.recAddHeight(height: height)
        right?.recAddHeight(height: height)
    }
    
    func recFind(value: T) -> DoubleTreeElement<T>?{
        var result: DoubleTreeElement<T>?
        if self.value == value {
            result = DoubleTreeElement<T>()
            result!.setElement(element: self)
        } else {
            if value > self.value {
                result = right?.recFind(value: value)
                if result?.getParentElement() == nil {
                    result?.setParentElement(element: self)
                }
            } else {
                result = left?.recFind(value: value)
                if result?.getParentElement() == nil {
                    result?.setParentElement(element: self)
                }
            }
        }
        return result
    }
    
    func balanceFactor() -> Int{
        var a: Int? = self.right?.getMaxHeight()
        var b: Int? = self.left?.getMaxHeight()
        if a == nil {a = height}
        if b == nil {b = height}
        return a! - b!
    }
    
    func rotateLeft() -> TreeElement<T>?{
        guard let newHead = right else {
            print("error while rotating")
            return nil
        }
        self.right = newHead.left
        newHead.left = self
        
        newHead.height = newHead.height - 1
        guard let left = newHead.left else {
            print("error while rotating")
            return nil
        }
        newHead.left?.height = left.height + 1
        
        newHead.left?.left?.recAddHeight(height: 1)
        newHead.right?.recAddHeight(height: -1)
        
        return newHead;
    }
    
    func rotateRight() -> TreeElement<T>?{
        guard let newHead = left else {
            print("error while rotating")
            return nil
        }
        
        self.left = newHead.right
        newHead.right = self
        
        newHead.height = newHead.height - 1
        guard let right = newHead.right else {
            print("error while rotating")
            return nil
        }
        newHead.right?.height = right.height + 1
        
        newHead.left?.recAddHeight(height: -1)
        newHead.right?.right?.recAddHeight(height: 1)
        
        
        return newHead;
    }
    
    func balance() -> TreeElement<T>?{
        if balanceFactor() == 2 {
            guard let right = right else {
                print("error while balancing")
                return nil
            }
            
            if right.balanceFactor() < 0 {
                self.right = right.rotateRight()
            }
            return rotateLeft()
        } else if balanceFactor() == -2 {
            
            guard let left = left else {
                print("error while balancing")
                return nil
            }
            
            if left.balanceFactor() > 0 {
                self.left = left.rotateLeft()
            }
            return rotateRight()
        }
        return self
    }
    
    func findMin() -> TreeElement<T>?{
        guard let left = left else {
            return self
        }
        return left.findMin()
    }
    
    func removeMin() -> TreeElement<T>?{
        guard let left = left else {
            return right
        }
        self.left = left.removeMin()
        return balance()
    }
    
    func delete(value: T) -> TreeElement<T>?{
        if value < self.value {
            guard let left = left else {
                print("error while deleting")
                return nil
            }
            self.left = left.delete(value: value)
            self.left?.fixHeight()
        } else if value > self.value {
            guard let right = right else {
                print("error while deleting")
                return nil
            }
            self.right = right.delete(value: value)
            self.right?.fixHeight()
        } else {
            if right == nil { return left }
            guard let right = right else {
                print("error while deleting")
                return nil
            }
            guard let tmpMin = right.findMin() else {
                print("error while deleting")
                return nil
            }
            let min: TreeElement<T> = tmpMin
            min.right = right.removeMin()
            min.left = left
            min.fixHeight()
            return min.balance()
        }
        return balance()
    }
}
