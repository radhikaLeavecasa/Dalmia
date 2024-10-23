//
//  Api.swift
//  Josh
//
//  Created by Esfera-Macmini on 12/04/22.
//

import Foundation

let baseUrl = "https://ooh.warburttons.com/api/"
let imageBaseUrl = "https://ooh.warburttons.com/"

extension Api {
    func baseURl() -> String {
        return (baseUrl + self.rawValued()).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}

enum Api: Equatable {
    
    case fetchApi(_ code: String, userID: String)
    case uploadSiteDetails
    case logout
    case login
    case verifyOtp
    case adminProjectListing
    case vendorProjectList(_ name: String)
    case asmProjectList(_ name: String)
    case clientProjectListing
    //case zoProjectList(_ name: String)
    case outsourceProjectList(_ name: String)
    case vendorList
    case updateProject(_ id: Int)
    case userApi
    case notification(_ name: String)
    
    case getStateByCityVendor(_ city: String, vendor: String)
    case getCityByStateVendor(_ state: String, vendor: String)
    case getVendorByStateCity(_ state: String, city: String)
//    case asmSitePending(_ name: String)
//    
//    case supervisorListing(_ code: Int)
//    case supervisorApproved(_ code: Int)
//    case supervisorRejected(_ code: Int)
//    case supervisorPending(_ code: Int)
//    
//    case acceptReject
   
    func rawValued() -> String {
        switch self {
        case .fetchApi(let code, let id):
            return "get-site/\(code)/\(id)"
        case .uploadSiteDetails:
            return "project"
        case .logout:
            return "logout"
        case .login:
            return "login"
        case .verifyOtp:
            return "verifyLogin"
        case .adminProjectListing:
            return "project"
        case let .vendorProjectList(name):
            return "vendor-project/\(name)"
        case let .asmProjectList(name):
            return "asm-project/\(name)"
        case let .outsourceProjectList(name):
            return "outsource-project/\(name)"
        case .vendorList:
            return "get-vendor"
        case .clientProjectListing:
            return "client-project" 
        case let .updateProject(id):
            return "update-project/\(id)"
        case .userApi:
            return "userapi"
        case let .notification(name):
            return "notification/\(name)"
        case let .getStateByCityVendor(city, vendor):
            return "get-state-by-city-and-vendor/\(city)/\(vendor)"
        case let .getCityByStateVendor(state, vendor):
            return "get-city-by-state-and-vendor/\(state)/\(vendor)"
        case let .getVendorByStateCity(state, city):
            return "get-vendor-by-city-and-state/\(state)/\(city)"
        }
    }
}

func isSuccess(json : [String : Any]) -> Bool{
    if let isSucess = json["status"] as? Int {
        if isSucess == 200 {
            return true
        }
    }
    if let isSucess = json["status"] as? String {
        if isSucess == "200" {
            return true
        }
    }
    if let isSucess = json["success"] as? String {
        if isSucess == "200" {
            return true
        }
    }
    if let isSucess = json["status"] as? String {
        if isSucess == "success" {
            return true
        }
    }
    if let isSucess = json["success"] as? Int {
        if isSucess == 200 {
            return true
        }
    }
    
    if let isSucess = json["Status Code"] as? Int {
        if isSucess == 200 {
            return true
        }
    }
    if let isSucess = json["code"] as? Int {
        if isSucess == 200 {
            return true
        }
    }
    if let isSucess = json["success"] as? Bool {
        if isSucess == true {
            return true
        }
    }
    
    if let isSucess = json["status"] as? Bool {
        if isSucess == true {
            return true
        }
    }
    return false
}

func isInActivate(json : [String : Any]) -> Bool{
    if let isSucess = json["code"] as? Int {
        if isSucess == 401 {
            return true
        }
    }
    return false
}

func isAlreadyLogin(json : [String : Any]) -> Bool{
    if let isSucess = json["code"] as? Int {
        if isSucess == 403 {
            return true
        }
    }
    return false
}

func isAlreadyAdded(json : [String : Any]) -> Bool{
    if let isSucess = json["status"] as? Int {
        if isSucess == 405 {
            return true
        }
    }
    return false
}

func isDocumentVerificationFalse(json : [String : Any]) -> Bool{
    if let isSucess = json["status"] as? Int {
        if isSucess == 402 {
            return true
        }
    }
    return false
}

func isMobileVarifiedFalse(json : [String : Any]) -> Bool{
    if let isSucess = json["status"] as? Int {
        if isSucess == 402 {
            return true
        }
    }
    return false
}

func message(json : [String : Any]) -> String{
    if let message = json["message"] as? String {
        return message
    }
    if let message = json["message"] as? [String:Any] {
        if let msg = message.values.first as? [String] {
            return msg[0]
        }
    }
    if let error = json["error"] as? String {
        return error
    }
    
    return " "
}

func isBodyCount(json : [[String : Any]]) -> Int{
    return json.count
}
