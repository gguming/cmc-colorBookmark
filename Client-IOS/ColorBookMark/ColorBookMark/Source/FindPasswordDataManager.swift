//
//  FindPasswordDataManager.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/25.
//

import Foundation
import Alamofire

class FindPasswordDataManager {
    func postPassword(_ parameters: FindPasswordRequest, delegate: FindPasswordViewController) {
        AF.request( "\(Constant.SERVER_BASE_URL)/users/find-password", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: FindPasswordResponse.self) { response in
     
                switch response.result {
                case .success(let response):
                    
                    // 성공했을 때
                    if response.isSuccess {
                        print("회원가입 후 로그인 성공")
                        delegate.SendPasswordSuccess()
                    }
                    
                    // 실패했을 때
                    if (!response.isSuccess) {
                        switch response.code {
                        case 2001: print("이메일값 입력 누락")
                        case 2015: print("존재하지 않는 이메일")
            
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
