# Fail

> A publisher that immediately terminates with the specified error.

```swift
struct Fail<Output, Failure> where Failure : Error
```

- fail을 바로 스트림으로 보내는 Publisher
  <br/>

- 첫번째 아규먼트는 에러를 방출할때 같이 방출할 값
  <br/>

- 아무런 data를 발행하지 않고, 방출한 뒤 바로 완료
  <br/>

```swift
enum MyError: Error {
    case somethingError
}

let failPublisher = Fail<String, MyError>(error: .somethingError)

cancellable = failPublisher
    .sink(
        receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                print("Error received: \(error)")
            case .finished:
                print("Finished")
            }
        },
        receiveValue: { value in
            print("Received value: \(value)")
        }
    )
// Error received: somethingError
```

## 참고

- [공식문서 - fail](https://developer.apple.com/documentation/combine/fail)

- [블로그 참조](https://ios-development.tistory.com/1118)
