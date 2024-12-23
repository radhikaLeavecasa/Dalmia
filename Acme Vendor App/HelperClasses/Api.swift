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
    case rhmRejectedList(_ name: String)
    case fetchApi(_ code: String, userID: String)
    case uploadSiteDetails
    case logout
    case login
    case verifyOtp
    case adminProjectListing
    case vendorProjectList(_ name: String)
    case asmProjectList(_ name: String)
    case clientProjectListing
    case rhmClientProjectListing(_ zone: String)
    case vendorExecutiveProjectList(_ name: String)
    case outsourceProjectList(_ name: String)
    case vendorList
    case updateProject(_ id: Int)
    case userApi
    case notification(_ name: String)
    case getStateByCityVendor(_ city: String, vendor: String)
    case getCityByStateVendor(_ state: String, vendor: String)
    case getVendorByStateCity(_ state: String, city: String)
    case vendorAcceptReject(_ projectId: String, createdBy: String, status: String)
    case clientAcceptReject(_ projectId: String, createdBy: String, status: String)
    case getReminderCodeDetail(_ id: String)
    
    case vendorPendingSite(_ name: String)
    case vendorApprovedSite(_ name: String)
    case vendorRejectedSite(_ name: String)
    
    case rhmPendingSite(_ name: String)
    case rhmApprovedSite(_ name: String)
    case rhmRejectedSite(_ name: String)
    
    //State head
    case stateHeadPendingSite(_ state: String)
    case stateHeadApprovedSite(_ state: String)
    case stateHeadRejectedsites(_ state: String)
    case stateHeadsites(_ state: String)
    case stateRhmRejectedSites(_ state: String)
    
    //Agency Rejected
    case agencyRejectedRmh(_ zone: String)
    case agencyRejectedVendor(_ name: String)
    case agencyRejectedAsm(_ state: String)
    
    //City Head
    case cityHeadAllSite(_ city: String)
    case cityHeadPendingSite(_ city: String)
    case cityHeadApprovedSite(_ city: String)
    case cityHeadRejectedsites(_ city: String)
    case cityHeadPostStatus
    case stateHeadRejectedForCityHead(_ city: String)
    
   
    func rawValued() -> String {
        switch self {
        case let .cityHeadAllSite(city):
            return "city-head-all-sites/\(city)"
        case let .cityHeadPendingSite(city):
            return "city-head-pending-sites/\(city)"
        case let .cityHeadApprovedSite(city):
            return "city-head-approved-sites/\(city)"
        case let .cityHeadRejectedsites(city):
            return "city-head-rejected-sites/\(city)"
        case .cityHeadPostStatus:
            return "state-head-approval"
        case let .stateHeadRejectedForCityHead(city):
            return "asm-rejected-project-for-city-head/\(city)"
            
        case let .agencyRejectedRmh(zone):
            return "nodle-agency-rejected-sites-for-rmh/\(zone)"
        case let .agencyRejectedVendor(name):
            return "nodle-agency-rejected-sites-for-vendor/\(name)"
        case let .agencyRejectedAsm(state):
            return "nodle-agency-rejected-sites-for-asm/\(state)"
            
        case let .getReminderCodeDetail(id):
            return "project/\(id)"
        case let .rhmRejectedList(name):
            return "rhm-rejected-site-for-vendor/\(name)"
        case let .vendorPendingSite(name):
            return "vendor-pending-sites/\(name)"
        case let .vendorApprovedSite(name):
            return "vendor-approved-sites/\(name)"
        case let .vendorRejectedSite(name):
            return "vendor-rejected-sites/\(name)"
            
        case let .rhmPendingSite(name):
            return "rhm-pending-sites/\(name)"
        case let .rhmApprovedSite(name):
            return "rhm-approved-sites/\(name)"
        case let .rhmRejectedSite(name):
            return "rhm-rejected-sites/\(name)"
            
        case let .rhmClientProjectListing(zone):
            return "rhm-project/\(zone)"
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
        case let .vendorExecutiveProjectList(name):
            return "vendor-executive-project/\(name)"
        case let .vendorAcceptReject(projectId, createdBy, status):
            return "update-vendor-status/\(projectId)/\(createdBy)/\(status)"
        case let .clientAcceptReject(projectId, createdBy, status):
            return "update-client-status/\(projectId)/\(createdBy)/\(status)"
            
        case let .stateHeadPendingSite(state):
            return "asm-pending-project/\(state)"
        case let .stateHeadApprovedSite(state):
            return "asm-approved-project/\(state)"
        case let .stateHeadRejectedsites(state):
            return "asm-rejected-project/\(state)"
        case let .stateHeadsites(state):
            return "asm-project/\(state)"
        case let .stateRhmRejectedSites(state):
            return "rhm-state-site-rejected/\(state)"
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
