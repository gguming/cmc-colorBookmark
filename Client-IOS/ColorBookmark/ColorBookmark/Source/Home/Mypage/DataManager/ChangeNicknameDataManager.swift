//
//  ChangeNicknameDataManager.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/26.
//

import Foundation
import Alamofire

class ChangeNicknameDataManager {
    func changeNickname(_ parameters: ChangeNicknameRequest, delegate: ChangeNicknameViewController) {
        AF.request( "\(Constant.SERVER_BASE_URL)/app/users/nickname", method: .patch, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers)
            .validate()
            .responseDecodable(of: ChangeNicknameResponse.self) { response in
     
                switch response.result {
                case .success(let response):
                    
                    // 성공했을 때
                    if response.isSuccess {
                        print("닉네임 변경 성공")
                   
                        delegate.changeNicknameSuccess()
                     
                    }
                    
                    // 실패했을 때
                    if (!response.isSuccess) {
                        switch response.code {
                        case 3006: print("탈퇴한 계정입니다.")
                        case 2017: print("닉네임을 입력해 주세요")
                        case 3025: print("미니코드를 입력해 주세요")
                        case 2000: print("유저 아이디값 없음 ( jwt )")
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

