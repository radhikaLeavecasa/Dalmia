//
//  File.swift
//  Josh
//
//  Created by Esfera-Macmini on 12/04/22.
//

import UIKit

struct CommonParam{

//    static let CREATE_DATE = "create_date"
//    static let COUPON_CODE = "coupon_code"
//    static let INSURANCE_IMAGE_ = "insurance_image"
//    static let INSURANCE_NUMBER = "insuranceNumber"
//    static let ANSWER = "answer"
//    static let QUESTIONS = "questions"
//    static let QUESTION = "question"
//    static let DISEASE = "disease"
//    static let DESCRIPTION = "description"
//    static let TITLE = "title"
//    static let HEALTHQUESTIONS = "healthQuestions"
//    static let NEARBYDOCTORS = "nearByDoctors"
//    static let SERVICES = "services"
//    static let SPECILITIES = "specilities"
//    static let SYMPTOMS = "symptoms"
//    static let TESTIMONIALS = "testimonials"
//    static let BANNERS = "banners"
//    static let LAT = "latitude"
//    static let LONG = "longitude"
//    static let ADDRESS = "address"
//    static let ADDRESS1 = "AddressLine1"
//    static let DOB = "date_of_birth"
//    static let GENDER = "gender"
//    static let PHONE = "phone"
//    static let EMAIL = "email"
//    static let NAME = "name"
    static let USER_TOKEN = "token"
//    static let YES = "YES"
//    static let IS_PROFILE_PENDING = "is_profile_pending"
    static let MESSAGE = "message"
    static let DATA = "data"
//    static let ERROR = "error"
//    static let MEDICAL_ID = "medical_id"
//    static let MEDICAL_REPORT = "medical_report"
//    static let COUNTRIES = "countries"
//    static let COUNTRY_CODE = "country_code"
//    static let CODE = "code"
//    static let COUNTY_CODE = "county_code"
//    static let COUNTRY_ID = "country_id"
//    static let COUNTRY_NAME = "country_name"
//    static let IMAGE = "image"
//    static let INSURANCE_IMAGE = "Ins_image"
//    static let INTRO_DONE = "INTRO_DONE"
//    static let IOS_CODE = "iso_code_3"
//    static let PHONE_CODE = "phone_code"
//    static let STATUS = "status"
//    static let COUNTRY = "country"
//    static let URL = "url"
//    static let STATE = "state"
//    static let MOBILE_NUMBER = "mobile"
//    static let CONTACT_NUMBER = "contact_number"
//    static let DEVICE_ID = "device_id"
//    static let OTP = "otp"
//    static let DEVICE_TYPE = "device_type"
    static let DEVICE_TOKEN = "device_token"
    static let APNS_TOKEN = "apns_token"
    static let ONE_WAY = "One Way"
    static let Ownword = "Oneword"
//    static let ID = "id"
//    static let EDUCATION = "education"
//    static let EXPERIENCE = "experience"
//    static let SPECILITY = "specility"
//    static let SPECILITY_NEW = "speciality"
//    static let RATING = "rating"
//    static let REVIEWS = "reviews"
//    static let ISLIKE = "is_like"
//    static let DOCTORS = "doctors"
//    static let CLINICFEE = "clinicFee"
//    static let CLINICFOLLOWUP  = "clinicFollowUp"
//    static let IS_CLINIC = "is_clinic"
//    static let IS_ONLINE = "is_online"
//    static let ONLINEFEE = "onlineFee"
//    static let ONLINEFEEFOLLOWUP = "onlineFeeFollowUp"
//    static let CONSULTATIONTYPE = "consultationType"
//    static let CLINICES =  "clinics"
//    static let ALLAPPOINTMENTS = "all_appointments"
//    static let PATIENTSTORIES = "patientStories"
//    static let REVIEW = "review"
//    static let DOCTOR_RATTING = "doctor_ratting"
//    static let CLINICDETAIL = "clinicDetail"
//    static let DOCTORDETAIL = "doctorDetail"
//    static let BOOKINGDETAIL = "bookingDetail"
//    static let PAYMENT = "payment"
//    static let TIME = "time"
//    static let TIMESLOT = "time_slot"
//    static let MORNING = "morning"
//    static let EVENING = "evening"
//    static let BRAND = "brand"
//    static let CARDID = "card_id"
//    static let EXPMONTH = "exp_month"
//    static let EXPYEAR = "exp_year"
//    static let LASTFOUR = "last_four"
//    static let CARDS = "cards"
//    static let LAB_NAME = "lab_name"
//    static let LAB_IMAGE = "lab_image"
//    static let INVOICE = "invoice"
//    static let REPORT = "report"
//    static let PRESCRIPTION_DATE = "prescription_date"
//    static let SID = "chat_access_token"
//    static let BOOKINGID = "booking_id"
//    static let BOOKINGTYPE = "booking_type"
//    static let CLINICID = "clinic_id"
//    static let CLINICLAT = "clinic_lat"
//    static let CLINICLONG = "clinic_long"
//    static let CLINICNAME = "clinic_name"
//    static let DATE = "date"
//    static let BOOKINGDATE = "bookingDate"
//    static let DOCTORCOUNTRYCODE = "doctor_country_code"

}

