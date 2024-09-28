# AnyPublisher

> A publisher that performs type erasure by wrapping another publisher.

```swift
@frozen
struct AnyPublisher<Output, Failure> where Failure : Error
```

- Generic type parameters

  1.  **Output**: Publisher가 방출하는 값의 타입
  2.  **Failure**: Publisher가 방출할 수 있는 에러의 종류
      <br/>

- **타입 지우기(Type Erasure)** 를 위한 구조체
  <br/>

- 어떤 Publisher든 다룰 수 있는 유연한 방법이 필요할 때 사용
  <br/>

```swift
let publishers = Just(10)
    .map { $0 * 2 }
    .eraseToAnyPublisher()
// 타입이 AnyPublisher<Int, Never>로 변경 됌
```

<br/>

## 참고

- [공식문서 - anypublisher](https://developer.apple.com/documentation/combine/anypublisher)

- [블로그 참고 - 1](https://ios-development.tistory.com/1117)

- [블로그 참고 - 2](https://sujinnaljin.medium.com/combine-subscriber-409023bc6d89)
