//
//  MiniCodeDataManager.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/23.
//

import Foundation
import Alamofire

class MiniCodeDataManager {
    func createMiniCode(_ parameters: MiniCodeRequest, delegate: MiniCodeCheckViewController) {
        AF.request( "\(Constant.SERVER_BASE_URL)/app/users/miniCode", method: .patch, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers)
            .validate()
            .responseDecodable(of: MiniCodeResponse.self) { response in
     
                switch response.result {
                case .success(let response):
                    
                    // 성공했을 때
                    if response.isSuccess {
                      print("미니코드 생성 성공")
                        delegate.createMiniCodeSuccess()
                    }
                    
                    // 실패했을 때
                    if (!response.isSuccess) {
                        switch response.code {
                        case 3006: print("탈퇴한 계정")
                        case 3015: print("미니코드 설정값 off 상태입니다.")
                        case 2000: print("유저 아이디값 없음 ( jwt )")
                        case 3025: print("미니코드를 값 누락")
                        case 3024: print("미니코드 값 4자리 입력 요청")
                        case 4000: print("미니코드 수정 실패")
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