struct CommonError{
    static let SOMETHING_WENT_WRONG = "Something went wrong, Try again"
//    static let BAD_REQUEST = "Bad Request"
//    static let UNAUTHORIESED = "Unauthorised"
//    static let INVALID_TOKEN = "Invalid or expired Token!"
//    static let SERVER_ERROR = "Internal Server Error"
//    static let NOT_FOUND = "Url Not Found"
//    static let SUCESSE = "Done"
//    static let EXPIRED = "Token expired!"
    static let INTERNET = "No internet"
}

struct CommonMessage {
    static let REJECTED_SUCCESS = "Details have been rejected!"
    static let REJECT_DETAILS = "Are you sure you want to reject these details?"
    static let APPROVED_SUCCESSFULLY = "Details Approved successfully!"
    static let CANCEL = "Cancel"
    static let REJECT = "Reject"
    static let APPROVE = "Approve"
    static let APPROVE_DETAILS = "Are you sure you want to approve this site?"
    static let ACME_VENDOR = "Acme Vendor"
    static let LOGGED_OUT = "Logged out successfully!"
    static let NO_INTERNET_CONNECTION = "No Internet Connection"
    static let ENTER_HEIGHT = "Please enter height"
    static let ENTER_WIDTH = "Please enter width"
    static let ENTER_STATE = "Please enter state"
    static let ENTER_DISTRICT = "Please enter district"
    static let ENTER_CITY = "Please enter city"
    static let ENTER_ZONE = "Please enter zone"
    static let ENTER_VENDOR_NAME = "Please enter vendor name"
    static let ENTER_SHOP_NAME = "Please enter shop name"
    static let ENTER_SITE_NAME = "Please enter site name"
    static let ENTER_DATE = "Please choose date"
    static let ENTER_OWNER_NAME = "Please enter owner name"
    static let ENTER_OWNER_EMAIL = "Please enter owner email"
    static let ENTER_VALID_OWNER_EMAIL = "Please enter valid owner email"
    static let ENTER_EMAIL = "Please enter email"
    static let ENTER_VALID_EMAIL = "Please enter valid email"
    static let ENTER_OWNER_MOBILE = "Please enter owner mobile"
    static let ENTER_YOUR_NAME = "Please enter your name"
    static let ENTER_ASM_NAME = "Please enter ASM name"
    
    static let ENTER_RECCE_NAME = "Please enter your name"
    static let ENTER_RECCE_LOCATION = "Please enter location"
    
    static let ENTER_ASM_NUMBER = "Please enter ASM number"
    static let ENTER_LOCATION = "Please enter location"
    static let ADD_SITE_PHOTO = "Please upload site photo"
    static let ADD_STORE_PHOTO1 = "Please upload site photo 1"
    static let ADD_STORE_PHOTO2 = "Please upload site photo 2"
    static let ADD_STORE_PHOTO3 = "Please upload site photo 3"
    static let ADD_STORE_PHOTO4 = "Please upload site photo 4"
    static let ADD_SIGNATURE_OF_OWNER = "Please upload your selfie"
    static let LAT_LONG_FETCH = "Latitude & longitude were not fetched properly, please check location settings and retake site photo to fetch latitude & longitude"
    
//    static let ENTER_STATE = "No Internet Connection"
//    static let ENTER_DISTRICT = "Please retry internet connection not available"

}

