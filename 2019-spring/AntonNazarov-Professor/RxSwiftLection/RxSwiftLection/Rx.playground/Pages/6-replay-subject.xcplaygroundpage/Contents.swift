import RxSwift

// Publish
let subject = ReplaySubject<Int>.create(bufferSize: 3)

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)

subject.subscribe {
    print($0)
}

