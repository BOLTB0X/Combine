# Publisher

> Declares that a type can transmit a sequence of values over time.

```swift
protocol Publisher<Output, Failure>
```

- Combine 프레임워크의 핵심 프로토콜로, 데이터를 발행하는 객체

- 이벤트 스트림을 생성하고, Subscriber가 구독하면 이 스트림을 통해 data를 전달

- Publisher는 단순히 data를 방출하는 역할

```swift
//
let publisher = [0, 1, 2, 3, 4].publisher
publisher.sink {
        print("print: \($0)")
    }
// print: 0
// print: 1
// print: 2
// print: 3
// print: 4
```

# AnyPublisher

> A publisher that performs type erasure by wrapping another publisher.

```swift
@frozen
struct AnyPublisher<Output, Failure> where Failure : Error
```

- **타입 지우기(Type Erasure)** 를 위한 구조체

- 어떤 Publisher든 다룰 수 있는 유연한 방법이 필요할 때 사용

```swift
let publishers = Just(10)
    .map { $0 * 2 }
    .eraseToAnyPublisher()
// 타입이 AnyPublisher<Int, Never>로 변경 됌
```

## 참고

- [공식문서 - publisher](https://developer.apple.com/documentation/combine/publisher)

- [공식문서 - anypublisher](https://developer.apple.com/documentation/combine/anypublisher)

- [블로그 참고](https://ios-development.tistory.com/1117)
