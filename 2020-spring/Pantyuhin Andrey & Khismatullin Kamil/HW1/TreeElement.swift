class TreeElement<T: Comparable>{
    private var value: T
    private var left: TreeElement?
    private var right: TreeElement?
    private var height: Int
    
    init(value: T, parentHeight: Int) {
        self.value = value
        self.left = nil
        self.right = nil
        self.height = parentHeight + 1
    }
    func setLeft(element: TreeElement?){
        self.left = element
    }
    func setRight(element: TreeElement?){
        self.right = element
    }
    func setValue(value: T){
        self.value = value
    }
    func setHeight(height: Int){
        self.height = height
    }
    func getLeft() -> TreeElement?{
        return self.left
    }
    func getRight() -> TreeElement?{
        return self.right
    }
    func getValue() -> T{
        return self.value
    }
    func getHeight() -> Int{
        return self.height
    }
    
    func fixHeight(){
        getLeft()?.setHeight(height: height + 1)
        getLeft()?.fixHeight()
        getRight()?.setHeight(height: height + 1)
        getRight()?.fixHeight()
    }
    
    func getMaxHeight() -> Int{
        
        guard let left = getLeft() else {
            guard let right = getRight() else {
                return height
            }
            return right.getMaxHeight()
        }
        
        guard let right = getRight() else {
            return left.getMaxHeight()
        }
        
        if (right.getMaxHeight() > left.getMaxHeight()) {
            return right.getMaxHeight()
        } else {
            return left.getMaxHeight()
        }
        
    }
    
    func recAdd(value: T) -> TreeElement<T>?{
        if (self.value == value) {
            return(nil)
        }
        
        if (value > self.value) {
            
            guard let tmpRight = right else {
                return self
            }
            return tmpRight.recAdd(value: value)
            
        } else {
            
            guard let tmpLeft = left else {
                return self
            }
            return tmpLeft.recAdd(value: value)
        }
    }
    
    func recPrint(){
        if (height != 1)
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
        if (self.value == value){
            result = DoubleTreeElement<T>()
            result!.setElement(element: self)
        } else {
            if (value > self.value) {
                result = right?.recFind(value: value)
                if ((result?.getParentElement()) == nil) {
                    result?.setParentElement(element: self)
                }
            } else {
                result = left?.recFind(value: value)
                if ((result?.getParentElement()) == nil) {
                    result?.setParentElement(element: self)
                }
            }
        }
        return result
    }
    
    func balanceFactor() -> Int{
        var a: Int? = self.getRight()?.getMaxHeight()
        var b: Int? = self.getLeft()?.getMaxHeight()
        if (a == nil) {a = height}
        if (b == nil) {b = height}
        return (a! - b!)
    }
    
    func rotateLeft() -> TreeElement<T>?{
        guard let newHead = getRight() else {
            Swift.print("error while rotating")
            return nil
        }
        setRight(element: newHead.getLeft())
        newHead.setLeft(element: self)
        
        newHead.setHeight(height: newHead.getHeight() - 1)
        guard let left = newHead.getLeft() else {
            Swift.print("error while rotating")
            return nil
        }
        newHead.getLeft()?.setHeight(height: left.getHeight() + 1)
        
        newHead.getLeft()?.getLeft()?.recAddHeight(height: 1)
        newHead.getRight()?.recAddHeight(height: -1)
        
        return newHead;
    }
    
    func rotateRight() -> TreeElement<T>?{
        guard let newHead = getLeft() else {
            Swift.print("error while rotating")
            return nil
        }
        
        setLeft(element: newHead.getRight())
        newHead.setRight(element: self)
        
        newHead.setHeight(height: newHead.getHeight() - 1)
        guard let right = newHead.getRight() else {
            Swift.print("error while rotating")
            return nil
        }
        newHead.getRight()?.setHeight(height: right.getHeight() + 1)
        
        newHead.getLeft()?.recAddHeight(height: -1)
        newHead.getRight()?.getRight()?.recAddHeight(height: 1)
        
        
        return newHead;
    }
    
    func balance() -> TreeElement<T>?{
        if (balanceFactor() == 2)
        {
            guard let right = getRight() else {
                Swift.print("error while balancing")
                return nil
            }
            
            if (right.balanceFactor() < 0) {
                setRight(element: right.rotateRight())
            }
            return rotateLeft()
        } else if (balanceFactor() == -2) {
            
            guard let left = getLeft() else {
                Swift.print("error while balancing")
                return nil
            }
            
            if (left.balanceFactor() > 0) {
                setLeft(element: left.rotateLeft())
            }
            return rotateRight()
        }
        return self
    }
    
    func findMin() -> TreeElement<T>?{
        guard let left = getLeft() else {
            return self
        }
        return left.findMin()
    }
    
    func removeMin() -> TreeElement<T>?{
        guard let left = getLeft() else {
            return getRight()
        }
        setLeft(element: left.removeMin())
        return balance()
    }
    
    func delete(value: T) -> TreeElement<T>?{
        if (value < self.value){
            guard let left = getLeft() else {
                Swift.print("error while deleting")
                return nil
            }
            setLeft(element: left.delete(value: value))
            getLeft()?.fixHeight()
        } else if (value > self.value) {
            guard let right = getRight() else {
                Swift.print("error while deleting")
                return nil
            }
            setRight(element: right.delete(value: value))
            getRight()?.fixHeight()
        } else {
            if (getRight() == nil) { return getLeft() }
            guard let right = getRight() else {
                Swift.print("error while deleting")
                return nil
            }
            guard let tmpMin = right.findMin() else {
                Swift.print("error while deleting")
                return nil
            }
            let min: TreeElement<T> = tmpMin
            min.setRight(element: right.removeMin())
            min.setLeft(element: getLeft())
            min.fixHeight()
            return min.balance()
        }
        return balance()
        
    }
}
