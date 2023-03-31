//
//  DownloadWithCombineView.swift
//  CombineJSON
//
//  Created by KyungHeon Lee on 2023/03/31.
//

import SwiftUI

struct DownloadWithCombineView: View {
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading, spacing: 10) {
                    Text(post.title)
                        .font(Font.title.bold())
                    Text(post.body)
                        .foregroundColor(Color(UIColor.systemGray))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .navigationBarTitle("Fake JSON Data")
        .listStyle(PlainListStyle())
    }
}

struct DownloadWithCombineView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombineView()
    }
}
