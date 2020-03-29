class Tree<T: Comparable>{
    var head: TreeElement<T>?
    
    init() { }
    
    init(value: T){
        self.head = TreeElement<T>(value: value, parentHeight: 0)
    }
    
    func add(value: T) {
        guard let tmpHead = head else {
            head = TreeElement<T>(value: value, parentHeight: 0)
            print("Seed planted")
            return
        }
        
        if !tmpHead.recAdd(value: value) {
            print("This value already exist:", value)
            return
        }
        
        head = tmpHead.balance()
    }
    
    func printValues(){
        head?.recPrint()
    }
    
    func find(value: T) -> TreeElement<T>?{
        let result = head?.recFind(value: value)
        
        guard let tmpResult = result else {
            print("Element don't exist in this tree:", value)
            return nil
        }
        return tmpResult.getElement()
    }
    
    func delete(value: T){
        if head?.recFind(value: value) == nil
        {
            print("Can't find element to delete:", value)
        } else {
            guard let tmpHead = head else {
                return
            }
            tmpHead.delete(value: value)
        }
    }
}
