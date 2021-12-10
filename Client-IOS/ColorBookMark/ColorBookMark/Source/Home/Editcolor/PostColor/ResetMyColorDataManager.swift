//
//  ResetMyColorDataManager.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/10.
//

import Foundation
import Alamofire

class ResetMyColorDataManager {
    func checkMyColor(delegate: EditColorViewController) {
        AF.request( "\(Constant.SERVER_BASE_URL)/app/diarys/myColor/reset", method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: ResetMyColorResponse.self) { response in
     
                switch response.result {
                case .success(let response):
                    
                    // 성공했을 때
                    if response.isSuccess {
                        print("초기화 성공")
                        delegate.didSuccessResetMyColor(response)
                    }
                    
                    // 실패했을 때
                    else {
                        switch response.code {
                        
                        case 2000..<3000: delegate.failedToDeleteMyColor(message: response.message ?? "")
                            print(response.message as Any)
                        case 3000..<4000: delegate.failedToDeleteMyColor(message: response.message ?? "")
                            print(response.message as Any)
                        case 4000: delegate.failedToDeleteMyColor(message: response.message ?? "")
                        default: delegate.failedToDeleteMyColor(message: response.message ?? "")
                            print(response.message as Any)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToDeleteMyColor(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
