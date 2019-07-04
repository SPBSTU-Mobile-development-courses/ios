struct MyError: Error {
}

struct MyOtherError: Error {
}

func getCities(_ completionHandler: (([String]?, Error?) -> Void)) {
    completionHandler(nil, MyError())
}

getCities { cities, error in
    guard error == nil else { return }
}


/*
public enum Result<Success, Failure> where Failure : Error {
    case success(Success)

    case failure(Failure)
}
 */

var result: Result<Int, MyError>
result = .success(1)
result = .failure(MyError())

let mappedResult = result.map { $0 * 2 }
    .mapError { _ in MyOtherError() }
print(mappedResult)




//protocol CityRepository2 {
//    func getCities(_ completionHandler: ((Result<[String], MyError>) -> Void))
//}
