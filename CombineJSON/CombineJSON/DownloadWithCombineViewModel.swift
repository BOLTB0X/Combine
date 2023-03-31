//
//  DownloadWithCombineViewModel.swift
//  CombineJSON
//
//  Created by KyungHeon Lee on 2023/03/31.
//

import SwiftUI
import Combine

// MARK: Combine을 통한 ViewModel
class DownloadWithCombineViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // dataTaskPublisher: 주어진 URL에 대한 URL 세션 데이터 작업을 래핑하는 publisher를 반환
        // 1. Publisher 생성(dataTaskPublisher): 어떠한 패키지에 대한 매월 정기구독을 가입함
        URLSession.shared.dataTaskPublisher(for: url)
            // 2. subscribe publisher을 background Thread로 옮겨줌: 고객이 주문하면 회사는 패키지를 공장에서 생산함
            .subscribe(on: DispatchQueue.global(qos: .background))
            // 3. Main Thread에서 수신함: 회사는 패키지를 배송하고 고객은 상품을 전달받음
            .receive(on: DispatchQueue.main)
            // 4. tryMap(data의 존재유무, 손상 상태 확인): 사용자는 패키지 상자의 상태가 손상되었는지 확인함
            .tryMap(handleOutput)//{ data, response -> Data in
//                // 응답 상태에 관한 guard
//                guard
//                    let response = response as? HTTPURLResponse,
//                    response.statusCode >= 200 && response.statusCode < 300 else {
//                        // 응답과정에서 에러가 있으면 throw를 이용
//                        // 기본 Foundation에서 제공하는 URLError를 이용
//                        // URLError는 모든 에러 유형이 정의되어있음
//                        throw URLError(.badServerResponse)
//                }
//                return data
//            }
            // 5. decode (데이터를 PostModel로 디코딩): " 상자를 열고 항목이 올바른지 확인함 "
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            // 6. sink(항목을 앱에 추가): 동기화
            .sink { completion in
                print("completion: \(completion)")
                // self는 지금 강한참조
                // 참조는 자신의 기억을 유지
            } receiveValue: { [weak self] returnedPost in
                self?.posts = returnedPost
            }
            // 7. store (필요한 경우 구독을 취소함)
            .store(in: &cancellables)
    }
    
    // 9. 만약 호출에 성공하지 못했다는 가정하에 몇 가지 로직을 넣음
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                // 응답과정에서 에러가 있으면 throw를 이용
                // 기본 Foundation에서 제공하는 URLError를 이용
                // URLError는 모든 에러 유형이 정의되어있음
                throw URLError(.badServerResponse)
        }
        return output.data
    }
}
