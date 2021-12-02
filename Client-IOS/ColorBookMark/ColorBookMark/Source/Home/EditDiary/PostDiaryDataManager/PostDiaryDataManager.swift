//
//  PostDiaryDataManager.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/02.
//

import Foundation
import Alamofire


class PostDiaryDataManager {
    func diaryPost(_ parameters: PostDiaryRequest, delegate: EditDiaryViewController) {
        let header: HTTPHeaders = ["x-access-token" : "\(Constant.jwt!)"]
        AF.request("\(Constant.SERVER_BASE_URL)/app/posts", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: PostDiaryResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessPostDiary(response)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000..<3000: delegate.failedToPostDiary(message: response.message)
                            print(response.message as Any)
                        case 3000..<4000: delegate.failedToPostDiary(message: response.message)
                            print(response.message as Any)
                        case 4000: delegate.failedToPostDiary(message: response.message)
                        default: delegate.failedToPostDiary(message: response.message)
                            print(response.message as Any)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToPostDiary(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
