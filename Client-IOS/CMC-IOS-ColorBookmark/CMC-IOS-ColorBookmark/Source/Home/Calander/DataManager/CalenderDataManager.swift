//
//  CalenderDataManager.swift
//  CMC-IOS-ColorBookmark
//
//  Created by 김지훈 on 2021/11/15.
//

import Foundation
import Alamofire

let headers: HTTPHeaders = ["X-ACCESS-TOKEN": JwtInfo.shared.jwtValue!]

var calenderDate = [String]()
var calenderColor = [String]()

class CalenderDataManager {
    func getCalenderMonth(_ parameters: Parameters, delegate: CalenderViewController) {
        AF.request( "\(Constant.SERVER_BASE_URL)/app/diarys/month", method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: headers)
            .validate()
            .responseDecodable(of: CalendarResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    
                    // 성공했을 때
                    if response.isSuccess {
                        print("캘린더 연결 성공")
                        print(response.result[0].date)
                        
                        calenderDate.removeAll()
                        CalendarInfo.shared.calenderDate.removeAll()
                        for index in 0..<response.result.count {
                            CalendarInfo.shared.calenderDate.append(response.result[index].date)
                        }
                        
                        calenderColor.removeAll()
                        CalendarInfo.shared.calenderColor.removeAll()
                        for index in 0..<response.result.count {
                            if response.result[index].color != nil {
                                CalendarInfo.shared.calenderColor.append(response.result[index].color!)
                            }
                            else {
                                CalendarInfo.shared.calenderColor.append("nil")
                            }
                           
                        }
                        print(CalendarInfo.shared.calenderColor)
                       
                    }
                    
                    // 실패했을 때
                    if (!response.isSuccess) {
                        switch response.code {
                        case 3006: print("탈퇴한 계정")
                        case 3033: print("달력 범위 초과")
                        case 2000: print("유저인덱스 번호 누락 > jwt 에러")
                        case 4000: print("실패")
    
                        default: print("???")
                        }
                    }

                case .failure(let error):
                    print(error.localizedDescription)
                    print("서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
