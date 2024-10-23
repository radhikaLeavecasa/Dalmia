//
//  VendorListingModule.swift
//  Acme Vendor App
//
//  Created by acme on 09/09/24.
//

import ObjectMapper

struct VendorListModule: Mappable {
    var area: String?
    var campaignId: String?
    var clientId: String?
    var companyAddress: String?
    var companyName: String?
    var createdAt: String?
    var description: String?
    var email: String?
    var emailVerifiedAt: String?
    var gstNo: String?
    var id: Int?
    var location: String?
    var logo: String?
    var name: String?
    var phoneNumber: String?
    var type: String?
    var uniqueId: String?
    var updatedAt: String?
    var vendorId: String?
    var zone: String?
    var employeeID: String?
    var startDate: String?
    var endDate: String?
    var state: String?
    var city: String?

    init?(map: Map) {
        // Initialization code here
    }

    mutating func mapping(map: Map) {
        state <- map["state"]
        startDate <- map["start_date"]
        endDate <- map["end_date"]
        employeeID <- map["employee_id"]
        area <- map["area"]
        campaignId <- map["campaign_id"]
        clientId <- map["client_id"]
        companyAddress <- map["company_address"]
        companyName <- map["company_name"]
        createdAt <- map["created_at"]
        description <- map["description"]
        email <- map["email"]
        emailVerifiedAt <- map["email_verified_at"]
        gstNo <- map["gst_no"]
        id <- map["id"]
        location <- map["location"]
        logo <- map["logo"]
        name <- map["name"]
        phoneNumber <- map["phone_number"]
        type <- map["type"]
        uniqueId <- map["unique_id"]
        updatedAt <- map["updated_at"]
        vendorId <- map["vendor_id"]
        zone <- map["zone"]
        city <- map["city"]
    }
}
