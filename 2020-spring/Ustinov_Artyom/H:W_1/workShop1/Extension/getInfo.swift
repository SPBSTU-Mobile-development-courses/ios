import Foundation

extension BinaryTree {
    
    func getInfo() {
        print("\n NODE -> LEFT -> RIGHT")
        self.preorder(self.rootNode)
        print("\n LEFT -> NODE -> RIGHT")
        self.inorder(self.rootNode)
        print("\n LEFT -> RIGHT -> NODE")
        self.postorder(self.rootNode)
        print("\n")
    }
    
    //LRN
    private func inorder(_ node: TreeNode<T>?) {
        guard let _ = node else { return }
        self.inorder(node?.leftNode)
        print("\(node!.data)", terminator: " ")
        self.inorder(node?.rightNode)
    }
    
    //NLR
    private func preorder(_ node: TreeNode<T>?) {
        guard let _ = node else { return }
        print("\(node!.data)", terminator: " ")
        self.preorder(node?.leftNode)
        self.preorder(node?.rightNode)
    }
    //LRN
    private func postorder(_ node: TreeNode<T>?) {
        guard let _ = node else { return }
        self.postorder(node?.leftNode)
        self.postorder(node?.rightNode)
        print("\(node!.data)", terminator: " ")
    }
}
