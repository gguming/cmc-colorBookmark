//
//  CalenderLimitDataManager.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/10.
//

import Foundation
import Alamofire

class CalenderLimitDataManager {
    func getCalenderLimit(delegate: CalenderViewController) {
        AF.request( "\(Constant.SERVER_BASE_URL)/app/diarys/calender/limit", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: CalenderLimitResponse.self) { response in
                print("진짜")
                print(response)
                switch response.result {
                case .success(let response):
                    
                    // 성공했을 때
                    if response.isSuccess {
                        print("캘린더 범위 확인")
                        print(response.result)
                        delegate.min = (response.result[0].min)
                        delegate.max = (response.result[0].max)
                    }
                    
                    // 실패했을 때
                    if (!response.isSuccess) {
                        switch response.code {
                        case 2000: print("유저인덱스 번호 누락 > jwt 에러")
                        case 4000: print("실패")
                        default: print("데이터베이스 에러")
                        }
                    }

                case .failure(let error):
                    print(error.localizedDescription)
                    print("?>?")
                    print("서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
