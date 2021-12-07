//
//  GetMyColorDataManager.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/08.
//

import Foundation
import Alamofire

class GetMyColorDataManager{
    func getMyColor(delegate: HomeViewController) {
        let header: HTTPHeaders = ["x-access-token" : "\(Constant.jwt!)"]

        AF.request("\(Constant.SERVER_BASE_URL)/app/diarys/myColor", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: ColorResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessGetColors(response)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000..<3000: delegate.failedToGetColors(message: response.message )
                            print(response.message as Any)
                        case 3000..<4000: delegate.failedToGetColors(message: response.message )
                            print(response.message as Any)
                        case 4000: delegate.failedToGetColors(message: response.message )
                        default: delegate.failedToGetColors(message: response.message )
                            print(response.message as Any)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetColors(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func getMyColorinEditColor(delegate: EditColorViewController) {
        let header: HTTPHeaders = ["x-access-token" : "\(Constant.jwt!)"]

        AF.request("\(Constant.SERVER_BASE_URL)/app/diarys/myColor", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: ColorResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessGetColors(response)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000..<3000: delegate.failedToGetColors(message: response.message )
                            print(response.message as Any)
                        case 3000..<4000: delegate.failedToGetColors(message: response.message )
                            print(response.message as Any)
                        case 4000: delegate.failedToGetColors(message: response.message )
                        default: delegate.failedToGetColors(message: response.message )
                            print(response.message as Any)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetColors(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
