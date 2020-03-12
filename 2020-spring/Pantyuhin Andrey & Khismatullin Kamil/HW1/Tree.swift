class Tree<T: Comparable>{
    var head: TreeElement<T>?
    
    init() {
        self.head = nil
    }
    
    init(value: T){
        self.head = TreeElement<T>(value: value, parentHeight: 0)
    }
    
    func add(value: T) {
        if (head == nil)
        {
            head = TreeElement<T>(value: value, parentHeight: 0)
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
            parentElement?.setRight(element: TreeElement<T>(value: value, parentHeight: parentHeight))
        } else {
            parentElement?.setLeft(element: TreeElement<T>(value: value, parentHeight: parentHeight))
        }
        head = head!.balance()
    }
    
    func print(){
        head?.recPrint()
    }
    
    func find(value: T) -> TreeElement<T>?{
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
