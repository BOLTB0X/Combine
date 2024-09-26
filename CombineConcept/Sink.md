# sink

**sink는 퍼블리셔 내에서 Subscriber를 생성하는 메서드**

- subscriber 역할을 하는 클로저 기반의 간단한 메서드
  sink는 퍼블리셔가 방출한 값을 받아 처리하고, 그 값이 완료되거나 에러가 발생하면 이에 대응하는 로직을 수행할 수 있도록 해주는 용도
  <br/>

- publisher의 연산자 중 하나로 볼 수 있고 subscriber를 생성하는 연산자
  Subscriber 프로토콜을 따르지 않지만, 클로저를 이용해 값을 처리하고 구독을 완료
  <br/>

- publisher가 subscriber를 생성하는 구독 메서드로 사용되며, subscriber가 없을 때 퍼블리셔로부터 값을 받을 수가 X

## sink(receiveValue:)

> Attaches a subscriber with closure-based behavior to a publisher that never fails.

```swift
func sink(receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable
```

클로저 기반 동작이 있는 subscriber를 실패하지 않도록 publisher에 연결하여 사용

- Parameters

  - receiveValue: 퍼블리셔가 값을 방출할 때마다 호출
    <br/>

- Return Value
  AnyCancellable 인스턴스
  <br/>

```swift
let integers = (0...3)

integers.publisher
    .sink { print("Received \($0)") }

//  Received 0
//  Received 1
//  Received 2
//  Received 3
```

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

## sink(receiveCompletion:receiveValue:)

> Attaches a subscriber with closure-based behavior.

```swift
func sink(
    receiveCompletion: @escaping ((Subscribers.Completion<Self.Failure>) -> Void),
    receiveValue: @escaping ((Self.Output) -> Void)
) -> AnyCancellable
```

- Parameters

  - receiveCompletion:

    - publisher의 완료 이벤트나 에러 이벤트가 발생했을 때 호출
      <br/>
    - 퍼블리셔는 두 가지 방식으로 종료 가능
      1. 성공적으로 완료: 모든 data를 방출한 후 정상적으로 스트림이 끝난 경우.
      2. 에러로 인해 종료: 스트림 중간에 에러가 발생하여 더 이상 data를 방출할 수 없게 된 경우.
         <br/>
    - 이 클로저는 Subscribers.Completion 타입의 값을 전달받으며, 이는 성공(.finished) 또는 실패(.failure(Error))를 나타냄
      <br/>

  - receiveValue:
    - 퍼블리셔가 값을 방출할 때마다 호출
    - 각 값을 받아서 원하는 처리 가능
      <br/>

- Return Value
  AnyCancellable 인스턴스
  <br/>

- 예시
  ```swift
  let myRange = (0...3)
  cancellable = myRange.publisher
      .sink(receiveCompletion: {
          print ("completion: \($0)")
      },
      receiveValue: {
          print ("value: \($0)")
      })
  ```

<br/>

- 성공 예시

  ```swift
  let successPublisher = ["A", "B", "C", "D"].publisher

  cancellable = successPublisher.sink(
      receiveCompletion: { completion in
          switch completion {
          case .finished:
              print("completed 성공.")
          case .failure(let error):
              print("fail error: \(error)")
          }
      },
      receiveValue: { value in
          print("Received value: \(value)")
      }
   )

  //Received value: A
  //Received value: B
  //Received value: C
  //completed 성공.
  ```

- 에러 예시

  ```swift
  let failingPublisher = Fail<String, Errorr>(error: .Unbelievable)

  cancellable = failingPublisher.sink(
      receiveCompletion: { completion in
          switch completion {
          case .finished:
              print("completed 성공")
          case .failure(let error):
              print("fail error: \(error)")
          }
      },
      receiveValue: { value in
          print("Received value: \(value)")
      }
  )

  // fail error: Unbelievable
  ```

## 참고

- [공식문서 - sink(receiveValue:)](https://developer.apple.com/documentation/combine)

- [공식문서 - sink(receiveCompletion:receiveValue:)
  ](<https://developer.apple.com/documentation/combine/publisher/sink(receivecompletion:receivevalue:)>)

- [블로그 참조](https://medium.com/harrythegreat/swift-combine-입문하기-가이드-1-525ccb94af57)
