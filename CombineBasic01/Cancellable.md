# Cancellable & AnyCancellable

## Cancellable

> A protocol indicating that an activity or action supports cancellation.

```swift
protocol Cancellable
```

- Combine 작업들을 취소할 수 있는 프로토콜
  <br/>

- 주된 역할은 구독을 취소하는 것
  <br/>

- Combine에서는 Publisher가 data를 계속해서 발행하고 Subscriber가 그 data를 구독하는 구조이므류 Cancellable은 이러한 구독을 사용자가 원할 때 중단 시키는 것
  <br/>

```swift
let cancellable = publisher.sink { value in
    print("Received value: \(value)")
}

cancellable.cancel()
```

<br/>

- **메모리 관리**
  UI 업데이트나 네트워크 요청 구독 시, 특정 시점에 더 이상 필요하지 않으면 구독을 취소하여 메모리 누수를 방지
- **구독 제어**
  이벤트 스트림이 계속해서 실행되지 않도록 원하는 시점에 구독을 중단하거나 다른 로직을 수행이 가능

## AnyCancellable

> A type-erasing cancellable object that executes a provided closure when canceled.

```swift
final class AnyCancellable
```

- Cancellable 프로토콜을 구현한 구체적인 클래스
  <br/>

- AnyCancellable은 이를 실제로 구현한 타입으로, 주로 Combine에서 구독을 취소할 때 사용
  <br/>

- **구독 관리**
  AnyCancellable을 통해 구독이 자동으로 관리되며, 더 이상 필요하지 않을 때 구독을 취소 가능
  <br/>

- **자동 구독 취소**
  AnyCancellable 객체가 메모리에서 해제될 때(deinit될 때), 구독이 자동으로 취소가 됨
  즉, 명시적으로 cancel() 메서드를 호출하지 않아도, AnyCancellable 객체가 더 이상 참조되지 않으면 구독이 중단이 되는 것
  <br/>

- **Type Erasure**
  AnyCancellable은 타입 소거(type erasure) 방식으로 여러 종류의 Cancellable을 하나의 타입으로 다룰 수 있게 함
  이를 통해 다양한 구독 객체들을 통일된 타입으로 관리 가능

## 참고

- [공식문서 - Cancellable](https://developer.apple.com/documentation/combine/cancellable)

- [공식문서 - AnyCancellable](https://developer.apple.com/documentation/combine/anycancellable)

- [블로그 참조](https://ios-development.tistory.com/1116)
