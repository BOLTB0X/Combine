# assign

Publisher가 방출한 값을 특정 객체의 프로퍼티에 자동으로 할당해주는 메서드

## assign(to: on:)

> Assigns each element from a publisher to a property on an object.

```swift
func assign<Root>(
    to keyPath: ReferenceWritableKeyPath<Root, Self.Output>,
    on object: Root
) -> AnyCancellable
```

Publisher의 출력값을 특정 객체의 **key path**로 지정된 프로퍼티에 바인딩

- Parameters

  - **to keyPath** : Publisher가 방출하는 값을 할당할 객체의 프로퍼티에 대한 키 경로
    <br/>
  - **on object** : 값이 할당될 객체
    <br/>

- Return Value
  AnyCancellable 인스턴스
  <br/>

- 예시

  ```swift
  // MARK: - assign

   class MyClass {
      var anInt: Int = 0 {
          didSet {
            print("anInt was set to: \(anInt)", terminator: "; ") // 2
           }
       }
   }


   var myObject = MyClass()
   myRange = (0...3)
   cancellable = myRange.publisher
    .assign(to: \.anInt, on: myObject)// 1, 2
  // anInt was set to: 0; anInt was set to: 1; anInt was set to: 2; anInt was set to: 3;
  ```

  1.  0...3 범위가 publisher에 의해 0, 1, 2, 3 순서대로 방출
      <br/>

  2.  각 값은 assign(to: \.anInt, on: myObject)에 의해 myObject.anInt에 할당 됌
      <br/>

  3.  didSet이 호출되어 변경된 값을 출력
      <br/>

  4.  assign 현재 방출된 값을 프로퍼티에 즉시 반영하는 역할

## assign(to:)

> Republishes elements received from a publisher, by assigning them to a property marked as a publisher.

```swift
func assign(to published: inout Published<Self.Output>.Publisher)
```

@Published 프로퍼티와 같은 Publisher의 프로퍼티에 값을 자동으로 할당해줄 때 사용

- Parameters

  - to published: inout 키워드가 붙어 있기 때문에, 해당 Publisher는 참조로 전달. 즉, Publisher가 방출하는 값이 @Published 프로퍼티에 할당
    <br/>

- 예시 1

  ```swift
  class MyModel: ObservableObject {
      @Published var lastUpdated: Date = Date()

      init() {
          Timer.publish(every: 1.0, on: .main, in: .common)
              .autoconnect()
              .assign(to: &$lastUpdated)  // lastUpdated에 값을 지속적으로 할당
      }
  }

  // MyModel 인스턴스 생성

  let myModel = MyModel()

  // 구독 설정
  cancellable = myModel.$lastUpdated.sink { date in
      print("lastUpdated가 변경: \(date)")
  }

  DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
      cancellable.cancel()  // 구독을 취소하여 메모리 관리를 해줍니다.
      print("구독 취소")
  }

  //lastUpdated가 변경: 2024-09-26 11:46:45 +0000
  //lastUpdated가 변경: 2024-09-26 11:46:46 +0000
  //lastUpdated가 변경: 2024-09-26 11:46:47 +0000
  //lastUpdated가 변경: 2024-09-26 11:46:48 +0000
  //lastUpdated가 변경: 2024-09-26 11:46:49 +0000
  //lastUpdated가 변경: 2024-09-26 11:46:50 +0000
  //구독이 취소
  ```

- 예시 2

  ```swift
  class MyModel2: ObservableObject {
   @Published var id: Int = 0
  }

  let model2 = MyModel2()

  Just(100)
      .assign(to: &model2.$id) // id에 100 할당
  ```

## 참고

- [공식문서 - assign(to: on:)](<https://developer.apple.com/documentation/combine/publisher/assign(to:on:)>)
- [공식문서 - assign(to: )](<https://developer.apple.com/documentation/combine/publisher/assign(to:)>)
