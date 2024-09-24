# Empty

> A publisher that never publishes any values, and optionally finishes immediately.

```swift
struct Empty<Output, Failure> where Failure : Error
```

- 아무 값도 방출하지 않고, 즉시 완료되는 퍼블리셔를 생성할 때 사용하는 publisher
  <br/>

- 구독자에게 값 없이 종료 이벤트만 전송

```swift
let emptyPublisher = Empty<Int, Never>()

cancellable = emptyPublisher
    .sink(
        receiveCompletion: { completion in
            print("Completion: \(completion)")
        },
        receiveValue: { value in
            print("Received value: \(value)")
        }
    )
```

## 참고

- [공식문서 - Empty](https://developer.apple.com/documentation/combine/empty)
