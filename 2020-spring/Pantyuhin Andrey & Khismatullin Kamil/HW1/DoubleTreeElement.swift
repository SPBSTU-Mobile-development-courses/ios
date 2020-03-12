class DoubleTreeElement<T: Comparable>{
    private var element: TreeElement<T>?
    private var parentElement: TreeElement<T>?
    
    init(){
        element = nil
        parentElement = nil
    }
    
    func getElement() -> TreeElement<T>?{
        return element
    }
    func getParentElement() -> TreeElement<T>?{
        return parentElement
    }
    func setElement(element: TreeElement<T>){
        self.element = element
    }
    func setParentElement(element: TreeElement<T>){
        self.parentElement = element
    }
}
