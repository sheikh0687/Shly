//
//  ProviderBookingStatus.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 30/10/23.
//

import Foundation

struct Api_ProoviderBookingStatus : Codable {
    let result : [Res_ProoviderBookingStatus]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_ProoviderBookingStatus].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_ProoviderBookingStatus : Codable {
    let id : String?
    let user_id : String?
    let provider_id : String?
    let service_id : String?
    let service_name : String?
    let price : String?
    let total_amount : String?
    let sub_amount : String?
    let barber_amount : String?
    let admin_commission : String?
    let admin_VAT : String?
    let discount : String?
    let use_reward_discount : String?
    let use_reward_point : String?
    let date : String?
    let time : String?
    let accept_one_hr : String?
    let time1 : String?
    let address : String?
    let lat : String?
    let lon : String?
    let address_id : String?
    let offer_id : String?
    let offer_code : String?
    let unique_code : String?
    let description : String?
    let payment_type : String?
    let payment_status : String?
    let point : String?
    let service_place : String?
    let emp_id : String?
    let emp_name : String?
    let emp_image : String?
    let emp_gender : String?
    let status : String?
    let date_time : String?
    let date_time_last : String?
    let date_time_two_hr : String?
    let timezone : String?
    let reason_title : String?
    let reason_detail : String?
    let extra_service_name : String?
    let extra_service_price : String?
    let extra_service_payment_type : String?
    let extra_service_id : String?
    let payment_confirmation : String?
    let time_slot : String?
    let service_for : String?
    let home_service_fee : String?
    let unseen_chat_count : String?
    let rating_review_status : String?
    let user_details : Provider_User_details?
    let request_images : [String]?
    let service_details : [Provider_Service_details]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case provider_id = "provider_id"
        case service_id = "service_id"
        case service_name = "service_name"
        case price = "price"
        case total_amount = "total_amount"
        case sub_amount = "sub_amount"
        case barber_amount = "barber_amount"
        case admin_commission = "admin_commission"
        case admin_VAT = "admin_VAT"
        case discount = "discount"
        case use_reward_discount = "use_reward_discount"
        case use_reward_point = "use_reward_point"
        case date = "date"
        case time = "time"
        case accept_one_hr = "accept_one_hr"
        case time1 = "time1"
        case address = "address"
        case lat = "lat"
        case lon = "lon"
        case address_id = "address_id"
        case offer_id = "offer_id"
        case offer_code = "offer_code"
        case unique_code = "unique_code"
        case description = "description"
        case payment_type = "payment_type"
        case payment_status = "payment_status"
        case point = "point"
        case service_place = "service_place"
        case emp_id = "emp_id"
        case emp_name = "emp_name"
        case emp_image = "emp_image"
        case emp_gender = "emp_gender"
        case status = "status"
        case date_time = "date_time"
        case date_time_last = "date_time_last"
        case date_time_two_hr = "date_time_two_hr"
        case timezone = "timezone"
        case reason_title = "reason_title"
        case reason_detail = "reason_detail"
        case extra_service_name = "extra_service_name"
        case extra_service_price = "extra_service_price"
        case extra_service_payment_type = "extra_service_payment_type"
        case extra_service_id = "extra_service_id"
        case payment_confirmation = "payment_confirmation"
        case time_slot = "time_slot"
        case service_for = "service_for"
        case home_service_fee = "home_service_fee"
        case unseen_chat_count = "unseen_chat_count"
        case rating_review_status = "rating_review_status"
        case user_details = "user_details"
        case request_images = "request_images"
        case service_details = "service_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        provider_id = try values.decodeIfPresent(String.self, forKey: .provider_id)
        service_id = try values.decodeIfPresent(String.self, forKey: .service_id)
        service_name = try values.decodeIfPresent(String.self, forKey: .service_name)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        sub_amount = try values.decodeIfPresent(String.self, forKey: .sub_amount)
        barber_amount = try values.decodeIfPresent(String.self, forKey: .barber_amount)
        admin_commission = try values.decodeIfPresent(String.self, forKey: .admin_commission)
        admin_VAT = try values.decodeIfPresent(String.self, forKey: .admin_VAT)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        use_reward_discount = try values.decodeIfPresent(String.self, forKey: .use_reward_discount)
        use_reward_point = try values.decodeIfPresent(String.self, forKey: .use_reward_point)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        accept_one_hr = try values.decodeIfPresent(String.self, forKey: .accept_one_hr)
        time1 = try values.decodeIfPresent(String.self, forKey: .time1)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        address_id = try values.decodeIfPresent(String.self, forKey: .address_id)
        offer_id = try values.decodeIfPresent(String.self, forKey: .offer_id)
        offer_code = try values.decodeIfPresent(String.self, forKey: .offer_code)
        unique_code = try values.decodeIfPresent(String.self, forKey: .unique_code)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        payment_type = try values.decodeIfPresent(String.self, forKey: .payment_type)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        point = try values.decodeIfPresent(String.self, forKey: .point)
        service_place = try values.decodeIfPresent(String.self, forKey: .service_place)
        emp_id = try values.decodeIfPresent(String.self, forKey: .emp_id)
        emp_name = try values.decodeIfPresent(String.self, forKey: .emp_name)
        emp_image = try values.decodeIfPresent(String.self, forKey: .emp_image)
        emp_gender = try values.decodeIfPresent(String.self, forKey: .emp_gender)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        date_time_last = try values.decodeIfPresent(String.self, forKey: .date_time_last)
        date_time_two_hr = try values.decodeIfPresent(String.self, forKey: .date_time_two_hr)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
        reason_title = try values.decodeIfPresent(String.self, forKey: .reason_title)
        reason_detail = try values.decodeIfPresent(String.self, forKey: .reason_detail)
        extra_service_name = try values.decodeIfPresent(String.self, forKey: .extra_service_name)
        extra_service_price = try values.decodeIfPresent(String.self, forKey: .extra_service_price)
        extra_service_payment_type = try values.decodeIfPresent(String.self, forKey: .extra_service_payment_type)
        extra_service_id = try values.decodeIfPresent(String.self, forKey: .extra_service_id)
        payment_confirmation = try values.decodeIfPresent(String.self, forKey: .payment_confirmation)
        time_slot = try values.decodeIfPresent(String.self, forKey: .time_slot)
        service_for = try values.decodeIfPresent(String.self, forKey: .service_for)
        home_service_fee = try values.decodeIfPresent(String.self, forKey: .home_service_fee)
        unseen_chat_count = try values.decodeIfPresent(String.self, forKey: .unseen_chat_count)
        rating_review_status = try values.decodeIfPresent(String.self, forKey: .rating_review_status)
        user_details = try values.decodeIfPresent(Provider_User_details.self, forKey: .user_details)
        request_images = try values.decodeIfPresent([String].self, forKey: .request_images)
        service_details = try values.decodeIfPresent([Provider_Service_details].self, forKey: .service_details)
    }

}

