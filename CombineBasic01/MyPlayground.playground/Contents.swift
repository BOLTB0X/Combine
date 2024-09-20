import UIKit
import Combine

class Weather {
    @Published var temperature: Double
    init(temperature: Double) {
        self.temperature = temperature
    }
}


let weather = Weather(temperature: 20)
var cancellable: AnyCancellable? = weather.$temperature
    .sink() {
        print ("Temperature now: \($0)")
}
weather.temperature = 25

// 프로퍼티가 변경되면 프로퍼티의 willSet 블록에서 publishing이 발생
// 즉, subscribers는 프로퍼티에 실제로 설정되기 전에 새 값을 받음
// 위의 예에서 싱크가 두 번째로 폐쇄를 실행할 때 매개변수 값 25를 받음
// 그러나 폐쇄가 Weather.온도를 평가한 경우 반환되는 값은 20
