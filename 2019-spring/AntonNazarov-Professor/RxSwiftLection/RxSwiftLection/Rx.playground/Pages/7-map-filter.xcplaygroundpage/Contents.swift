// https://habr.com/ru/post/281292/
// https://rxmarbles.com/#combineLatest
// https://www.thedroidsonroids.com/blog/rxswift-by-examples-1-the-basics

import RxSwift

let stream = Observable.of(1, 2, 3)

stream
    .map { $0 * 2 }
    .filter { $0 != 4 }
    .subscribe {
        print($0)
    }
