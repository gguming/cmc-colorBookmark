//
//  BookMarkDataManager.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/06.
//

import Alamofire

class BookMarkDataManager {
    func getBookMark(date: String, delegate: BookmarkViewController) {
        let header: HTTPHeaders = ["x-access-token" : "\(Constant.jwt!)"]


        AF.request("\(Constant.SERVER_BASE_URL)/app/diarys/targeted-month?date=\(date)", method: .get, parameters: nil, encoding: JSONEncoding(), headers: header)
            .validate()
            .responseDecodable(of: GetBookMarkResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessGetBookMakrs(response)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000..<3000: delegate.failedToGetBookMakrs(message: response.message ?? "" )
                            print(response.message as Any)
                        case 3000..<4000: delegate.failedToGetBookMakrs(message: response.message ?? "" )
                            print(response.message as Any)
                        case 4000: delegate.failedToGetBookMakrs(message: response.message ?? "" )
                        default: delegate.failedToGetBookMakrs(message: response.message ?? "" )
                            print(response.message as Any)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetBookMakrs(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}