//
//  KakaoLoginDataManager.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/20.
//

import Foundation
import Alamofire

class KakaoLoginDataManager {
    func getKakaoLoginJwt(_ parameters: KakaoLoginRequest, delegate: LoginPageViewController) {
        AF.request( "\(Constant.SERVER_BASE_URL)/users/kakao-login", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: KakaoLoginResponse.self) { response in
     
                switch response.result {
                case .success(let response):

                    // 성공했을 때
                    if response.isSuccess {
                        print("카카오 로그인 성공")
                        print("kako jwt 토큰값")
                        JwtInfo.shared.jwtValue = response.result?.jwt
                        print(JwtInfo.shared.jwtValue!)
                    }
                    
                    // 실패했을 때
                    if (!response.isSuccess) {
                        switch response.code {
                        case 2001: print("이메일 값 누락")
                        case 2004: print("비밀번호 값 누락")
                        case 2002: print("비밀번호는 6~20자리를 입력해주세요.")
                        case 2003: print("이메일 형식 에러")
                        case 2019: print("비밀번호 형식 에러")
                        case 3003: print("회원가입된 이메일이 아님")
                        case 3004: print("비밀번호가 다릅니다.")
                        case 3006: print("탈퇴한 계정입니다.")
                        case 3023: print("이미 로그인된 상태입니다.")
                        case 4000: print("로그인 실패")
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
