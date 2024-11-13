//
//  SiteDetailVM.swift
//  Acme Vendor App
//
//  Created by acme on 07/06/24.
//

import UIKit

class SiteDetailVM: NSObject {
    
    var dict: ListingModel?
    
    func acceptRejectApi(_ api: Api, param:[String:AnyObject], _ completion: @escaping (Bool,String) -> Void) {
        Proxy.shared.loadAnimation()
        WebService.callApi(api: api, method: .post, param: param, header: true) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                if let data = response as? [String:Any] {
                    completion(true, "")
                }
            } else {
                completion(false, msg)
            }
        }
    }
    
    func updateSiteDetails(id: Int, param:[String:Any],dictImage: [String: UIImage], _ completion: @escaping (Bool,String) -> Void){
        Proxy.shared.loadAnimation()
        WebService.uploadImageWithURL(api: .updateProject(id), dictImage: dictImage, parameter: param) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                if let data = response as? [String:Any] {
                    completion(true, msg)
                }
            }else{
                completion(false, msg)
            }
        }
    }
    
    func updateSiteDetails(id: Int, param:[String:Any], _ completion: @escaping (Bool,String) -> Void){
        Proxy.shared.loadAnimation()
        WebService.callApi(api: .updateProject(id), method: .post, param: param, header: true) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                if let data = response as? [String:Any] {
                    completion(true, msg)
                }
            }else{
                completion(false, msg)
            }
        }
    }
    
    func siteDetails(id: String, param:[String:Any], _ completion: @escaping (Bool,String) -> Void){
        Proxy.shared.loadAnimation()
        WebService.callApi(api: .getReminderCodeDetail(id), method: .get, param: param, header: true) { status, msg, response in
            Proxy.shared.stopAnimation()
            if status == true {
                if let data = response as? [String:Any] {
                    
                        if let list = data["data"] as? [String: Any] {
                            self.dict = ListingModel(JSON: list)
                        }
                    
                    completion(true, msg)
                }
            }else{
                completion(false, msg)
            }
        }
    }
}
