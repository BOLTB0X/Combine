import UIKit
import Combine

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
