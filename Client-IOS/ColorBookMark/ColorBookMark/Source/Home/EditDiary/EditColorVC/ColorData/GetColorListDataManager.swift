//
//  ColorListDataManager.swift
//  ColorBookmark
//
//  Created by SUN on 2021/11/23.
//

import Alamofire

class GetColorListDataManager{
    func getColors(delegate: HomeViewController) {
        let header: HTTPHeaders = ["x-access-token" : "\(Constant.jwt ?? "")"]

        AF.request("\(Constant.SERVER_BASE_URL)/app/diarys/basicColor", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
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
    
    func getColorsinEditColor(delegate: EditColorViewController) {
        let header: HTTPHeaders = ["x-access-token" : "\(Constant.jwt!)"]

        AF.request("\(Constant.SERVER_BASE_URL)/app/diarys/basicColor", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
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
