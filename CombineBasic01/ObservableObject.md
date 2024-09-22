# ObservableObject

> A type of object with a publisher that emits before the object has changed.

```swift
protocol ObservableObject : AnyObject
```

ObservableObject를 채택한 클래스는 객체가 변할 때 이를 알리는 역할
<br/>

- ObservableObject를 채택한 인스턴스는 이벤트를 방출할 수 있는 인스턴스
  <br/>

- 이 인스턴스를 Subscriber가 구독하여 사용하는 것
  <br/>

> 기본적으로 ObservableObject는 @Published 프로퍼티가 변경되기 전에 변경된 값을 내보내는 objectWillChange publisher를 synthesizes

<br/>

```swift
class Contact: ObservableObject {
    @Published var name: String
    @Published var age: Int


    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    func haveBirthday() -> Int {
        age += 1
        return age
    }
}


let kyungheon = Contact(name: "kyungheon Appleseed", age: 29)
cancellable = kyungheon.objectWillChange
    .sink { _ in
        print("\(kyungheon.age) will change")
}

print(kyungheon.haveBirthday())
// 29 will change
// 30
```

## 참고

- [공식문서 - ObservableObject](https://developer.apple.com/documentation/combine/observableobject)

- [블로그 참고](https://ios-development.tistory.com/1115)
