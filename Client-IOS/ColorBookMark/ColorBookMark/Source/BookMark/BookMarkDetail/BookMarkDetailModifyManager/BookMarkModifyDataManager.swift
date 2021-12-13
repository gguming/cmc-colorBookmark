//
//  BookMarkModifyDataManager.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/14.
//

import Alamofire

class BookMarkModifyDataManager {
    func diaryModify(_ parameters: ModifyRequest, delegate: BookmarkDetailViewController) {
        let header: HTTPHeaders = ["x-access-token" : "\(Constant.jwt!)"]
        AF.request("\(Constant.SERVER_BASE_URL)/app/diarys/final-editing", method: .patch, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: ModifyResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessModifyDetail(response)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000..<3000: delegate.failedToModifyDetail(message: response.message)
                            print(response.message as Any)
                        case 3000..<4000: delegate.failedToModifyDetail(message: response.message)
                            print(response.message as Any)
                        case 4000: delegate.failedToModifyDetail(message: response.message)
                        default: delegate.failedToModifyDetail(message: response.message)
                            print(response.message as Any)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToModifyDetail(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
