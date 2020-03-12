class DoubleElement<T: Comparable>{
    private var element: Element<T>?
    private var parentElement: Element<T>?
    
    init(){
        element = nil
        parentElement = nil
    }
    
    func getElement() -> Element<T>?{
        return element
    }
    func getParentElement() -> Element<T>?{
        return parentElement
    }
    func setElement(element: Element<T>){
        self.element = element
    }
    func setParentElement(element: Element<T>){
        self.parentElement = element
    }
}

class Element<T: Comparable>{
    private var value: T
    private var left: Element?
    private var right: Element?
    private var height: Int
    
    init(value: T, parentHeight: Int) {
        self.value = value
        self.left = nil
        self.right = nil
        self.height = parentHeight + 1
    }
    func setLeft(element: Element?){
        self.left = element
    }
    func setRight(element: Element?){
        self.right = element
    }
    func setValue(value: T){
        self.value = value
    }
    func setHeight(height: Int){
        self.height = height
    }
    func getLeft() -> Element?{
        return self.left
    }
    func getRight() -> Element?{
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
    
    func recAdd(value: T) -> Element<T>?{
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
    
    func recFind(value: T) -> DoubleElement<T>?{
        var result: DoubleElement<T>?
        if (self.value == value){
            result = DoubleElement<T>()
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
    
    func rotateLeft() -> Element<T>{
        let newHead: Element<T> = getRight()!;
        setRight(element: newHead.getLeft());
        newHead.setLeft(element: self);
        
        newHead.setHeight(height: newHead.getHeight() - 1)
        newHead.getLeft()?.setHeight(height: newHead.getLeft()!.getHeight() + 1)
        
        newHead.getLeft()?.getLeft()?.recAddHeight(height: 1)
        newHead.getRight()?.recAddHeight(height: -1)
        
        return newHead;
    }
    
    func rotateRight() -> Element<T>{
        let newHead: Element<T> = getLeft()!;
        setLeft(element: newHead.getRight());
        newHead.setRight(element: self);
        
        newHead.setHeight(height: newHead.getHeight() - 1)
        newHead.getRight()?.setHeight(height: newHead.getRight()!.getHeight() + 1)
        
        newHead.getLeft()?.recAddHeight(height: -1)
        newHead.getRight()?.getRight()?.recAddHeight(height: 1)
        
        
        return newHead;
    }
    
    func balance() -> Element<T>{
        if (balanceFactor() == 2)
        {
            if (getRight()!.balanceFactor() < 0) {
                setRight(element: getRight()!.rotateRight())
            }
//            Swift.print("factor = ", balanceFactor())
            return rotateLeft()
        } else if (balanceFactor() == -2) {
            
            if (getLeft()!.balanceFactor() > 0) {
                setLeft(element: getLeft()!.rotateLeft())
            }
//            Swift.print("factor = ", balanceFactor())
            return rotateRight()
        }
//        Swift.print("factor = ", balanceFactor())
        return self
    }
    
    func findMin() -> Element<T> {
        if (getLeft() == nil)
        {
            return self
        } else {
            return getLeft()!.findMin()
        }
    }
    
    func removeMin() -> Element<T>{
        if (getLeft() == nil) {
            return getRight()!
        }
        setLeft(element: getLeft()!.removeMin())
        return balance()
    }
        
    func delete(value: T) -> Element<T>?{
            
        if (value < getValue()!){
            setLeft(element: getLeft()!.delete(value: value))
            getLeft()?.fixHeight()
        } else if (value > getValue()!) {
            setRight(element: getRight()!.delete(value: value))
            getRight()?.fixHeight()
        } else {
            if (getRight() == nil) { return getLeft() }
            let min: Element<T> = getRight()!.findMin()
            min.setRight(element: getRight()!.removeMin())
            min.setLeft(element: getLeft())
            min.fixHeight()
            return min.balance()
        }
        return balance()
        
    }
}

class Tree<T: Comparable>{
    var head: Element<T>?
    
    init() {
        self.head = nil
    }
    
    init(value: T){
        self.head = Element<T>(value: value, parentHeight: 0)
    }
    
    func add(value: T) {
        if (head == nil)
        {
            head = Element<T>(value: value, parentHeight: 0)
            Swift.print("Seed planted")
            return
        }
        let parentElement = head?.recAdd(value: value)
        if (parentElement == nil) {
            Swift.print("This value already exist:", value)
            return
        }
        let parentHeight = parentElement!.getHeight()
        if (value > parentElement!.getValue()!) {
            parentElement?.setRight(element: Element<T>(value: value, parentHeight: parentHeight))
        } else {
            parentElement?.setLeft(element: Element<T>(value: value, parentHeight: parentHeight))
        }
        head = head!.balance()
    }
    
    func print(){
        head?.recPrint()
    }
    
    func find(value: T) -> Element<T>?{
        let result = head?.recFind(value: value)
        if (result != nil)
        {
            return result?.getElement()
        }
        Swift.print("Element don't exist in this tree:", value)
        return nil
    }
    
    func delete(value: T){
        if (head?.recFind(value: value) == nil)
        {
            Swift.print("Can't find element to delete:", value)
        } else {
            head!.delete(value: value)
        }
    }
}

var oak: Tree<Int> = Tree<Int>()

oak.add(value: 20)
oak.add(value: 25)
oak.add(value: 22)
oak.add(value: 28)
oak.add(value: 26)
oak.add(value: 27)
oak.add(value: 32)
oak.add(value: 15)
oak.add(value: 17)
oak.add(value: 13)
oak.add(value: 19)
oak.add(value: 18)

oak.print()
Swift.print()
Swift.print("deleating:")

oak.delete(value: 15)

oak.print()


