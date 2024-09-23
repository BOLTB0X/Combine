# Deferred

> A publisher that awaits subscription before running the supplied closure to create a publisher for the new subscriber.

```swift
struct Deferred<DeferredPublisher> where DeferredPublisher : Publisher
```

- 퍼블리셔의 생성 시점을 지연시키는 역할
  <br/>

- 구독이 시작될 때까지 퍼블리셔의 생성이나 task를 미루고, 구독이 발생하는 시점에 퍼블리셔를 생성하여 task를 실행
  <br/>

- 주로 시간이 많이 드는 task이나 동적으로 퍼블리셔를 생성해야 하는 경우에 사용

```swift
func createPublisher() -> AnyPublisher<Int, Never> {
    print("Publisher 생성")
    return Just(30)
        .eraseToAnyPublisher()
}

let deferredPublisher = Deferred {
    createPublisher()
}

cancellable = deferredPublisher
    .sink(
        receiveCompletion: { completion in
            print("Completed: \(completion)")
        },
        receiveValue: { value in
            print("Received value: \(value)")
        }
    )

// Publisher 생성
// Received value: 30
// Completed: finished
```

createPublisher() 함수는 deferredPublisher가 구독될 때만 호출이 됌

즉, 구독 전에는 퍼블리셔가 생성 X

Deferred는 퍼블리셔 생성 시점을 조정할 수 있어, 시간이 많이 드는 task를 효율적으로 사용 가능

## 참고

- [공식문서 - Deferred](https://developer.apple.com/documentation/combine/Deferred)
