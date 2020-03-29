import RxSwift
import Alamofire


let stream = Observable<String>.create { observer in
    let request = Alamofire.request("https://swapi.co/api/people/1")
    request.response { one in
        observer.onNext(String(decoding: one.data!, as: UTF8.self))
        observer.onCompleted()
    }
    observer.onNext("started")

    return Disposables.create {
        request.cancel()
    }
}

stream.subscribe(onNext: {
    print($0)
})
