//
//  ContentView.swift
//  CombineBasic02
//
//  Created by KyungHeon Lee on 2023/05/01.
//

import SwiftUI
import Combine

// 뷰모델 버전
class ViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var value = 0
    
    func clickPlus() {
        Just(1)
            .sink {[weak self] value in
                guard let v = self else { return}
                v.value += value
            }
            .store(in: &cancellables)
    }
    
    func clickMinus() {
        Just(1)
            .sink {[weak self] value in
                guard let v = self else { return}
                if v.value > 0 {
                    v.value -= 1
                }
            }
            .store(in: &cancellables)
    }
    
    func reset() {
        value = 0
        cancellables.removeAll()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("카운트: \(viewModel.value)")
            HStack {
                Button("증가") {
                    viewModel.clickPlus()
                }
                Spacer()
                
                Button("감소") {
                    viewModel.clickMinus()
                }
                
                Spacer()
                
                Button("초기화") {
                    viewModel.reset()
                }
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
