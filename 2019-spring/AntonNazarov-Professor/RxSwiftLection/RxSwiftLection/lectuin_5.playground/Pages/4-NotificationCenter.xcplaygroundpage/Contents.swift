import Foundation

extension Notification.Name {
    static let myNotification = Notification.Name("myNotification")
}

class Foo {
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(foo), name: .myNotification, object: nil)
    }

    @objc private func foo(notification: Notification) {
        print(notification.object)
    }
}

let foo = Foo()

NotificationCenter.default.post(name: .myNotification, object: "LOL")

