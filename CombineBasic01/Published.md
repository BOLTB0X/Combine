# Published

> A type that publishes a property marked with an attribute

```swift
@propertyWrapper
struct Published<Value>
```

- @Published 프로퍼티에 새로운 값이 설정되면 자동으로 Combine의 퍼블리셔가 값을 내보냄.
  <br/>

- 이 퍼블리셔는 Publisher 프로토콜을 따르며, 값을 관찰할 수 있는 스트림을 제공
  <br/>

- 이는 프로퍼티의 값이 변경될 때마다 퍼블리셔가 새 값을 방출하는 방식으로, 마치 didSet처럼 동작
  <br/>

```swift
// 다음과 같이 $ 연산자를 사용하여 퍼블리셔에 액세스

class Weather {
    @Published var temperature: Double

    init(temperature: Double) {
        self.temperature = temperature
    }
}


let weather = Weather(temperature: 20)
var cancellable: AnyCancellable? = weather.$temperature
    .sink() {
        print ("Temperature now: \($0)")
}
weather.temperature = 25
// Temperature now: 20.0
// Temperature now: 25.0
```

```swift
// 프로퍼티가 변경되면 프로퍼티의 willSet 블록에서 publishing이 발생
// 즉, subscribers는 프로퍼티에 실제로 설정되기 전에 새 값을 받음
// 위의 예에서 싱크가 두 번째로 폐쇄를 실행할 때 매개변수 값 25를 받음
// 그러나 폐쇄가 Weather.온도를 평가한 경우 반환되는 값은 20
```

> The @Published attribute is class constrained.
> Use it with properties of classes, not with non-class types like structures.

@Published가 Combine 프레임워크와 결합되어 subscriber에게 값을 퍼블리시하는데, 이 과정에서 **참조 타입(reference type)**인 클래스가 필요하기 때문

클래스는 상태 변화가 있을 때 그 변화를 관찰하고 외부에서 이를 추적할 수 있는 기능을 제공하기에 적합

그러므로 @Published를 사용할 때는 반드시 해당 프로퍼티가 클래스 안에 있어야 하고, 구조체나 열거형에서는 사용 X

## 참고

- [공식문서 - Published](https://developer.apple.com/documentation/combine/published)
