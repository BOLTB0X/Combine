# Combine

![호호](https://postfiles.pstatic.net/MjAyMjA2MTlfMTQw/MDAxNjU1NjI5ODk5NzYx.QYr_9AM2GGnj6xYt2u3Odta2RYP7c9kyJgb7WNlGhjwg.DMZdS08YtWGXyhzGEL0nLOSRJriidgm32J8fWSa_GQMg.GIF.gogoa25/IMG_3649.GIF?type=w3840)

> Combine은 Reactive Programming에 기반을 둔 프레임워크로, 비동기 데이터 흐름을 다룸

시간 경과에 따라 값을 처리하기 위한 선언적 Swift API를 제공, 다양한 종류의 비동기 이벤트를 나타 냄

> Stream하나를 만들고 그 Stream에 필요한 operator를 덫붙여서 사용하는 선언적인 프로그래밍 방식

- Publisher: 값 방출

- Subscriber: 값을 받는 대상

- AnyCancellable: 구독을 유지하는 객체

## Intro

- [Combine 구조](https://github.com/BOLTB0X/Combine/blob/main/CombineConcept/concept1.md)

## Basic

- [Publisher](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic01/Publisher.md) & [AnyPublisher](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic01/AnyPublisher.md)

  - [Future](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic02/Future.md)

  - [Just](https://github.com/BOLTB0X/Combine/blob/main/CombineConcept/Just.md)

  - [Deferred](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic02/Deferred.md)

  - [Empty](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic02/Empty.md)

  - [Fail](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic02/Fail.md)

  - [Record](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic02/Record.md)
    <br/>

- [Subscriber](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic01/Subscriber.md) & [AnySubscriber](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic01/AnySubscriber.md)

  - [Receive](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic01/receive.md)
    <br/>

- [Cancellable & AnyCancellable](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic01/Cancellable.md)

- [Sink](https://github.com/BOLTB0X/Combine/blob/main/CombineConcept/Sink.md)

- [Assign](https://github.com/BOLTB0X/Combine/blob/main/CombineConcept/assign.md)

## For Model

- [Subject](https://github.com/BOLTB0X/Combine/blob/main/CombineForModel/Subject.md)

  - [PassthroughSubject](https://github.com/BOLTB0X/Combine/blob/main/CombineForModel/PassthroughSubject.md)
  - [CurrentValueSubject](https://github.com/BOLTB0X/Combine/blob/main/CombineForModel/CurrentValueSubject.md)
    <br/>

- [Published](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic01/Published.md)

- [ObservableObject
  ](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic01/ObservableObject.md)
  - [objectWillChange
    ](https://github.com/BOLTB0X/Combine/blob/main/CombineBasic01/objectWillChange.md)

## Utilize

- [JSON 활용](https://github.com/BOLTB0X/Combine/tree/main/CombineJSON)

## 참고

- [공식문서](https://developer.apple.com/documentation/combine)

- [블로그 참조 - harrythegreat](https://medium.com/harrythegreat/swift-combine-입문하기-가이드-1-525ccb94af57)

- [블로그 참조 - ios 김종권](https://ios-development.tistory.com/1112)

- [블로그 참조 - 개발자 소들이](https://babbab2.tistory.com/)

- [kodeco 참조](https://www.kodeco.com/books/combine-asynchronous-programming-with-swift/v2.0/chapters/1-hello-combine)
