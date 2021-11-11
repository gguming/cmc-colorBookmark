//
//  SigninDataManager.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/09.
//

import Foundation
import Alamofire

class SignInDataManager {
    func postSignin(_ parameters: SigninRequest, LoginMainDelegate: LoginMainViewController, SigninPasswordDelegate: SigninPasswordViewController, SigininNickNameDelegate: SigninNickNameViewController) {
        AF.request("\(Constant.SERVER_BASE_URL)/app/users", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: SigninResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                       // delegate.didSuccessSignin()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
//                        case 2025: delegate.failedToRequest(message: "닉네임 입력 누락")
//                        case 2014: delegate.failedToRequest(message: "이메일 입력 누락")
//                        case 2011: delegate.failedToRequest(message: "비밀번호를 입력 해주세요.")
//                        case 2010: delegate.failedToRequest(message: "이메일 형식과 맞지 않음")
                        case 3001: LoginMainDelegate.emailAlreadyExist()
                        default: print("데이터베이스 에러")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
//                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

