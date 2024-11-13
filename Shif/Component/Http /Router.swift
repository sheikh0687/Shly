//
//  Router.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 20/10/23.
//

import Foundation

enum Router: String {
    
    static let BASE_SERVICE_URL = "https://shly.fr/shly/webservice/"
    static let BASE_IMAGE_URL = "https://shly.fr/shly/uploads/images/"
    
    case login
    case forgotPassword
    case signup
    case otp
    
    // User Side
    
    case getProfile
    case getCategory
    case getServiceFilter
    case getBannerImg
    
    case getProviderDetail
    case getProviderService
    case getProviderReview
    
    case getBookingStatus
    case getConversation
    case getChats
    case getAddress
    case getTimeSlot
    case getNotificationList
    
    case addRating
    case addAddress
    case addBooking
    
    case updateProfile
    case changePassword
    
    case deleteAddress
    case deleteUserAccount
    
    case stripePayment
    case retrieveCard
    case delete_Card
    
    case userPage
    case save_Card
    
    // Provider Side
    
    case getSubCategory
    case getServiceDetail
    case getGalleyImage
    
    case getProviderBookStatus
    case getProviderEarning
    case getWithdrawRequest
    
    case getRequestDetail
    
    case addServices
    case addGalleryImg
    case addChat
    case addWalletReq
    
    case updateService
    case changeStatus
    case updateProviderProfile
    case updateLocation
    
    case deleteService
    case deleteGalleryImg
    
    case contact_Us
    
    public func url() -> String {
        switch self {
            
        case .login:
            return Router.oAuthpath(path: "login")
        case .forgotPassword:
            return Router.oAuthpath(path: "forgot_password")
        case .signup:
            return Router.oAuthpath(path: "signup")
        case .otp:
            return Router.oAuthpath(path: "verify_number")
       
        case .getProfile:
            return Router.oAuthpath(path: "get_profile")
        case .getCategory:
            return Router.oAuthpath(path: "get_category")
        case .getServiceFilter:
            return Router.oAuthpath(path: "get_filter_provider")
        case .getBannerImg:
            return Router.oAuthpath(path: "get_banner_image")
            
        case .getProviderDetail:
            return Router.oAuthpath(path: "get_provider_details")
        case .getProviderService:
            return Router.oAuthpath(path: "get_provider_service")
        case .getProviderReview:
            return Router.oAuthpath(path: "get_rating_review")
        
        case .getBookingStatus:
            return Router.oAuthpath(path: "get_user_book_appointment_list")
        case .getConversation:
            return Router.oAuthpath(path: "get_conversation_detail")
        case .getChats:
            return Router.oAuthpath(path: "get_chat_detail")
        case .getAddress:
            return Router.oAuthpath(path: "get_user_address")
        case .getTimeSlot:
            return Router.oAuthpath(path: "get_time_slot")
        case .getNotificationList:
            return Router.oAuthpath(path: "get_user_notification_list")
            
        case .addRating:
            return Router.oAuthpath(path: "add_rating_review")
        case .addAddress:
            return Router.oAuthpath(path: "add_user_address")
        case .addBooking:
            return Router.oAuthpath(path: "add_book_appointment")
            
        case .updateProfile:
            return Router.oAuthpath(path: "update_profile")
        case .changePassword:
            return Router.oAuthpath(path: "change_password")
            
        case .deleteAddress:
            return Router.oAuthpath(path: "delete_user_address")
        case .deleteUserAccount:
            return Router.oAuthpath(path: "delete_user_account")
            
        case .stripePayment:
            return Router.oAuthpath(path: "stripe_payment")
        case .save_Card:
            return Router.oAuthpath(path: "save_card_stripe")
        case .delete_Card:
            return Router.oAuthpath(path: "delete_saved_card")
            
        case .userPage:
            return Router.oAuthpath(path: "get_user_page")
            
        ///  Provider Side
            ///
        case .getSubCategory:
            return Router.oAuthpath(path: "get_sub_category_list")
        case .getServiceDetail:
            return Router.oAuthpath(path: "get_provider_service_details")
        case .getGalleyImage:
            return Router.oAuthpath(path: "get_provider_image_list")
            
        case .getProviderBookStatus:
            return Router.oAuthpath(path: "get_proivder_book_appointment")
        case .getProviderEarning:
            return Router.oAuthpath(path: "get_provider_total_earning")
        case .getWithdrawRequest:
            return Router.oAuthpath(path: "get_withdraw_request")
            
        case .getRequestDetail:
            return Router.oAuthpath(path: "get_request_details")
            
        case .addServices:
            return Router.oAuthpath(path: "add_service")
        case .addGalleryImg:
            return Router.oAuthpath(path: "add_provider_image")
        case .addChat:
            return Router.oAuthpath(path: "insert_chat")
        case .addWalletReq:
            return Router.oAuthpath(path: "add_withdraw_request")
            
        case .updateService:
            return Router.oAuthpath(path: "provider_update_service")
        case .changeStatus:
            return Router.oAuthpath(path: "change_request_status")
        case .updateProviderProfile:
            return Router.oAuthpath(path: "update_provider_profile")
        case .updateLocation:
            return Router.oAuthpath(path: "update_location")
            
        case .deleteService:
            return Router.oAuthpath(path: "provider_delete_service")
        case .deleteGalleryImg:
            return Router.oAuthpath(path: "delete_provider_image_new")
        
        case .retrieveCard:
            return Router.oAuthpath(path: "retrieve_all_card_stripe")
      
        case .contact_Us:
            return Router.oAuthpath(path: "send_feedback")
      
        }
    }
    
    private static func oAuthpath(path: String) -> String {
        return Router.BASE_SERVICE_URL + path
    }
}
