# Subject

Combine에서 모델과 데이터를 위한 publisher 만드는 방법은 [@Publisehd](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic01/Published.md)와 [PassthroughSubject](https://github.com/BOLTB0X/Combine/blob/main/CombineForModel/PassthroughSubject.md), [CurrentValueSubject](https://github.com/BOLTB0X/Combine/blob/main/CombineForModel/CurrentValueSubject.md)
<br/>

> A publisher that exposes a method for outside callers to publish elements.

```swift
protocol Subject<Output, Failure> : AnyObject, Publisher
```

- Publisher 프로토콜을 준수하고 있는 형태

- 개발자가 스트림에 값을 주입할 수 있는 특별한 Publisher

- 인스턴스는 이벤트를 방출할 수 있는 **send(\:)** 기능이 존재

- **send(completion:)** 메서드를 사용해 스트림을 끝내기 가능

- Subject 사용 사례

  1. UI 업데이트

     - 뷰모델과 같이 data를 여러 Subscriber에게 동시에 발행하고 갱신할 필요가 있을 때 유용
     - ex) 사용자의 입력을 즉시 반영할 때
       <br/>

  2. 수동 이벤트 처리

     - 외부에서 data를 직접 발행하거나, 특정 이벤트를 트리거 가능
       <br/>

  3. 멀티캐스팅
     - 여러 Subscriber에게 동일한 data 스트림을 제공하는 상황에서 사용
       <br/>

## 참고

- [공식문서 - subject](https://developer.apple.com/documentation/combine/subject)

- [블로그 참조 - ios 김종권(subject)](https://ios-development.tistory.com/1120)

- [블로그 참조 - 개발자 소들이](https://babbab2.tistory.com/)

- [블로그 참조 - thecosmos(combine)](https://thecosmos.tistory.com/30)
