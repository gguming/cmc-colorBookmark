//
//  CheckMyColorDataManger.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/06.
//

import Foundation
import Alamofire

class CheckMyColorDataManger {
    func checkMyColor(delegate: EditColorViewController) {
        AF.request( "\(Constant.SERVER_BASE_URL)/app/diarys/myColor", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: CheckMyColorResponse.self) { response in
     
                switch response.result {
                case .success(let response):
                    
                    // 성공했을 때
                    if response.isSuccess {
                      print("조회성공")
                        
                       
                    }
                    
                    // 실패했을 때
                    if (!response.isSuccess) {
                        switch response.code {
                        case 2000: print("유저인덱스 번호 누락 > jwt 에러")
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
