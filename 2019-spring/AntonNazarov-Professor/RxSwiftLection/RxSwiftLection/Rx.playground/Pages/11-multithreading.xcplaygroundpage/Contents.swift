import RxSwift

Observable.just(10)
    .observeOn(MainScheduler.instance)
    .do(onNext: { _ in print(Thread.current) })
    .observeOn(SerialDispatchQueueScheduler(qos: .background))
    .do(onNext: { _ in print(Thread.current) })
    .subscribe(onNext: {
        print(Thread.current)
        print($0)
    })








Observable.just(10)
    .do(onNext: { _ in print(Thread.current) })
    .observeOn(SerialDispatchQueueScheduler(qos: .background))
    .do(onNext: { _ in print(Thread.current) })
    .subscribeOn(MainScheduler.instance)
    .subscribe(onNext: {
        print(Thread.current)
        print($0)
    })
