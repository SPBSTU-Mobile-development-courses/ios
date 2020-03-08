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
    func getLeft() -> Element?{
        return self.left
    }
    func getRight() -> Element?{
        return self.right
    }
    func getValue() -> T?{
        return self.value
    }
    
    func setHeight(value: Int){
        self.height = value
    }
    func getHeight() -> Int{
        return self.height
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
    func recPrint(height: Int){
        let newHeight = height + 1
        var spaces: String = ""
        for _ in 1...newHeight{
            spaces = spaces + " "
        }
        print(spaces, value)
        left?.recPrint(height: (newHeight))
        right?.recPrint(height: (newHeight))
        
    }
    func recChangeHeight(height: Int){
        setHeight(value: (getHeight() + height))
//        if (left != nil)
//        {
            left?.recChangeHeight(height: height)
//        }
//        if (right != nil)
//        {
            right?.recChangeHeight(height: height)
//        }
    }
    func recFind(value: T) -> DoubleElement<T>?{
        var result: DoubleElement<T>?
        if (self.value == value){
            result = DoubleElement<T>()
            result!.setElement(element: self)
            return result
        } else {
            if (value > self.value) {
                if (right == nil) {
                    return nil;
                } else {
                    result = right!.recFind(value: value)
                    if (result != nil) {
                        if ((result!.getParentElement()) != nil) {
                            return result
                        } else {
                            result!.setParentElement(element: self)
                            return result
                        }
                    }
                    return nil
                }
            } else {
                if (left == nil) {
                    return nil;
                } else {
                        result = left!.recFind(value: value)!
                        if (result != nil) {
                            if ((result!.getParentElement()) != nil) {
                                return result
                            } else {
                                result!.setParentElement(element: self)
                                return result
                            }
                        }
                    return nil
                    }
            }
        }
    }
}

class Tree<T: Comparable>{
    var head: Element<T>
    
    init(value: T){
        self.head = Element(value: value, parentHeight: 0)
    }
    
    func add(value: T) {
        let parentElement = head.recAdd(value: value)
        if (parentElement == nil) {
            return
        }
        if (value > parentElement!.getValue()!) {
            parentElement?.setRight(element: Element(value: value, parentHeight: parentElement!.getHeight()))
        } else {
            parentElement?.setLeft(element: Element(value: value, parentHeight: parentElement!.getHeight()))
        }
       
    }
    func print(){
        head.recPrint(height: 0)
    }
    func find(value: T) -> Element<T>?{
        let result = head.recFind(value: value)
        if ((result != nil) && (result?.getParentElement() != nil)) {
//            Swift.print(result!.getParentElement()!.getValue())
        }
        return result?.getElement()
    }
    func delete(value: T){
        var element = head.recFind(value: value)?.getElement()
        var parent = head.recFind(value: value)?.getParentElement()
        
        if (head.getValue() != value) {
            if (parent?.getRight() != nil) && (parent?.getRight()?.getValue() == value){
            
                if (element!.getRight() != nil) {
                    parent?.setRight(element: element!.getRight()!)
                    if (element!.getLeft() != nil) {
                        var tmp: Element<T> = (element?.getRight())!
                        while (tmp.getLeft() != nil){
                            tmp = tmp.getLeft()!
                        }
                        tmp.setLeft(element: element!.getLeft()!)
                    } else {
                        parent?.setRight(element: nil)
                    }
                    
                } else {
                    if (element!.getLeft() != nil) {
                        parent?.setRight(element: element!.getLeft()!)
                    } else { parent?.setRight(element: nil) }
                }
            } else if (parent?.getLeft() != nil) {
                if (element!.getRight() != nil) {
                    parent?.setLeft(element: element!.getRight()!)
                    if (element!.getLeft() != nil) {
                       var tmp: Element<T> = (element?.getRight())!
                        while (tmp.getLeft() != nil){
                            tmp = tmp.getLeft()!
                        }
                        tmp.setLeft(element: element!.getLeft()!)
                    } else {
                        parent?.setLeft(element: nil)
                    }
                    
                } else {
                    if (element!.getLeft() != nil) {
                        parent?.setLeft(element: element!.getLeft()!)
                    } else { parent?.setLeft(element: nil) }
                }
            }
        } else {
            if (head.getLeft() == nil){
                if (head.getRight() == nil)
                {
                    Swift.print("tree has been cuzzzzzzt")
                } else {
                    self.head = head.getRight()!
                }
            } else {
                if (head.getRight() == nil)
                {
                    self.head = head.getLeft()!
                } else {
                    var tmp: Element<T> = (head.getRight())!
                    while (tmp.getLeft() != nil){
                        tmp = tmp.getLeft()!
                    }
                    tmp.setLeft(element: head.getLeft()!)
                    self.head = head.getRight()!
                }
                
            }
        }
        //parent.setRight(element: element.getRight)
            //удаление
        
    }
}

var oak: Tree<Int> = Tree<Int>(value: 6)
//var i: Int = 0
//for i in 1...10{
//    oak.add(value: i)
//}

oak.add(value: 5)
oak.add(value: 6)
oak.add(value: 3)
oak.add(value: 1)
oak.add(value: 13)

oak.print()
Swift.print()

//if (oak.find(value: 1) == nil) {
//    print("пусто")
//} else {
//    print(oak.find(value: 1)?.getRight()?.getValue() ?? 0)
//
//}

oak.delete(value: 13)
oak.print()
