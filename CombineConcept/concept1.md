## Combine의 구조

<img src="https://miro.medium.com/v2/resize:fit:1400/format:webp/1*jLmJpJX952LXGsqpOKYQfQ.png" width="400" height="200"/>

- Publisher, Operator, Subscriber로 구성
- Subscriber로부터 데이터를 요청받으면 Publisher에서 데이터를 제공하고 중간에 Operator를 거쳐 Subscriber에게 전달

<img src="https://miro.medium.com/v2/resize:fit:1400/format:webp/1*uMKTUK7cK-gtNjdxEknWaQ.png" width="400" height="200"/>
<br/>

Publisher와 Subscriber가 서로 데이터를 주고받을 때는 항상 두 가지의 타입이 존재
<br/>
Publisher 입장에서는 Output 타입과 Failure 타입이 존재
<br/>
에러가 발생했을 경우 Failure 타입 그렇지 않다면 Output 타입을 전달. 이 데이터를 받는 Subscriber는 Publisher의 output타입과 동일한 Input타입과, 그리고 동일한 Failure타입을 가져야 함
<br/>

> Publisher: 시간의 경과에 따라 value를 subscriber에게 방출 하는 타입
> <br/>
> Operators: Publisher 프로토콜에 선언된 메서드로, 동일하거나 새로운 publisher를 반환하는 타입
> <br/>
> subscriber: . 일반적으로 방출된 output value나, completion 이벤트 -> 결과를 사용하여 필요한 작업을 수행
> <br/>

## App의 구조와 Combine

<img src="https://jryoun1.github.io/assets/images/Combine/Chapter1/5.png" width="400" height="200"/>
<br/>

App에 새롭게 추가되는 부분에만 Combine을 사용할 수 있음, 즉 App의 구조에 따라서 영향을 끼치는 framework X
<br/>

## 참고

https://developer.apple.com/documentation/combine
<br/>
https://medium.com/harrythegreat/swift-combine-입문하기-가이드-1-525ccb94af57
<br/>
https://www.kodeco.com/books/combine-asynchronous-programming-with-swift/v2.0/chapters/1-hello-combine
<br/>
