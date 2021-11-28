//
//  DeleteAccountDataManager.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/11/29.
//

import Foundation
import Alamofire

class DeleteAccountDataManager {
    func deleteAccount(delegate: DeleteAccountViewController) {
        AF.request( "\(Constant.SERVER_BASE_URL)/app/users/\(Constant.userId!)/status", method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: DeleteAccountResponse.self) { response in
     
                switch response.result {
                case .success(let response):
                    
                    // 성공했을 때
                    if response.isSuccess {
                        print("회원 탈퇴 성공")
                        delegate.deleteAccountSuccess()
                    }
                    
                    // 실패했을 때
                    if (!response.isSuccess) {
                        switch response.code {
                        case 2016: print("jwt값과 userId 값 불일치")
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

