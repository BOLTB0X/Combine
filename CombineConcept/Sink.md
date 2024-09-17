## sink

> Attaches a subscriber with closure-based behavior to a publisher that never fails.

```swift
func sink(receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable
```

```swift
let integers = (0...3)

integers.publisher
    .sink { print("Received \($0)") }

//  Received 0
//  Received 1
//  Received 2
//  Received 3
```

클로저 기반 동작이 있는 subscriber를 실패하지 않도록 publisher에 연결하여 사용

- sink 사용법

  1. Publisher가 받은 값을 관찰하고(observe) 콘솔에 출력
  2. sink는 위 정의에 따라 스트림이 실패하지 않은 경우
  3. 즉 Publisher의 실패 type이 없는 경우에만 사용 가능
  4. cf. 스트림(stream)이란 실제의 입력이나 출력이 표현된 데이터의 이상화된 흐름

  ```swift
  // sink 사용법
  provider.sink(receiveCompletion: { _ in
   print("data 전달 완료")
  }, receiveValue: { data in
   print(data)
  })
  ```

  ```
  // 1
  // 2
  // 3
  // 4
  // 5
  // 6
  // 7
  // 8
  // 9
  // 10
  // data 전달 완료
  ```

- publisher와 sink를 한 번에 표현

  ```swift
  let integers = (0...9)
      .publisher
      .sink {
          print("Received \($0)")
       }
  ```

  ```
   // 0
   // 1
   // 2
   // 3
   // 4
   // 5
   // 6
   // 7
   // 8
   // 9
  ```

  - 이 인스턴스 메서드는 구독자를 생성하고 구독자를 반환하기 전에 unlimited의 값을 즉시 요청한다고 함

  - 이런 반환 값을 유지해야지 스트림이 유지되는 것

## 참고

- [Combine 공식문서](https://developer.apple.com/documentation/combine)

- [블로그 참조](https://medium.com/harrythegreat/swift-combine-입문하기-가이드-1-525ccb94af57)
