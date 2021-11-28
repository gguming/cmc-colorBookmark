//
//  SettingDataManager.swift
//  ColorBookmark
//
//  Created by 김지훈 on 2021/11/23.
//

import Foundation
import Alamofire

class SettingDataManager {
    func getSettingValue(_ parameters: SettingRequest, delegate: SettingTableViewCell) {
        AF.request( "\(Constant.SERVER_BASE_URL)/app/users/status", method: .patch, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers)
            .validate()
            .responseDecodable(of: SettingResonse.self) { response in
     
                switch response.result {
                case .success(let response):
                    
                    // 성공했을 때
                    if response.isSuccess {
                      print("회원상태 수정 성공")
                       
                    }
                    
                    // 실패했을 때
                    if (!response.isSuccess) {
                        switch response.code {
                        case 2000: print("유저 아이디값 없음 ( jwt )")
                        case 3006: print("탈퇴한 계정")
                        case 4000: print("수정 실패")
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
