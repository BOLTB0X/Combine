import SwiftUI
import Combine

final class IntegerSubscriber: Subscriber {
    typealias Input = Int
    typealias Failure = Never

    func receive(subscription: Subscription) {
        print("구독!")
        subscription.request(.unlimited)
    }

    func receive(_ input: Int) -> Subscribers.Demand {
        print("Received value: \(input)")
        return .none
    }

    func receive(completion: Subscribers.Completion<Never>) {
        print("Completed")
    }
}

var intSubscriber = IntegerSubscriber()

let publisher1 = [1, 2, 3, 4, 5].publisher

publisher1
    .subscribe(intSubscriber)

//구독!
//Received value: 1
//Received value: 2
//Received value: 3
//Received value: 4
//Received value: 5
//Completed

let passSubject = PassthroughSubject<Int, Never>()

let subscribersA = passSubject
    .sink { value in
        print("subscribersA received: \(value)")
    }

passSubject.send(1)
passSubject.send(2)

let subscribersB = passSubject
    .sink { value in
        print("subscribersB received: \(value)")
    }

passSubject.send(3)
passSubject.send(4)

passSubject
    .send(completion: .finished)

//subscribersA received: 1
//subscribersA received: 2
//subscribersA received: 3
//subscribersB received: 3
//subscribersA received: 4
//subscribersB received: 4

var currentValue: Int = 0 // 최근 값을 저장하는 변수

currentValue = 0 // 초기 값 발행
let publisher2 = Just(currentValue)

publisher2
    .subscribe(intSubscriber) // 퍼블리셔와 구독자 연결

// 새로운 값 설정 후 발행
currentValue = 2
let publisher3 = Just(currentValue)
publisher3
    .subscribe(intSubscriber)

//구독!
//Received value: 0
//Completed
//구독!
//Received value: 2
//Completed

// CurrentValueSubject 정의 (초기값 0)
let curSubject = CurrentValueSubject<Int, Never>(0)

// subscriberC
let subscriberC = curSubject
    .sink { value in
        print("subscriber C received: \(value)")
    }

// 값 변경
curSubject.send(1)
curSubject.send(2)

// subscriberD
let subscriberD = curSubject
    .sink { value in
        print("subscriber D received: \(value)")
    }

// 값 변경
curSubject.send(3)
curSubject.send(4)

// 완료 이벤트 발행
curSubject
    .send(completion: .finished)

//subscriber C received: 0
//subscriber C received: 1
//subscriber C received: 2
//subscriber D received: 2
//subscriber D received: 3
//subscriber C received: 3
//subscriber D received: 4
//subscriber C received: 4
