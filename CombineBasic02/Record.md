# Record

> A publisher that allows for recording a series of inputs and a completion, for later playback to each subscriber.

```swift
struct Record<Output, Failure> where Failure : Error
```

- 정해진 일련의 값을 미리 준비해두고, 즉시 퍼블리싱하거나, 사용자가 요청할 때 퍼블리싱할 수 있는 publisher
  <br/>

- 동작을 테스트하거나 시뮬레이션할 때 주로 사용, 동기 및 비동기 방식으로 구독자에게 값을 제공 가능
  <br/>

```swift
let recordPublisher = Record<Int, Never> { record in
    record.receive(0)
    record.receive(1)
    record.receive(2)
    record.receive(3)
    record.receive(completion: .finished)
}

cancellable = recordPublisher
    .sink(
        receiveCompletion: { completion in
            print("Completion: \(completion)")
        },
        receiveValue: { value in
            print("Received value: \(value)")
        }
    )

//Received value: 0
//Received value: 1
//Received value: 2
//Received value: 3
//Completion: finished
```

1. Record<Int, Never>는 Int 타입의 값들을 방출하는 publisher
   <br/>

2. record.receive(1)은 1을 방출하고, receive(2)는 2를 방출하는 방식으로, 미리 정해진 값을 순서대로로 방출
   <br/>

3. 완료 이벤트를 명시적으로 설정(.finished)하여 publisher가 작업을 완료함

## 참고

- [공식문서 - Record](https://developer.apple.com/documentation/combine/record)
