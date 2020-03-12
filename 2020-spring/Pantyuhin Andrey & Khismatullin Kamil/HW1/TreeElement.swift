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
    func getValue() -> T?{
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
        if (getLeft() == nil) {
            if (getRight() == nil) {
                return height
            } else {
                return getRight()!.getMaxHeight()
            }
        } else {
            if (getRight() == nil) {
                return getLeft()!.getMaxHeight()
            } else {
                if (getRight()!.getMaxHeight() > getLeft()!.getMaxHeight()) {
                    return getRight()!.getMaxHeight()
                } else {
                    return getLeft()!.getMaxHeight()
                }
            }
        }
    }
    
    func recAdd(value: T) -> TreeElement<T>?{
        if (self.value == value) {
            return(nil)
        }
        
        if (value > self.value) {
            if (right == nil){
                return self
            } else {
                return right!.recAdd(value: value)
            }
        } else {
            if (left == nil){
                return self
            } else {
                return left!.recAdd(value: value)
            }
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
                result = left?.recFind(value: value)!
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
    
    func rotateLeft() -> TreeElement<T>{
        let newHead: TreeElement<T> = getRight()!;
        setRight(element: newHead.getLeft());
        newHead.setLeft(element: self);
        
        newHead.setHeight(height: newHead.getHeight() - 1)
        newHead.getLeft()?.setHeight(height: newHead.getLeft()!.getHeight() + 1)
        
        newHead.getLeft()?.getLeft()?.recAddHeight(height: 1)
        newHead.getRight()?.recAddHeight(height: -1)
        
        return newHead;
    }
    
    func rotateRight() -> TreeElement<T>{
        let newHead: TreeElement<T> = getLeft()!;
        setLeft(element: newHead.getRight());
        newHead.setRight(element: self);
        
        newHead.setHeight(height: newHead.getHeight() - 1)
        newHead.getRight()?.setHeight(height: newHead.getRight()!.getHeight() + 1)
        
        newHead.getLeft()?.recAddHeight(height: -1)
        newHead.getRight()?.getRight()?.recAddHeight(height: 1)
        
        
        return newHead;
    }
    
    func balance() -> TreeElement<T>{
        if (balanceFactor() == 2)
        {
            if (getRight()!.balanceFactor() < 0) {
                setRight(element: getRight()!.rotateRight())
            }
            return rotateLeft()
        } else if (balanceFactor() == -2) {
            
            if (getLeft()!.balanceFactor() > 0) {
                setLeft(element: getLeft()!.rotateLeft())
            }
            return rotateRight()
        }
        return self
    }
    
    func findMin() -> TreeElement<T> {
        if (getLeft() == nil)
        {
            return self
        } else {
            return getLeft()!.findMin()
        }
    }
    
    func removeMin() -> TreeElement<T>{
        if (getLeft() == nil) {
            return getRight()!
        }
        setLeft(element: getLeft()!.removeMin())
        return balance()
    }
        
    func delete(value: T) -> TreeElement<T>?{
            
        if (value < getValue()!){
            setLeft(element: getLeft()!.delete(value: value))
            getLeft()?.fixHeight()
        } else if (value > getValue()!) {
            setRight(element: getRight()!.delete(value: value))
            getRight()?.fixHeight()
        } else {
            if (getRight() == nil) { return getLeft() }
            let min: TreeElement<T> = getRight()!.findMin()
            min.setRight(element: getRight()!.removeMin())
            min.setLeft(element: getLeft())
            min.fixHeight()
            return min.balance()
        }
        return balance()
        
    }
}
