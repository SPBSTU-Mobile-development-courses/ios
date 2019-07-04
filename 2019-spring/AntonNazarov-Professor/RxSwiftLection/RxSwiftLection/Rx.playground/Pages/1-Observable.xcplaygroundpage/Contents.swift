import RxSwift

// количество и разнобразие Rx фреймворков
// https://github.com/ReactiveCocoa/ReactiveCocoa
// https://github.com/ReactiveCocoa/ReactiveSwift
// https://github.com/DeclarativeHub/Bond
// https://github.com/JensRavens/Interstellar
// https://github.com/DeclarativeHub/ReactiveKit
// https://github.com/spotify/Mobius.swift //Spotify конечно мдааааа
// но есть только один истинный король
// http://reactivex.io/


let observable2 = Observable.of(1, 2, 4, 5)
observable2.subscribe {
    print($0)
}

/*
public enum Event<Element> {
    case next(Element)

    case error(Swift.Error)

    case completed
}
*/
