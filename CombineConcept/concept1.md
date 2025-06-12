## Combine 구조

> Publisher, Operator, Subscriber로 구성

<p align="center">
   <img src="https://miro.medium.com/v2/resize:fit:1400/format:webp/1*jLmJpJX952LXGsqpOKYQfQ.png" alt="Example Image" width="70%">
   <br/>
   이미지출처:해리의유목코딩
</p>

1. **Subscriber**로부터 data를 요청받으면

2. **Publisher**에서 data를 제공

3. 중간에 **Operator**를 거쳐

4. **Subscriber**에게 전달

## Publisher - Subscriber

<p align="center">
   <img src="https://miro.medium.com/v2/resize:fit:1400/format:webp/1*uMKTUK7cK-gtNjdxEknWaQ.png" alt="Example Image" width="70%">
   <br/>
   이미지출처:해리의유목코딩
</p>

> Publisher와 Subscriber가 서로 데이터를 주고받을 때는 항상 두 가지의 타입이 존재

- **Publisher**

  > Output 타입과 Failure 타입이 존재

  시간의 경과에 따라 value를 subscriber에게 방출 하는 타입

- **Operators**

  Publisher 프로토콜에 선언된 메서드로, 동일하거나 새로운 publisher를 반환하는 타입

- **subscriber**

  > Publisher의 output타입과 동일한 Input타입과 동일한 Failure타입을 가져야 함

  일반적으로 방출된 *output value* 나, *completion 이벤트* -> 
  
  결과를 사용하여 필요한 작업을 수행

## App의 구조와 Combine

<p align="center">
   <img src="https://jryoun1.github.io/assets/images/Combine/Chapter1/5.png" alt="Example Image" width="70%">
   <br/>
   이미지출처:해리의유목코딩
</p>

- App에 새롭게 추가되는 부분에만 Combine을 사용할 수 있음

- App의 구조에 따라서 영향을 끼치는 framework X

## 참고

- [공식문서 - Combine](https://developer.apple.com/documentation/combine)

- [블로그 참조 - Combine 입문하기 가이드](https://medium.com/harrythegreat/swift-combine-입문하기-가이드-1-525ccb94af57)

- [kodeco 참조](https://www.kodeco.com/books/combine-asynchronous-programming-with-swift/v2.0/chapters/1-hello-combine)
