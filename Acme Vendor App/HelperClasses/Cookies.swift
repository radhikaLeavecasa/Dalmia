//
//  Cookes.swift
//  Josh
//
//  Created by Esfera-Macmini on 28/04/22.
//

import Foundation

extension NSDictionary {

    var type:String{
        let type = self["type"] as? String ?? ""
        return type
    }
    
    var employeeId: Int {
        let type = self["employee_id"] as? Int ?? 0
        return type
    }
    
    var state:String{
        let type = self["state"] as? String ?? ""
        return type
    }
    
    var zone:String{
        let type = self["zone"] as? String ?? ""
        return type
    }
    
    var city:String{
        let type = self["city"] as? String ?? ""
        return type
    }
    
    var area:String{
        let type = self["area"] as? String ?? ""
        return type
    }
    
    var name:String{
        let fullName = self["name"] as? String ?? ""
        return fullName
    }
    
    var email:String{
        let email = self["email"] as? String ?? ""
        return email
    }
    
    var notification_setting: Int{
        let notification_setting = self["notification_setting"] as? Int ?? 0
        return notification_setting
    }
    
    var id:Int{
        let title = self["id"] as? Int ?? 0
        return title
    }
    
}

class Cookies {
    
    class func userInfoSave(dict : [String : Any]? = nil){
        let keyData = NSKeyedArchiver.archivedData(withRootObject: dict as Any)
        UserDefaults.standard.set(keyData, forKey: "userInfoSave")
        UserDefaults.standard.synchronize()
    }
    
    class func userInfo() -> NSDictionary? {
        if let some =  UserDefaults.standard.object(forKey: "userInfoSave") as? NSData {
            if let dict = NSKeyedUnarchiver.unarchiveObject(with: some as Data) as? NSDictionary {
                return dict
            }
        }
        return nil
    }
    
    class func getUserToken() -> String {
        if let token = UserDefaults.standard.value(forKey: WSResponseParams.WS_RESP_PARAM_ACCESS_TOKEN) as? String {
            return token
        }
        return ""
    }
    
    class func deleteUserInfo() {
        UserDefaults.standard.removeObject(forKey: "userInfoSave")
    }
    
    class func deleteUserToken() {
        UserDefaults.standard.removeObject(forKey: WSResponseParams.WS_RESP_PARAM_ACCESS_TOKEN)
    }
}

