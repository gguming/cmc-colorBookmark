//
//  PostColorDataManager.swift
//  ColorBookmark
//
//  Created by SUN on 2021/11/26.
//

import Alamofire

class PostColorDataManager {
    func postColor(_ parameters: PostColorRequest, delegate: ColorPickerMainViewController) {
        let header: HTTPHeaders = ["x-access-token" : "\(Constant.jwt!)"]
        
        AF.request("\(Constant.SERVER_BASE_URL)/app/diarys/home/color", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: PostColorResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessPostColors(response)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000..<3000: delegate.failedToPostColors(message: response.message ?? "")
                            print(response.message as Any)
                        case 3000..<4000: delegate.failedToPostColors(message: response.message ?? "")
                            print(response.message as Any)
                        case 4000: delegate.failedToPostColors(message: response.message ?? "")
                        default: delegate.failedToPostColors(message: response.message ?? "")
                            print(response.message as Any)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToPostColors(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
