import UIKit
import Combine
import Foundation

// MARK: - Future
Future<Int, Never> { promise in
    promise(.success(5)) // promise 타입은 (Result<Int, Never>) -> Void
    
}
.sink { print($0) }



// 5

struct ImageProcessorService {
    func run(
        _ image: UIImage,
        completion: (Result<UIImage, Error>) -> Void
    ) -> Void {
        print("some function")
    }
}

extension ImageProcessorService {
    func run(_ image: UIImage) -> Future<UIImage, Error> {
        Future { promise in
            self.run(image, completion: promise)
        }
    }
}

func generateAsyncRandomNumberFromFuture() -> Future <Int, Never> {
    return Future() { promise in
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let number = Int.random(in: 1...10)
            promise(Result.success(number))
        }
    }
}

var cancellable = generateAsyncRandomNumberFromFuture()
    .sink { number in print("Got random number \(number).") }

// Got random number 1.


// MARK: - fail
enum MyError: Error {
    case somethingError
}

let failPublisher = Fail<String, MyError>(error: .somethingError)

cancellable = failPublisher
    .sink(
        receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                print("Error received: \(error)")
            case .finished:
                print("Finished")
            }
        },
        receiveValue: { value in
            print("Received value: \(value)")
        }
    )
// Error received: somethingError

// MARK: - Deferred
func createPublisher() -> AnyPublisher<Int, Never> {
    print("Publisher 생성")
    return Just(30)
        .eraseToAnyPublisher()
}

let deferredPublisher = Deferred {
    createPublisher()
}

cancellable = deferredPublisher
    .sink(
        receiveCompletion: { completion in
            print("Completed: \(completion)")
        },
        receiveValue: { value in
            print("Received value: \(value)")
        }
    )

// Publisher 생성
// Received value: 30
// Completed: finished

// MARK: - Empty
let emptyPublisher = Empty<Int, Never>()

cancellable = emptyPublisher
    .sink(
        receiveCompletion: { completion in
            print("Completion: \(completion)")
        },
        receiveValue: { value in
            print("Received value: \(value)")
        }
    )

// MARK: - Record
let recordPublisher = Record<Int, Never> { record in
    record.receive(0)
    record.receive(1)
    record.receive(2)
    record.receive(3)
    record.receive(completion: .finished)
}

cancellable = recordPublisher
    .sink(
        receiveCompletion: { completion in
            print("Completion: \(completion)")
        },
        receiveValue: { value in
            print("Received value: \(value)")
        }
    )

//Received value: 0
//Received value: 1
//Received value: 2
//Received value: 3
//Completion: finished

// MARK: - sink
var myRange = (0...3)
cancellable = myRange.publisher
    .sink(receiveCompletion: {
        print ("completion: \($0)")
    },
          receiveValue: {
        print ("value: \($0)")
    })

//  value: 0
//  value: 1
//  value: 2
//  value: 3
//  completion: finished

let successPublisher = ["A", "B", "C", "D"].publisher

cancellable = successPublisher.sink(
    receiveCompletion: { completion in
        switch completion {
        case .finished:
            print("completed 성공")
        case .failure(let error):
            print("fail error: \(error)")
        }
    },
    receiveValue: { value in
        print("Received value: \(value)")
    }
)

//Received value: A
//Received value: B
//Received value: C
//completed 성공.

enum Errorr: Error {
    case Common
    case Very
    case Unbelievable
}

let failingPublisher = Fail<String, Errorr>(error: .Unbelievable)

cancellable = failingPublisher.sink(
    receiveCompletion: { completion in
        switch completion {
        case .finished:
            print("completed 성공")
        case .failure(let error):
            print("fail error: \(error)")
        }
    },
    receiveValue: { value in
        print("Received value: \(value)")
    }
)

// fail error: Unbelievable

// MARK: - assign
class MyClass {
    var anInt: Int = 0 {
        didSet {
            print("anInt was set to: \(anInt)", terminator: "; ")
        }
    }
}


var myObject = MyClass()
myRange = (0...3)
cancellable = myRange.publisher
    .assign(to: \.anInt, on: myObject)
// anInt was set to: 0; anInt was set to: 1; anInt was set to: 2; anInt was set to: 3; 
