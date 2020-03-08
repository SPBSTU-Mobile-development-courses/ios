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

    func recPrint(){
        if (self.height != 1)
        {
            var spaces: String = ""
            for _ in 1...(self.height-1){
                spaces = spaces + " "
            }
            print(spaces.dropLast(), value)
        } else {
            print(value)
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
}

class Tree<T: Comparable>{
    var head: Element<T>?
    
	init() {
		self.head = nil
	}
	
    init(value: T){
        self.head = Element(value: value, parentHeight: 0)
    }
    
    func add(value: T) {
        if (head == nil)
        {
            head = Element(value: value, parentHeight: 0)
            Swift.print("Seed planted")
            return
        }
        let parentElement = head?.recAdd(value: value)
        if (parentElement == nil) {
            Swift.print("This value already exist:", value)
            return
        }
		var parentHeight = parentElement!.getHeight()
        if (value > parentElement!.getValue()!) {
            parentElement?.setRight(element: Element(value: value, parentHeight: parentHeight))
        } else {
            parentElement?.setLeft(element: Element(value: value, parentHeight: parentHeight))
        }
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
        var finded = head?.recFind(value: value)
        if (finded == nil)
        {
            Swift.print("Can't find element to delete:", value)
            return
        }
        var element = finded!.getElement()
        var parent = finded!.getParentElement()
        
        if (parent != nil) {
            if (parent?.getRight()?.getValue() == value){
                if (element!.getRight() != nil) {
                    parent!.setRight(element: element!.getRight()!)
                    parent!.getRight()!.recAddHeight(height: -1)
                    if (element!.getLeft() != nil) {
                        var tmp: Element<T> = (element?.getRight())!
                        while (tmp.getLeft() != nil){
                            tmp = tmp.getLeft()!
                        }
                        tmp.setLeft(element: element!.getLeft()!)
						var lastLHeight = tmp.getHeight()
						var currentLHeight = tmp.getLeft()!.getHeight()
                        tmp.getLeft()!.recAddHeight(height: (lastLHeight - currentLHeight + 1))
                    } 
                } else {
                    if (element!.getLeft() != nil) {
                        parent?.setRight(element: element!.getLeft()!)
                        parent!.getRight()!.recAddHeight(height: -1)
                    } else {
                        parent?.setRight(element: nil)
                    }
                }
            } else if (parent?.getLeft() != nil) {
                if (element!.getRight() != nil) {
                    parent?.setLeft(element: element!.getRight()!)
                    parent!.getLeft()!.recAddHeight(height: -1)
                    if (element!.getLeft() != nil) {
                       var tmp: Element<T> = (element?.getRight())!
                        while (tmp.getLeft() != nil){
                            tmp = tmp.getLeft()!
                        }
                        tmp.setLeft(element: element!.getLeft()!)
                        var lastLHeight = tmp.getHeight()
						var currentLHeight = tmp.getLeft()!.getHeight()
                        tmp.getLeft()!.recAddHeight(height: (lastLHeight - currentLHeight + 1))
                    } 
                } else {
                    if (element!.getLeft() != nil) {
                        parent?.setLeft(element: element!.getLeft()!)
                        parent!.getLeft()!.recAddHeight(height: -1)
                    } else {
                        parent?.setLeft(element: nil)
                    }
                }
            }
        } else {
            if (head!.getLeft() == nil){
                if (head!.getRight() == nil)
                {
                    head = nil
                    Swift.print("Tree has been cut")
                } else {
                    self.head = head!.getRight()!
                    self.head!.recAddHeight(height: -1)
                }
            } else {
                if (head!.getRight() == nil)
                {
                    self.head = head!.getLeft()!
                    self.head!.recAddHeight(height: -1)
                } else {
                    self.head!.getRight()!.recAddHeight(height: -1)
                    var tmp: Element<T> = (head?.getRight())!
                    while (tmp.getLeft() != nil){
                        tmp = tmp.getLeft()!
                    }
                    tmp.setLeft(element: head?.getLeft()!)
                    var lastLHeight = tmp.getHeight()
					var currentLHeight = tmp.getLeft()!.getHeight()
                    tmp.getLeft()!.recAddHeight(height: (lastLHeight - currentLHeight + 1))
                    self.head = head!.getRight()!
                }
            }
        }
    }
}

var oak: Tree<Int> = Tree<Int>()

oak.add(value: 20)
oak.add(value: 30)
oak.add(value: 33)
oak.add(value: 34)
oak.add(value: 32)
oak.add(value: 25)
oak.add(value: 28)
oak.add(value: 21)
oak.add(value: 15)
oak.add(value: 17)
oak.add(value: 18)
oak.add(value: 16)
oak.add(value: 12)
oak.add(value: 10)
oak.add(value: 13)
oak.add(value: 30)

oak.print()
Swift.print()

oak.delete(value: 15)
oak.print()
