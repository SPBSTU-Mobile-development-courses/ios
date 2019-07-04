enum Event {
    case hello(String)
}

protocol Observer: AnyObject {
    func handle(_ event: Event)
}

// Push vs pull interfaces



protocol Observable {
    func notifyAll(about event: Event)
    func register(_ observer: Observer)
    func remove(_ observer: Observer)
}


final class ObservableImpl: Observable {
    var listeners = [Observer]()

    func register(_ observer: Observer) {
        listeners.append(observer)
    }

    func remove(_ observer: Observer) {
        listeners = listeners.filter { $0 !== observer }
    }

    func notifyAll(about event: Event) {
        listeners.forEach {
            $0.handle(event)
        }
    }
}

final class ObserverImpl: Observer {
    final let n: Int

    init(n: Int) {
        self.n = n
    }

    func handle(_ event: Event) {
        print("\(n) - \(event)")
    }
}

let observable: Observable = ObservableImpl()
let observer1 = ObserverImpl(n: 1)
observable.register(observer1)
observable.register(ObserverImpl(n: 2))

observable.notifyAll(about: .hello("Hello"))
observable.notifyAll(about: .hello("How are you"))

observable.remove(observer1)

observable.notifyAll(about: .hello("Where are you"))
