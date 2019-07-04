import Foundation

class Configuration: NSObject {
    @objc dynamic var property = 0

    override init() {
        super.init()
        addObserver(self, forKeyPath: #keyPath(property), options: [.old, .new], context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(property) {
            print(property)
        }
    }
}


let configuration = Configuration()
configuration.property = 3
configuration.property = 4
