import RxSwift


let a = BehaviorSubject<Int>(value: 2)
let b = BehaviorSubject<Int>(value: 2)

Observable.combineLatest(a.asObservable(), b.asObservable()) {
    $0 + $1
}
.subscribe(onNext: { print($0) })

b.onNext(3)
b.value()




// Publish
let subject = BehaviorSubject<Int>(value: 0)

//subject.onNext(1)

subject.subscribe {
    print($0)
}

subject.onNext(2)

print(subject.value())
