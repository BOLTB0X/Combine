## 주요 메소드

Publisher 관련 주요 메소드
<br/>

### Just

Just는 오직 하나의 값만을 출력하고 끝나게되는 가장 단순한 형태의 Publisher
<br/>
Combine Framework에서 빌트인(Built-in)형태로 제공하는 Publisher
<br/>

```swift
Just(5).sink {
    print($0) // 5
}
```

<br/>

Just는 인자로 받는 값의 타입을 Output 타입으로 실패타입은 항상 Never 로 리턴
<br/>

Publsiher 중 ConnectablePublsiher 프로토콜을 준수하는 Publisher는 autoconnext를 이용하여 subsriber 연결여부와 상관없이 미리 데이터를 발행시킬 수 있음
<br/>

ex)

```swift
let provider = (1...10).publisher
print("구분") // 발행을 안해서 구분만 출력
```

sink(Subscriber)가 연결되기 전까지는 데이터를 발행 X
<br/>

[img](https://miro.medium.com/v2/resize:fit:720/format:webp/1*fKLhm3YUQK9BSPOanDbTrg.png)

### sink

> Attaches a subscriber with closure-based behavior to a publisher that never fails.
> <br/>

```swift
func sink(receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable
```

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

<br/>

클로저 기반 동작이 있는 subscriber를 실패하지 않도록 publisher에 연결
<br/>

- sink 사용법
  Publisher가 받은 값을 관찰하고(observe) 콘솔에 출력
  <br/>
  sink는 위 정의에 따라 스트림이 실패하지 않은 경우
  <br/>
  즉 Publisher의 실패 type이 없는 경우에만 사용 가능
  <br/>
  cf. 스트림(stream)이란 실제의 입력이나 출력이 표현된 데이터의 이상화된 흐름
  <br/>

```swift
// sink 사용법
provider.sink(receiveCompletion: { _ in
    print("데이터 전달 완료")
}, receiveValue: { data in
    print(data)
})
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
//데이터 전달 완료

// 요렇게도 가능 -> publisher와 sink를 한 번에
let integers = (0...9)
    .publisher
    .sink {
        print("Received \($0)")
    }
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

이 인스턴스 메서드는 구독자를 생성하고 구독자를 반환하기 전에 unlimited의 값을 즉시 요청한다고 함
<br/>

이런 반환 값을 유지해야지 스트림이 유지
<br/>

## 참고

https://medium.com/harrythegreat/swift-combine-입문하기-가이드-1-525ccb94af57
<br/>
https://developer.apple.com/documentation/combine/just/sink(receivevalue:)
<br/>
