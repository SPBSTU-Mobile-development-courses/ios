import RxSwift

let sequence1  = Observable<Int>.of(1,2)
let sequence2  = Observable<Int>.of(1,2)
let sequenceOfSequences = Observable.of(sequence1,sequence2)
sequenceOfSequences.flatMap{ return $0 }.subscribe(onNext:{
    print($0)
})
