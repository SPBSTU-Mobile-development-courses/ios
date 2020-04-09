class Tree <type: Comparable> {
    
    private class Node<type> {
        var data: type;
        var height: Int;
        var left: Node?;
        var right: Node?;
        
        init (data: type) {
            self.data = data;
            self.height = 1;
            self.left = nil;
            self.right = nil;
        }
    }
    
    private var Root: Node<type>?;
    
    private func get_height(_ node: Node<type>?)->Int {
        if (node != nil) {
            return node!.height;
        }
        return 0;
    }
    private func BF(_ node: Node<type>?)->Int {
        return get_height(node?.left) - get_height(node?.right)
    }
    private func overheight(_ node: Node<type>?) {
        let left = get_height(node?.left);
        let right = get_height(node?.right);
        node?.height = max(left, right) + 1;
    }
    
    private func right_rotation(_ node: Node<type>)->Node<type> {
        let tmp = node.left;
        node.left = tmp?.right;
        overheight(node);
        overheight(tmp);
        return tmp!;
    }
    private func left_rotation(_ node: Node<type>)->Node<type> {
        let tmp = node.right;
        node.left = tmp?.left;
        overheight(node);
        overheight(tmp);
        return tmp!;
    }
    
    private func balance(_ node: Node<type>)->Node<type> {
        overheight(node);
        if (BF(node) == 2) {
            if (BF(node.right) < 0) {
                guard let right = node.right else {
                    return node
                }
                node.right = right_rotation(right);
            }
            return left_rotation(node)
        }
        if (BF(node) == -2) {
            if (BF(node.left) > 0) {
                guard let left = node.left else {
                    return node
                }
                node.left = left_rotation(left);
            }
            return right_rotation(node)
        }
        return node
    }
    
    func insert(_ data: type) {
        let new_node = Node(data: data);
        if let not_nil_root = self.Root {
            self.insert_rec(not_nil_root, new_node);
        }
        else {
            self.Root = new_node;
        }
    }
    
    private func insert_rec(_ parent: Node<type>, _ node: Node<type>)->Node<type> {
        if parent.data > node.data {
            if let not_nil_descendant = parent.left {
                self.insert_rec(not_nil_descendant, node);
            }
            else {
                parent.left = node;
            }
        }
        else {
            if let not_nil_descendant = parent.right {
                self.insert_rec(not_nil_descendant, node);
            }
            else {
                parent.right = node;
            }
        }
        return balance(node);
    }
    
    func search (_ data: type)->Bool {
        var p: Node<type>? = self.Root;
        while (p != nil) {
            if (p!.data > data) {
                p = p?.left;
            }
            else if (p!.data < data) {
                p = p?.right;
            }
            else {
                return true;
            }
        }
        return false;
    }
    
    private func min_value (_ node: Node<type>?)->Node<type> {
        var tmp = node;
        while let next = tmp?.left {
            tmp =  next;
        }
        return tmp!;
    }
    private func remove_min(_ node: Node<type>)->Node<type>? {
        guard let left = node.left else {
            return node.right;
        }
        node.left = remove_min(left);
        return balance(node);
    }
    
    func delete (_ data: type) {
        let node = Node(data: data);
        if let p = self.Root {
            self.delete_rec (p, node);
        }
        else {
            self.Root = node;
        }
    }
    private func delete_rec (_ parent: Node<type>?, _ node: Node<type>)->Node<type>? {
        guard var parent = parent else {
            return nil;
        }
        if node.data < parent.data {
            parent.left = delete_rec(parent.left, node);
        }
        else if node.data > parent.data {
            parent.right = delete_rec (parent.right, node);
        }
        else {
            guard let right = parent.right else {
                return parent.left;
            }
            guard let left = parent.left else {
                return parent.right;
            }
            parent = min_value (right);
            parent.right = remove_min (right);
            parent.left = left;
            return balance (node);
        }
        return balance(node);
    }
    
    func print_in_order() {
        self.in_order_rec(self.Root);
    }
    func print_pre_order() {
        self.pre_order_rec(self.Root);
    }
    func print_post_order() {
        self.post_order_rec(self.Root);
    }
    
    private func in_order_rec(_ node: Node<type>?) {
        guard node != nil else {
            return;
        }
        self.in_order_rec (node?.left);
        print ("\(node!.data)", terminator: " ");
        self.in_order_rec(node?.right);
    }
    private func pre_order_rec (_ node: Node<type>?) {
        guard node != nil else {
            return;
        }
        print ("\(node!.data)", terminator: " ");
        self.pre_order_rec (node?.left);
        self.pre_order_rec(node?.right);
    }
    private func post_order_rec (_ node: Node<type>?) {
        guard node != nil else {
            return;
        }
        self.post_order_rec (node?.left);
        self.post_order_rec(node?.right);
        print ("\(node!.data)", terminator: " ");
        }
}

var tree = Tree<Int>();

let elems = [11,3,14,13,18,9];
for index in elems {
    tree.insert(index);
}

print("In-order: ");
tree.print_in_order();

print("\nPost-order: ");
tree.print_post_order();

print("\nSearch for 3: ", tree.search(3));

tree.delete(3);

print("\nPre-opder (without 3): ");
tree.print_pre_order();

print("\nSearch for 3: ", tree.search(3));
