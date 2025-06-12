# ObservableObject

> A type of object with a publisher that emits before the object has changed.

```swift
protocol ObservableObject : AnyObject
```

`ObservableObject`를 채택한 클래스는 **객체가 변할 때 이를 알리는 역할**

- `ObservableObject` 를 채택한 인스턴스는 이벤트를 방출할 수 있는 인스턴스

- 이 인스턴스를 *Subscriber* 가 **구독** 하여 사용하는 것

- 기본적으로 `ObservableObject` 는 `@Published` 프로퍼티가 변경되기 전에 변경된 값을 내보내는 [objectWillChange](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic01/objectWillChange.md) *publisher* 를 **synthesizes**

## 활용 방식

1. **Class 정의**

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
    ```

2. **사용**

    ```swift
    let kyungheon = Contact(name: "kyungheon Appleseed", age: 29)
    cancellable = kyungheon.objectWillChange
        .sink { _ in
            print("\(kyungheon.age) will change")
    }

    print(kyungheon.haveBirthday())
    ```

    ```
    // 29 will change
    // 30
    ```

## 참고

- [공식문서 - ObservableObject](https://developer.apple.com/documentation/combine/observableobject)

- [블로그 참고](https://ios-development.tistory.com/1115)
