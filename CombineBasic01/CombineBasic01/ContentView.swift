//
//  ContentView.swift
//  CombineBasic01
//
//  Created by KyungHeon Lee on 2023/04/30.
//

import SwiftUI
import Combine

// ObservableObject으로 이 클래스 감시
class Model: ObservableObject {
    @Published var count = 0 // Publisher
}

struct ContentView: View {
    @ObservedObject var model = Model() // Subscriber

    var body: some View {
        VStack {
            Text("count: \(model.count)")
            Button("클릭") {
                self.model.count += 1 // 증가
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
