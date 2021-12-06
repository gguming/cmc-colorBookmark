//
//  PostMyColorDataManager.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/06.
//

import Foundation
import Alamofire

class PostMyColorDataManager {
    func postMyColor(_ parameters: PostMyColorRequest, delegate: SettingTableViewCell) {
        AF.request( "\(Constant.SERVER_BASE_URL)/app/diarys/myColor/status", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers)
            .validate()
            .responseDecodable(of: PostMyColorResponse.self) { response in
     
                switch response.result {
                case .success(let response):
                    
                    // 성공했을 때
                    if response.isSuccess {
                        switch response.code {
                        case 1016: print("마이컬러 삭제 성공")
                        case 1012: print("마이컬러 등록/수정 성공")
                        default: break
                        }
                       
                    }
                    
                    // 실패했을 때
                    if (!response.isSuccess) {
                        switch response.code {
                        case 2000: print("유저인덱스 번호 누락 > jwt 에러")
                        case 3006: print("탈퇴한 계정")
                        case 3037: print("myColorId 값 입력 누락")
                        case 2024: print("color 값 입력 누락")
                        case 2021: print("color 입력 형식 오류")
                        case 2028: print("colorName 길이 100자 초과")
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
