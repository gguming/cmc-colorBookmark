//
//  ColorListDataManager.swift
//  ColorBookmark
//
//  Created by SUN on 2021/11/23.
//

import Algorithms

class GetColorListDataManager{
//    func getFeeds(cnt: Int, delegate: HomeViewController) {
//        let header: HTTPHeaders = ["x-access-token" : "\(Constant.Accessjwt!)"]
//
//        AF.request("\(Constant.BASE_URL)/app/accounts/\(Constant.AccessAccountIdx!)/posts/\(cnt)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
//            .validate()
//            .responseDecodable(of: GetFeedsResponse.self) { response in
//                switch response.result {
//                case .success(let response):
//                    // 성공했을 때
//                    if response.isSuccess {
//                        delegate.didSuccessGetFeeds(response)
//                    }
//                    // 실패했을 때
//                    else {
//                        switch response.code {
//                        case 2000..<3000: delegate.failedToGetFeeds(message: response.message ?? "")
//                            print(response.message as Any)
//                        case 3000..<4000: delegate.failedToGetFeeds(message: response.message ?? "")
//                            print(response.message as Any)
//                        case 4000: delegate.failedToGetFeeds(message: response.message ?? "")
//                        default: delegate.failedToGetFeeds(message: response.message ?? "")
//                            print(response.message as Any)
//                        }
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    delegate.failedToGetFeeds(message: "서버와의 연결이 원활하지 않습니다")
//                }
//            }
//    }
}
