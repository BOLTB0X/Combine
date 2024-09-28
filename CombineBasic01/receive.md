# receive

- Receiving Elements: **receive(\_ : )**, **receive()**

- Receiving Life Cycle Events: **eceive(subscription: )**, **receive(completion: )**

## receive(\_ : )

> Tells the subscriber that the publisher has produced an element.

```swift
func receive(_ input: Self.Input) -> Subscribers.Demand
```

- Publisher로부터 새로운 값을 받을 때 호출
  <br/>
- 예시
  ```swift
  func receive(_ input: Int) -> Subscribers.Demand {
       print("Received value: \(input)")
       return .none // 추가 요청 X
  }
  ```

## receive()

> Tells the subscriber that a publisher of void elements is ready to receive further requests.

```swift
func receive() -> Subscribers.Demand
```

- Void 형 publisher가 추가 요청을 받을 준비가 되었음을 subscriber에게 알리는 용도의 메서드

## receive(subscription:)

> Tells the subscriber that it has successfully subscribed to the publisher and may request items.

```swift
func receive(subscription: any Subscription)
```

- 구독이 시작되었을 때 호출되는 메서드
  <br/>

- 예시
  ```swift
  func receive(subscription: Subscription) {
    print("구독 start")
    subscription.request(.unlimited)
  }
  ```

## receive(completion: )

> Tells the subscriber that the publisher has completed publishing, either normally or with an error.

```swift
func receive(completion: Subscribers.Completion<Self.Failure>)
```

- completion: Subscribers.Completion은 Success 또는 Failure의 결과를 나타내는 열거형

  - .finished: Publisher가 정상적으로 완료된 경우.
  - .failure(Error): Publisher가 오류와 함께 종료된 경우.
    <br/>

- Publisher가 완료 이벤트(성공 또는 실패)를 보낼 때 호출하는 메서드
  <br/>

- 예시
  ```swift
  func receive(completion: Subscribers.Completion<Never>) {
    print("구독 completion: \(completion)")
  }
  ```

## 참고

- [공식문서 - receive(\_ : )](<https://developer.apple.com/documentation/combine/subscriber/receive(_:)>)

- [공식문서 - receive()](<https://developer.apple.com/documentation/combine/subscriber/receive()>)

- [공식문서 - receive(subscription:)](<https://developer.apple.com/documentation/combine/subscriber/receive(subscription:)>)

- [공식문서 - receive(completion: )](<https://developer.apple.com/documentation/combine/subscriber/receive(completion:)>)
