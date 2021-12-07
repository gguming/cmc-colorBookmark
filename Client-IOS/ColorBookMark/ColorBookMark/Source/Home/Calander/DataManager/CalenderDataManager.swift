//
//  CalenderDataManager.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/15.
//

import Foundation
import Alamofire

let headers: HTTPHeaders = ["X-ACCESS-TOKEN": Constant.jwt!]

var calenderDate = [String]()
var calenderColor = [String]()

class CalenderDataManager {
    
    func getCalenderMonth(_ parameters: Parameters, delegate: CalenderViewController) {
        AF.request( "\(Constant.SERVER_BASE_URL)/app/diarys/calender/month", method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: headers)
            .validate()
            .responseDecodable(of: CalendarResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    
                    // 성공했을 때
                    if response.isSuccess {
                        print("캘린더 연결 성공")
                        print(response.result)
                        delegate.getCalenderSuccess(data: response.result)
                    }
                    
                    // 실패했을 때
                    if (!response.isSuccess) {
                        switch response.code {
                        case 3006: print("탈퇴한 계정")
                        case 3033: print("달력 범위 초과")
                        case 2000: print("유저인덱스 번호 누락 > jwt 에러")
                        case 4000: print("실패")
    
                        default: print("데이터베이스 에러")
                        }
                    }

                case .failure(let error):
                    print(error.localizedDescription)
                    print("서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
