//
//  Model.swift
//  CombineJSON
//
//  Created by KyungHeon Lee on 2023/03/31.
//

import Foundation

// MARK: MODEL
// get post 1의 Json 데이터와 동일한 모델 생성
// postModel을 디코딩하고 인코딩을 원하기 때문에 codable 추가
struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
