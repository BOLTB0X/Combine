# Publisher

> Declares that a type can transmit a sequence of values over time.

```swift
protocol Publisher<Output, Failure>
```

- Generic type parameters

  1.  **Output**: Publisher가 방출하는 값의 타입
  2.  **Failure**: Publisher가 방출할 수 있는 에러의 종류
      <br/>

- Combine 프레임워크의 핵심 프로토콜로, data를 발행하는 객체
  <br/>

- 이벤트 스트림을 생성하고, Subscriber가 구독하면 이 스트림을 통해 data를 전달
  <br/>

- Publisher는 단순히 data를 방출하는 역할
  <br/>

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

## 참고

- [공식문서 - publisher](https://developer.apple.com/documentation/combine/publisher)

- [블로그 참고 - 1](https://ios-development.tistory.com/1117)

- [블로그 참고 - 2](https://sujinnaljin.medium.com/combine-subscriber-409023bc6d89)
