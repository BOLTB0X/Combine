# Subscriber

> A protocol that declares a type that can receive input from a publisher.

```swift
protocol Subscriber<Input, Failure> : CustomCombineIdentifierConvertible
```

- Generic type parameters

  1.  **Input**: Subscriber가 받는 값의 타입
  2.  **Failure**: Subscriber 받을 수 있는 error의 종류
      <br/>

- Subscriber는 Publisher와 함께 동작하여 이벤트 스트림에서 발생하는 data나 eroor를 받아 처리
  <br/>

- Subscriber가 구독을 시작하면, Publisher는 data를 발행하고, Subscriber는 그 data를 받아 특정 작업을 수행하거나 eror를 처리
  <br/>

- susbcriber와 publisher을 연결하기 위해**subscribe(\_:)** 호출, 취소할 경우 **cancel()**
  <br/>

- [receive]()는 Subscriber 프로토콜을 구현할 때 사용하는 메서드
  <br/>

```swift
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

// 구독 start
// Received value: 0
// Received value: 1
// Received value: 2
// Received value: 3
// Received value: 4
// 구독 completion: finished
```

- Subscriber의 동작 방식
  <br/>

  1.  구독 시작
      receive(subscription:) 메서드를 통해 Subscription을 받아서 데이터 요청(request())을 수행
      <br/>

  2.  데이터 수신
      receive(\_: ) 메서드가 호출되며, Publisher가 발행한 값을 처리. Subscribers.Demand를 통해 더 많은 data를 요청할지 선택 가능
      <br/>

  3.  완료 처리
      Publisher가 data를 모두 발행하거나 error가 발생하면 receive(completion:) 메서드가 호출

<br/>

- Subscriber는 세 가지 메서드로 구성되어 있으며, 구독을 시작하고, data를 수신하고, 완료 상태를 처리
  <br/>

- Subscribers.Demand를 통해 수신할 data의 양(수)을 제어 가능하며, Publisher와의 상호작용을 조절이 가능

## 참고

- [공식문서 - subscriber](https://developer.apple.com/documentation/combine/subscriber)

- [블로그 참고](https://ios-development.tistory.com/1117)
