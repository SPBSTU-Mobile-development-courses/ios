import RxSwift

Observable.of(1, 2, 2, 1, 3, 3)
    .distinctUntilChanged()
    .subscribe(onNext:{
        print($0)
    })
