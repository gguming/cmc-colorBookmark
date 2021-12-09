//
//  PostMyColorDataManager.swift
//  ColorBookMark
//
//  Created by 김지훈 on 2021/12/06.
//

import Foundation
import Alamofire

class PostMyColorDataManager {
    func postMyColor(_ parameters: PostMyColorRequest, delegate: ColorPickerMainViewController) {
        AF.request( "\(Constant.SERVER_BASE_URL)/app/diarys/myColor/status", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers)
            .validate()
            .responseDecodable(of: PostMyColorResponse.self) { response in
     
                switch response.result {
                case .success(let response):
                    print("하하하하ㅏ핳하ㅏㅎ하하하하")
                    // 성공했을 때
                    if response.isSuccess {
                        switch response.code {
                        case 1016:
                            print("마이컬러 삭제 성공")
                            delegate.didSuccessPostColors(response)
                        case 1012:
                            print("마이컬러 등록/수정 성공")
                            delegate.didSuccessPostColors(response)
                        default: break
                        }
                    }
                    
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000..<3000: delegate.failedToPostColors(message: response.message ?? "")
                            print(response.message as Any)
                        case 3000..<4000: delegate.failedToPostColors(message: response.message ?? "")
                            print(response.message as Any)
                        case 4000: delegate.failedToPostColors(message: response.message ?? "")
                        default: delegate.failedToPostColors(message: response.message ?? "")
                            print(response.message as Any)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToPostColors(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func editMyColorName(_ parameters: PostMyColorRequest, delegate: EditColorViewController) {
        AF.request( "\(Constant.SERVER_BASE_URL)/app/diarys/myColor/status", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers)
            .validate()
            .responseDecodable(of: PostMyColorResponse.self) { response in
     
                switch response.result {
                case .success(let response):
                    print("카카카카카카카ㅏㅋ")
                    // 성공했을 때
                    if response.isSuccess {
                        switch response.code {
                        case 1016:
                            print("마이컬러 삭제 성공 @@@@@")
                            delegate.didSuccessEditColorName(response)
                        case 1012:
                            print("마이컬러 등록/수정 성공 @@@@@")
                            delegate.didSuccessEditColorName(response)
                        default: break
                        }
                    }
                    
                    // 실패했을 때
                    else {
                        switch response.code {
                        
                        case 2000..<3000: delegate.failedToEditColorName(message: response.message ?? "")
                            print(response.message as Any)
                        case 3000..<4000: delegate.failedToEditColorName(message: response.message ?? "")
                            print(response.message as Any)
                        case 4000: delegate.failedToEditColorName(message: response.message ?? "")
                        default: delegate.failedToEditColorName(message: response.message ?? "")
                            print(response.message as Any)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToEditColorName(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func editMyColor(_ parameters: PostMyColorRequest, delegate: OriginalColorPickerMainViewController) {
        AF.request( "\(Constant.SERVER_BASE_URL)/app/diarys/myColor/status", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers)
            .validate()
            .responseDecodable(of: PostMyColorResponse.self) { response in
     
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        switch response.code {
                        case 1016:
                            print("마이컬러 삭제 성공 @@@@@")
                            delegate.didSuccessEditColors(response)
                        case 1012:
                            print("마이컬러 등록/수정 성공 @@@@@")
                            delegate.didSuccessEditColors(response)
                        default: break
                        }
                    }
                    
                    // 실패했을 때
                    else {
                        switch response.code {
                        
                        case 2000..<3000: delegate.failedToEditColors(message: response.message ?? "")
                            print(response.message as Any)
                        case 3000..<4000: delegate.failedToEditColors(message: response.message ?? "")
                            print(response.message as Any)
                        case 4000: delegate.failedToEditColors(message: response.message ?? "")
                        default: delegate.failedToEditColors(message: response.message ?? "")
                            print(response.message as Any)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToEditColors(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
