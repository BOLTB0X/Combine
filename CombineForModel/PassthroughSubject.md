# PassthroughSubject

> A subject that broadcasts elements to downstream subscribers.

```swift
final class PassthroughSubject<Output, Failure> where Failure : Error
```

> 값을 출발지(origin)에서 Publisher를 거쳐 Subscriber에게 도달하게 하는 것

- data를 저장하지 않고 발행된 data를 즉시 전달

- Subscriber가 생기기 전이나 발행된 data는 저장되지 않고, 이미 발행된 data는 새로운 Subscriber가 받기 X

1. PassthroughSubject X

   ```swift
   final class IntegerSubscriber: Subscriber {
     typealias Input = Int
     typealias Failure = Never

     func receive(subscription: Subscription) {
         print("구독!")
         subscription.request(.unlimited)
     }

     func receive(_ input: Int) -> Subscribers.Demand {
         print("Received value: \(input)")
         return .none
     }

     func receive(completion: Subscribers.Completion<Never>) {
         print("Completed")
     }
   }

   var intSubscriber = IntegerSubscriber()

   let publisher = [1, 2, 3, 4, 5].publisher

   publisher
        .subscribe(intSubscriber)

   //구독!
   //Received value: 1
   //Received value: 2
   //Received value: 3
   //Received value: 4
   //Received value: 5
   //Completed
   ```

   <br/>

   - [1, 2, 3, 4, 5]가 자동으로 발행하고 값을 처리

   - 여기서 수동으로 값을 발행하지 않고, 배열 자체가 publisher 역할을 함
     <br/>

2. PassthroughSubject O

   ```swift
   let passSubject = PassthroughSubject<Int, Never>()

   let subscribersA = passSubject
       .sink { value in
           print("subscribersA received: \(value)")
       }

   passSubject.send(1)
   passSubject.send(2)

   let subscribersB = passSubject
       .sink { value in
           print("subscribersB received: \(value)")
       }

   passSubject.send(3)
   passSubject.send(4)

   passSubject
       .send(completion: .finished)

   //subscribersA received: 1
   //subscribersA received: 2
   //subscribersA received: 3
   //subscribersB received: 3
   //subscribersA received: 4
   //subscribersB received: 4
   ```

   <br/>

   - PassthroughSubject를 사용하면 외부에서 값을 직접 발행
   - **send()** 메서드를 통해 data를 수동으로 전송
   - subscribersA은 모든 값을 받지만, subscribersB는 구독 이후에 발행된 값만 받음
     <br/>

> PassthroughSubject의 가장 큰 특징은 값을 가지지 않는다는 것

## 참고

- [공식문서 - PassthroughSubject](https://developer.apple.com/documentation/combine/passthroughsubject)

- [블로그 참조 - ios 김종권(subject)](https://ios-development.tistory.com/1120)

- [블로그 참조 - 개발자 소들이](https://babbab2.tistory.com/)

- [블로그 참조 - thecosmos(combine)](https://thecosmos.tistory.com/30)
