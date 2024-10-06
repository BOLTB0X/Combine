# CurrentValueSubject

> A subject that wraps a single value and publishes a new element whenever the value changes.

```swift
final class CurrentValueSubject<Output, Failure> where Failure : Error
```

> PassthroughSubject와 유사한 subject

- 가장 최근에 발행된 값을 저장하고, subscriber가 생기면 즉시 최신 값을 전달

- 값을 초기화할 때 반드시 기본값을 설정해야 하며, subscriber들이 언제든지 현재 값을 확인 가능

1. CurrentValueSubject X

   ```swift
   var currentValue: Int = 0 // 최근 값을 저장하는 변수

   currentValue = 0 // 초기 값 발행
   let publisher2 = Just(currentValue)

   publisher2
      .subscribe(intSubscriber) // 퍼블리셔와 구독자 연결

   // 새로운 값 설정 후 발행
   currentValue = 2
   let publisher3 = Just(currentValue)
   publisher3
      .subscribe(intSubscriber)

   //구독!
   //Received value: 0
   //Completed
   //구독!
   //Received value: 2
   //Completed
   ```

   <br/>

   - 최근 값을 currentValue로 저장하고, 값을 변경할 때마다 새로운 퍼블리셔를 생성해 발행해야 함
   - 이는 값을 변경할 때마다 퍼블리셔를 새로 만들어야 하기 때문에 번거로운 단점
     <br/>

2. CurrentValueSubject O

   ```swift
   // CurrentValueSubject 정의 (초기값 0)
   let curSubject = CurrentValueSubject<Int, Never>(0)

   // 구독자 C
   let subscriberC = curSubject
       .sink { value in
           print("subscriber C received: \(value)")
       }

   // 값 변경
   curSubject.send(1)
   curSubject.send(2)

   // 구독자 D 추가
   let subscriberD = curSubject
       .sink { value in
           print("subscriber D received: \(value)")
       }

   // 값 변경
   curSubject.send(3)
   curSubject.send(4)

   // 완료 이벤트 발행
   curSubject
       .send(completion: .finished)

   //subscriber C received: 0
   //subscriber C received: 1
   //subscriber C received: 2
   //subscriber D received: 2
   //subscriber D received: 3
   //subscriber C received: 3
   //subscriber D received: 4
   //subscriber C received: 4
   ```

   <br/>

   - urrentValueSubject는 현재 값을 저장하므로, subscriberD가 구독을 시작했을 때 바로 최신 값인 2를 수신
   - 이후에 발행된 값도 모두 구독자들에게 전달이 됌
     <br/>

> subscriber에 값을 전달한 후 그 값을 버리지 않고 갖고 있음

## 참고

- [공식문서 - currentvaluesubject](https://developer.apple.com/documentation/combine/currentvaluesubject)

- [블로그 참조 - ios 김종권(subject)](https://ios-development.tistory.com/1120)

- [블로그 참조 - 개발자 소들이](https://babbab2.tistory.com/)

- [블로그 참조 - thecosmos(combine)](https://thecosmos.tistory.com/30)
