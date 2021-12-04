//
//  BackgroundColorDataManager.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/04.
//

import Alamofire

class BackgroundColorDataManager{
    func getBackgroundColors(delegate: BaseViewController) {
        let header: HTTPHeaders = ["x-access-token" : "\(Constant.jwt!)"]

        AF.request("\(Constant.SERVER_BASE_URL)/app/diarys/user/mostColor", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: GetBackgroundColorResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessGetBackgroundColors(response)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000..<3000: delegate.failedToBackgroundColors(message: response.message )
                            print(response.message as Any)
                        case 3000..<4000: delegate.failedToBackgroundColors(message: response.message )
                            print(response.message as Any)
                        case 4000: delegate.failedToBackgroundColors(message: response.message )
                        default: delegate.failedToBackgroundColors(message: response.message )
                            print(response.message as Any)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToBackgroundColors(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