struct Provider_Service_details : Codable {
    let id : String?
    let user_id : String?
    let cat_id : String?
    let cat_name : String?
    let sub_cat_id : String?
    let sub_cat_name : String?
    let service_name : String?
    let description : String?
    let service_rate : String?
    let working_time : String?
    let image : String?
    let date_time : String?
    let remove_status : String?
    let service_images : [Provider_Service_images]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case sub_cat_id = "sub_cat_id"
        case sub_cat_name = "sub_cat_name"
        case service_name = "service_name"
        case description = "description"
        case service_rate = "service_rate"
        case working_time = "working_time"
        case image = "image"
        case date_time = "date_time"
        case remove_status = "remove_status"
        case service_images = "service_images"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        sub_cat_id = try values.decodeIfPresent(String.self, forKey: .sub_cat_id)
        sub_cat_name = try values.decodeIfPresent(String.self, forKey: .sub_cat_name)
        service_name = try values.decodeIfPresent(String.self, forKey: .service_name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        service_rate = try values.decodeIfPresent(String.self, forKey: .service_rate)
        working_time = try values.decodeIfPresent(String.self, forKey: .working_time)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        service_images = try values.decodeIfPresent([Provider_Service_images].self, forKey: .service_images)
    }

}

struct Provider_User_details : Codable {
    let id : String?
    let store_id : String?
    let first_name : String?
    let last_name : String?
    let store_name : String?
    let mobile : String?
    let mobile_with_code : String?
    let email : String?
    let password : String?
    let country_id : String?
    let state_id : String?
    let state_name : String?
    let city_id : String?
    let city_name : String?
    let image : String?
    let type : String?
    let social_id : String?
    let lat : String?
    let lon : String?
    let address : String?
    let addresstype : String?
    let address_id : String?
    let gender : String?
    let wallet : String?
    let register_id : String?
    let ios_register_id : String?
    let status : String?
    let approve_status : String?
    let available_status : String?
    let code : String?
    let date_time : String?
    let cat_id : String?
    let cat_name : String?
    let bank_name : String?
    let branch_name : String?
    let iban_id : String?
    let account_number : String?
    let bank_emirates : String?
    let store_logo : String?
    let store_cover_image : String?
    let about_store : String?
    let about_employee : String?
    let remove_status : String?
    let home_service : String?
    let home_service_fee : String?
    let cash_payment_for_user : String?
    let allow_reward_point : String?
    let reward_point : String?
    let reward_point_value : String?
    let best_rated : String?
    let card : String?
    let cash : String?
    let paypal : String?
    let rating : String?
    let rating_count : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case store_id = "store_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case store_name = "store_name"
        case mobile = "mobile"
        case mobile_with_code = "mobile_with_code"
        case email = "email"
        case password = "password"
        case country_id = "country_id"
        case state_id = "state_id"
        case state_name = "state_name"
        case city_id = "city_id"
        case city_name = "city_name"
        case image = "image"
        case type = "type"
        case social_id = "social_id"
        case lat = "lat"
        case lon = "lon"
        case address = "address"
        case addresstype = "addresstype"
        case address_id = "address_id"
        case gender = "gender"
        case wallet = "wallet"
        case register_id = "register_id"
        case ios_register_id = "ios_register_id"
        case status = "status"
        case approve_status = "approve_status"
        case available_status = "available_status"
        case code = "code"
        case date_time = "date_time"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case bank_name = "bank_name"
        case branch_name = "branch_name"
        case iban_id = "Iban_id"
        case account_number = "account_number"
        case bank_emirates = "bank_emirates"
        case store_logo = "store_logo"
        case store_cover_image = "store_cover_image"
        case about_store = "about_store"
        case about_employee = "about_employee"
        case remove_status = "remove_status"
        case home_service = "home_service"
        case home_service_fee = "home_service_fee"
        case cash_payment_for_user = "cash_payment_for_user"
        case allow_reward_point = "allow_reward_point"
        case reward_point = "reward_point"
        case reward_point_value = "reward_point_value"
        case best_rated = "best_rated"
        case card = "card"
        case cash = "cash"
        case paypal = "paypal"
        case rating = "rating"
        case rating_count = "rating_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        store_id = try values.decodeIfPresent(String.self, forKey: .store_id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        store_name = try values.decodeIfPresent(String.self, forKey: .store_name)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        mobile_with_code = try values.decodeIfPresent(String.self, forKey: .mobile_with_code)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        state_id = try values.decodeIfPresent(String.self, forKey: .state_id)
        state_name = try values.decodeIfPresent(String.self, forKey: .state_name)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        social_id = try values.decodeIfPresent(String.self, forKey: .social_id)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        addresstype = try values.decodeIfPresent(String.self, forKey: .addresstype)
        address_id = try values.decodeIfPresent(String.self, forKey: .address_id)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
        register_id = try values.decodeIfPresent(String.self, forKey: .register_id)
        ios_register_id = try values.decodeIfPresent(String.self, forKey: .ios_register_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        approve_status = try values.decodeIfPresent(String.self, forKey: .approve_status)
        available_status = try values.decodeIfPresent(String.self, forKey: .available_status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        bank_name = try values.decodeIfPresent(String.self, forKey: .bank_name)
        branch_name = try values.decodeIfPresent(String.self, forKey: .branch_name)
        iban_id = try values.decodeIfPresent(String.self, forKey: .iban_id)
        account_number = try values.decodeIfPresent(String.self, forKey: .account_number)
        bank_emirates = try values.decodeIfPresent(String.self, forKey: .bank_emirates)
        store_logo = try values.decodeIfPresent(String.self, forKey: .store_logo)
        store_cover_image = try values.decodeIfPresent(String.self, forKey: .store_cover_image)
        about_store = try values.decodeIfPresent(String.self, forKey: .about_store)
        about_employee = try values.decodeIfPresent(String.self, forKey: .about_employee)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        home_service = try values.decodeIfPresent(String.self, forKey: .home_service)
        home_service_fee = try values.decodeIfPresent(String.self, forKey: .home_service_fee)
        cash_payment_for_user = try values.decodeIfPresent(String.self, forKey: .cash_payment_for_user)
        allow_reward_point = try values.decodeIfPresent(String.self, forKey: .allow_reward_point)
        reward_point = try values.decodeIfPresent(String.self, forKey: .reward_point)
        reward_point_value = try values.decodeIfPresent(String.self, forKey: .reward_point_value)
        best_rated = try values.decodeIfPresent(String.self, forKey: .best_rated)
        card = try values.decodeIfPresent(String.self, forKey: .card)
        cash = try values.decodeIfPresent(String.self, forKey: .cash)
        paypal = try values.decodeIfPresent(String.self, forKey: .paypal)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        rating_count = try values.decodeIfPresent(Int.self, forKey: .rating_count)
    }
}

struct Provider_Service_images : Codable {
    let id : String?
    let service_id : String?
    let image : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case service_id = "service_id"
        case image = "image"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        service_id = try values.decodeIfPresent(String.self, forKey: .service_id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
