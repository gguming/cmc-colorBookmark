//
//  BookMarkDetailDataManager.swift
//  ColorBookMark
//
//  Created by SUN on 2021/12/07.
//

import Alamofire

class BookMarkDetailDataManager{
    func getBookMarkDetail(diaryId: Int, delegate: BookmarkDetailViewController) {
        let header: HTTPHeaders = ["x-access-token" : "\(Constant.jwt!)"]


        AF.request("\(Constant.SERVER_BASE_URL)/app/diarys/\(diaryId)/date", method: .get, parameters: nil, encoding: JSONEncoding(), headers: header)
            .validate()
            .responseDecodable(of: GetBookMarkDetailResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessGetBookMarkDetail(response)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000..<3000: delegate.failedToGetBookMarkDetail(message: response.message)
                            print(response.message as Any)
                        case 3000..<4000: delegate.failedToGetBookMarkDetail(message: response.message)
                            print(response.message as Any)
                        case 4000: delegate.failedToGetBookMarkDetail(message: response.message)
                        default: delegate.failedToGetBookMarkDetail(message: response.message)
                            print(response.message as Any)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetBookMarkDetail(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
