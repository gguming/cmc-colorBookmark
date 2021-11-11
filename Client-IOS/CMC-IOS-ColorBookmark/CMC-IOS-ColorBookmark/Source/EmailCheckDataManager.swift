//
//  EmailCheckDataManager.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/11.
//

import Foundation
import Alamofire

class EmailCheckDataManager {
    func EmailCheck(_ parameters: Parameters, delegate: LoginMainViewController) {
        AF.request( "\(Constant.SERVER_BASE_URL)/app/users/email", method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: nil)
            .validate()
            .responseDecodable(of: EmailCheckResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        switch response.message {
                        case "성공":
                            print("이메일 사용가능")
                            delegate.availbleEmail()
                        case "실패":
                            print("이메일 중복")
                            delegate.emailAlreadyExist()
                        default: break
                        }
                    }
                    
                    // 실패했을 때
                    if (!response.isSuccess) {
                        switch response.code {
                        case 2003: print("이메일 형식이 올바르지 않습니다")
                        case 2001: print("이메일을 입력해주세요")
                        default: break
                        }
                    }

                case .failure(let error):
                    print(error.localizedDescription)
                    print("서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
