import RxSwift

// http://adamborek.com/memory-managment-rxswift/
// reference cycle

let observable = Observable.just("Lol").delay(1.0, scheduler: MainScheduler.instance)
var disposeBag = DisposeBag()

observable.subscribe(
    onNext: { print("1 \($0)") },
    onDisposed: { print("Disposed") }
)
.disposed(by: disposeBag)


observable.subscribe(
    onNext: { print("2 \($0)") },
    onDisposed: { print("Disposed") }
)
.disposed(by: disposeBag)

disposeBag = DisposeBag()

print("Nothing")

