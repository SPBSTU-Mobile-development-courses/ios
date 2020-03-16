class Tree<T: Comparable>{
    var head: TreeElement<T>?
    
    init() {
        self.head = nil
    }
    
    init(value: T){
        self.head = TreeElement<T>(value: value, parentHeight: 0)
    }
    
    func add(value: T) {
        
        guard let tmpHead = head else {
            head = TreeElement<T>(value: value, parentHeight: 0)
            Swift.print("Seed planted")
            return
        }
        let parentElement = head?.recAdd(value: value)
        
        guard let tmpParentElement = parentElement else {
            Swift.print("This value already exist:", value)
            return
        }
        
        let parentHeight = tmpParentElement.getHeight()
        if (value > tmpParentElement.getValue()) {
            tmpParentElement.setRight(element: TreeElement<T>(value: value, parentHeight: parentHeight))
        } else {
            tmpParentElement.setLeft(element: TreeElement<T>(value: value, parentHeight: parentHeight))
        }
        head = tmpHead.balance()
    }
    
    func print(){
        head?.recPrint()
    }
    
    func find(value: T) -> TreeElement<T>?{
        let result = head?.recFind(value: value)
        
        guard let tmpResult = result else {
            Swift.print("Element don't exist in this tree:", value)
            return nil
        }
        return tmpResult.getElement()
    }
    
    func delete(value: T){
        
        if (head?.recFind(value: value) == nil)
        {
            Swift.print("Can't find element to delete:", value)
        } else {
            guard let tmpHead = head else {
                return
            }
            tmpHead.delete(value: value)
        }
    }
}
