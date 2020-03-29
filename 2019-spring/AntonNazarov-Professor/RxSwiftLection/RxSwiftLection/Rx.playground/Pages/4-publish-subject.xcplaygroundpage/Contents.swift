import RxSwift

// Publish
let subject = PublishSubject<Int>()

subject.onNext(1)

subject.subscribe {
    print($0)
}

subject.onNext(2)
