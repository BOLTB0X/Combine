# Future

> A publisher that eventually produces a single value and then finishes or fails.

```swift
final class Future<Output, Failure> where Failure : Error
```

- Result 타입과 같이 성공 or 실패 두 가지 타입을 갖는 Publisher

  1.  **단일 이벤트 발행**
      Future는 한 번에 하나의 값 또는 에러를 발행하고 완료가 됨
      <br/>
  2.  **Result를 미리 결정 X**
      Future는 비동기 작업의 결과를 나중에 결정 가능
      <br/>

  3.  **완료 후 더 이상 발행하지 않음**
      Future는 성공하거나 실패한 후 추가로 값을 발행 X
      <br/>

## 일반적인 사용법

1. **promise**
   promise 타입은 단순히 Result 타입을 가지고 있는 closure

   ```swift
   Future<Int, Never> { promise in
     promise(.success(5)) // promise 타입은 (Result<Int, Never>) -> Void

   }
   .sink { print($0) }

   // 5
   ```

<br/>

2. Future을 사용 X, 사용 O 경우
   **cf. Result<Success, Failure>는 Swift에서 비동기 작업이나 함수가 성공했는지 실패했는지를 표현하는 타입**

   ```swift
   struct ImageProcessorService {
       func run(_ image: UIImage,
        completion: (Result<UIImage, Error>) -> Void
       ) -> Void {
           print("some function")
       }
   }
   ```

   Future를 사용하면 위에서 설명한 completion 클로저를 대체 가능

   ```swift
   extension ImageProcessorService {
       func run(_ image: UIImage) ->
        Future<UIImage, Error> {
           Future { promise in
               self.run(image, completion: promise)
           }
        }
   }
   ```

<br/>

## Future로 비동기

- Future를 사용하면 단일 값을 비동기적으로 publisher로 발행 가능

```swift
func generateAsyncRandomNumberFromFuture() -> Future <Int, Never> {
    return Future() { promise in
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let number = Int.random(in: 1...10)
            promise(Result.success(number))
        }
    }
}
```

Future는 비동기 작업이 완료되면, success 또는 fail로 promise을 실행하며

```swift
var cancellable = generateAsyncRandomNumberFromFuture()
   .sink { number in print("Got random number \(number).") }
```

구독자(subscriber)는 해당 결과를 받음

## 참고

- [공식문서 - future](https://developer.apple.com/documentation/combine/future)

- [블로그 참조](https://ios-development.tistory.com/1118)
