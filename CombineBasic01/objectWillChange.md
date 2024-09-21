# objectWillChange

> A publisher that emits before the object has changed.

```swift
var objectWillChange: Self.ObjectWillChangePublisher { get }
```

- 인스턴스의 내부 @Published 값이 변경될때 objectWillChange 이벤트가 동작

- 값 형태는 ObservableObjectPublisher.Output 형태이지만 결과는 Void

```swift
class Contact2: ObservableObject {
    var age: Int {
        willSet {
            self.objectWillChange.send()

        }
    }

    init(age: Int) {
        self.age = age
    }
}

var data = Contact2(age: 20)
data.objectWillChange
    .send()

data.objectWillChange
    .sink { print("change age? = \($0)") }

data.age = 29
data.age = 30

// change age? = ()
// change age? = ()
```

## 참고

- [공식문서 - objectWillChange](https://developer.apple.com/documentation/combine/observableobject/objectwillchange-2oa5v)

- [블로그 참고](https://ios-development.tistory.com/1115)
