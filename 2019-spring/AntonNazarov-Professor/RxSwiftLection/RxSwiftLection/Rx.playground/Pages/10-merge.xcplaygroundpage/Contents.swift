import RxSwift

let publish1 = PublishSubject<Int>()
let publish2 = PublishSubject<Int>()
Observable.of(publish1, publish2)
    .merge()
    .subscribe(onNext:{
        print($0)
    })

publish1.onNext(20)
publish1.onNext(40)
publish1.onNext(60)
publish2.onNext(1)
publish1.onNext(80)
publish2.onNext(2)
publish1.onNext(100)
