import RxSwift

let observable = Observable.just("Lol").delay(1.0, scheduler: MainScheduler.instance)

let subscription = observable.subscribe(
    onNext: { print($0) },
    onDisposed: { print("Disposed") }
)

subscription.dispose()

print("Nothing")
