## AnySubscriber

> A type-erasing subscriber.

```swift
@frozen
struct AnySubscriber<Input, Failure> where Failure : Error
```

- Generic type parameters

  1.  **Input**: Subscriber가 받는 값의 타입
  2.  **Failure**: Subscriber 받을 수 있는 error의 종류
      <br/>

- 구체적인 subscriber의 타입을 숨기고, 다양한 subscriber 유형을 하나의 타입으로 취급할 수 있도록 함
  - 타입이 제거된 subscriber
  - 세부 정보를 외부에 숨겨서, 결합도를 낮추는데 사용
    <br/>

```swift
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

publisher
    .subscribe(anySubscriber)
//구독!
//Received value: 0
//Received value: 1
//Received value: 2
//Received value: 3
//Received value: 4
//finished
```

**Subscriber(구체적 타입)** vs **AnySubscriber(타입 지우기)**

- [Subscriber](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic01/Subscriber.md)는 프로토콜이므로 이를 준수하는 타입을 정의하고, 직접적으로 [receive, receive(completion:), receive(subscription:)](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic01/receive.md) 메서드를 구현이 필요
  <br/>
- AnySubscriber는 클로저를 통해 구독자를 정의 가능

## 참고

- [공식문서 - AnySubscriber](https://developer.apple.com/documentation/combine/anysubscriber)

- [블로그 참고 - 김종권 ios(Subscriber)](https://ios-development.tistory.com/1119)
