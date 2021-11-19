//
//  SigninDataManager.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/09.
//

import Foundation
import Alamofire

class SigninDataManager {
    func postSignin(_ parameters: SigninRequest, delegate: SigninNickNameViewController) {
        AF.request( "\(Constant.SERVER_BASE_URL)/app/users", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: SigninResponse.self) { response in
                switch response.result {
                case .success(let response):
                    
                    // 성공했을 때
                    if response.isSuccess {
                        print("회원가입 성공")
                        delegate.SigninSuccess()
                    }
                    
                    // 실패했을 때
                    if (!response.isSuccess) {
                        switch response.code {
                        case 2005: print("비밀번호는 6~20자리를 입력해주세요.")
                        case 2019: print("비밀번호 형식을 정확하게 입력해주세요.")
                        case 2006: print("닉네임 입력 누락")
                        case 2001: print("이메일 입력 누락")
                        case 2004: print("비밀번호 입력 누락")
                        case 2003: print("이메일 형식과 맞지 않음")
                        case 1008: print("탈퇴 유저 복귀 성공")
                        case 3001: print("이미 존재하는 회원")
                        case 4000: print("회원가입 실패")
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