struct AlertStrings {

    static let SUCCESSFULLY_UPLOAD_PROFILE_PIC = "Successfully upload profile pic"
    static let ENTER_OUTDOOR_SITE_CODE = "Please enter outdoor site code"
}


struct WSRequestParams {
    static let WS_REQS_PARAM_DISTRICT            = "district"
    static let WS_REQS_PARAM_CITY                = "city"
    static let WS_REQS_PARAM_LAT                 = "lat"
    static let WS_REQS_PARAM_RETAIL_NAME         = "retail_name"
    static let WS_REQS_PARAM_STATE               = "state"
    static let WS_REQS_PARAM_LONG                = "long"
    static let WS_REQS_PARAM_LENGTH              = "length"
    static let WS_REQS_PARAM_WIDTH               = "width"
    static let WS_REQS_PARAM_DATE                = "date"
    static let WS_REQS_PARAM_OWNER_NAME          = "owner_name"
    static let WS_REQS_PARAM_EMAIL               = "email"
    static let WS_REQS_PARAM_REMARKS             = "remarks"
    static let WS_REQS_PARAM_CREATED_BY          = "created_by"
    static let WS_REQS_PARAM_LOCATION            = "location"
    static let WS_REQS_PARAM_IMAGE2              = "image2"
    static let WS_REQS_PARAM_IMAGE1              = "image1"
    static let WS_REQS_PARAM_IMAGE3              = "image3"
    static let WS_REQS_PARAM_IMAGE4              = "image4"
    static let WS_REQS_PARAM_OWNER_SIGN          = "signature"
    static let WS_REQS_PARAM_AREA                = "area"
    static let WS_REQS_PARAM_IMAGE               = "image"
    
    static let WS_REQS_PARAM_RACCE_NAME          = "racce_person_name"
    static let WS_REQS_PARAM_RACCE_IMAGE         = "racce_person_image"
    
    static let WS_REQS_PARAM_ASM_NAME            = "asm_name"
    static let WS_REQS_PARAM_DIVISION            = "division"
    static let WS_REQS_PARAM_RETAILER_CODE       = "retailer_code"
    static let WS_REQS_PARAM_ASM_MOBILE          = "asm_mobile"
    static let WS_REQS_PARAM_MOBILE              = "mobile"
    static let WS_REQS_PARAM_PASSWORD            = "password"
    static let WS_REQS_PARAM_CODE                = "code"
    static let WS_REQS_PARAM_ASM_STATUS          = "asm_status"
    static let WS_REQS_PARAM_ASM_APPROVE_ID      = "asm_approver_id"
    static let WS_REQS_PARAM_PROJECT_ID          = "project_id"
    static let WS_REQS_PARAM_ASM_REMARKS         = "asm_remarks"

}

struct WSResponseParams {
    
    static let WS_RESP_PARAM_ACCESS_TOKEN        = "token"
    static let WS_REPS_PARAM_DATA                = "data"
    static let WS_RESP_PARAM_ERRORS              = "errors"
    static let WS_RESP_PARAM_MESSAGE             = "message"
    static let WS_RESP_PARAM_MESSAGES            = "messages"
    static let WS_RESP_PARAM_RESULTS             = "results"
}


struct AlertMessages {
    
    static let EXPECTED_DICTIONARY_ALERT = "Expected a dictionary containing an image, but was provided the following:"
}

struct DateFormat {
    static let fullDate             = "EEEE, MMMM, dd, yyyy"
    static let dateMonth            = "dd MMM"
    static let fullDateTime         = "yyyy-MM-dd HH:MM:ss"
    static let dayDateMonth         = "EEE, dd MMM"
    static let monthDateYear        = "MMM dd, yyyy"
    static let dayDateMonthYear     = "EEE, dd MMM yyyy"
    static let yearMonthDate        = "yyyy-MM-dd"
}
