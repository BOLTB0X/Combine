## Just

> A publisher that emits an output to each subscriber just once, and then finishes.

```swift
struct Just<Output>
```

Just는 오직 하나의 값만을 출력하고 끝나게되는 가장 단순한 형태의 Publisher

Combine Framework에서 빌트인(Built-in)형태로 제공하는 Publisher

- 활용

  ```swift
  Just(5).sink {
      print($0) // 5
  }
  ```

  - Just는 인자로 받는 값의 타입을 Output 타입으로 실패타입은 항상 Never 로 리턴

  - Publsiher 중 ConnectablePublsiher 프로토콜을 준수하는 Publisher는 autoconnext를 이용하여 subsriber 연결여부와 상관없이 미리 데이터를 발행시킬 수 있음

- ex)

  ```swift
  let provider = (1...10).publisher
  print("구분") // 발행을 안해서 구분만 출력
  ```

sink(Subscriber)가 연결되기 전까지는 데이터를 발행 X

![img](https://miro.medium.com/v2/resize:fit:720/format:webp/1*fKLhm3YUQK9BSPOanDbTrg.png)

## 참고

- [Combine 공식문서](https://developer.apple.com/documentation/combine)

- [블로그 참조](https://medium.com/harrythegreat/swift-combine-입문하기-가이드-1-525ccb94af57)
