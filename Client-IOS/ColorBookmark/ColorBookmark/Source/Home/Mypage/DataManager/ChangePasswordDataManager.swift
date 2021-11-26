//
//  ChangePasswordDataManager.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/25.
//

import Foundation
import Alamofire

class ChangePasswordDataManager {
    func changePassword(_ parameters: ChangePasswordRequest, delegate: ChangePasswordViewController) {
        AF.request( "\(Constant.SERVER_BASE_URL)/app/users/password", method: .patch, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers)
            .validate()
            .responseDecodable(of: ChangePasswordResponse.self) { response in
     
                switch response.result {
                case .success(let response):
                    
                    // 성공했을 때
                    if response.isSuccess {
                        print("비밀번호 변경 성공")
                        delegate.changePasswordSuccess()
                    }
                    
                    // 실패했을 때
                    if (!response.isSuccess) {
                        switch response.code {
                        case 3006: print("탈퇴한 계정입니다.")
                        case 2004: print("비밀번호 값 누락")
                        case 2033: print("2차 비밀번호 값 누락")
                        case 2000: print("유저 아이디값 없음 ( jwt )")
                        case 2034: print("비밀번호 불일치")
                        case 4000: print("실패")
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
