import Foundation
import Combine

// MARK: - publisher
let publisher = [0, 1, 2, 3, 4].publisher
publisher.sink {
        print("print: \($0)")
    }

let publishers = Just(10)
    .map { $0 * 2 }
    .eraseToAnyPublisher()

// MARK: - Subscriber

final class IntegerSubscriber: Subscriber {
    typealias Input = Int
    typealias Failure = Never

    func receive(subscription: Subscription) {
        print("구독 start")
        subscription.request(.unlimited)
    }

    func receive(_ input: Int) -> Subscribers.Demand {
        print("Received value: \(input)")
        return .none // 추가 요청 X
    }

    func receive(completion: Subscribers.Completion<Never>) {
        print("구독 completion: \(completion)")
    }
}

let subscriber = IntegerSubscriber()
publisher.subscribe(subscriber)

// MARK: - Weather
class Weather {
    @Published var temperature: Double
    init(temperature: Double) {
        self.temperature = temperature
    }
}


let weather = Weather(temperature: 20)
var cancellable: AnyCancellable? = weather.$temperature
    .sink {
        print ("Temperature now: \($0)")
    }
weather.temperature = 25

// 프로퍼티가 변경되면 프로퍼티의 willSet 블록에서 publishing이 발생
// 즉, subscribers는 프로퍼티에 실제로 설정되기 전에 새 값을 받음
// 위의 예에서 싱크가 두 번째로 폐쇄를 실행할 때 매개변수 값 25를 받음
// 그러나 폐쇄가 Weather.온도를 평가한 경우 반환되는 값은 20

// MARK: - ObservableObject

class Contact: ObservableObject {
    @Published var name: String
    @Published var age: Int
    
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    
    func haveBirthday() -> Int {
        age += 1
        return age
    }
}


let kyungheon = Contact(name: "kyungheon Appleseed", age: 29)
cancellable = kyungheon.objectWillChange
    .sink { _ in
        print("\(kyungheon.age) will change")
    }

print(kyungheon.haveBirthday())

// 29 will change
// 30

// MARK: - objectWillChnage

class Contact2: ObservableObject {
    var age: Int {
        willSet {
            self.objectWillChange.send()
            
        }
    }
    
    init(age: Int) {
        self.age = age
    }
}

var data = Contact2(age: 20)
data.objectWillChange
    .send()

data.objectWillChange
    .sink { print("change age? = \($0)") }

data.age = 29
data.age = 30

// change age? = ()
// change age? = ()

// MARK: - Cancellable

cancellable!.cancel()

// MARK: - AnySubscriber

let anySubscriber = AnySubscriber<Int, Never>(
    receiveSubscription: { subscription in
        print("구독!")
        subscription.request(.unlimited)
    },
    receiveValue: { value in
        print("Received value: \(value)")
        return .none
    },
    receiveCompletion: { completion in
        print("\(completion)")
    }
)

//구독!
//Received value: 0
//Received value: 1
//Received value: 2
//Received value: 3
//Received value: 4
//finished
publisher
    .subscribe(anySubscriber)
