//
//  ProviderDetails.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 21/10/23.
//

import Foundation

struct Api_ProviderDetail : Codable {
    let result : Res_ProviderDeatil?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_ProviderDeatil.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct Res_ProviderDeatil : Codable {
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
    let licence_image : String?
    let rating : String?
    let rating_count : Int?
    let interval_time: String?
    let provider_images : [Gallary_Provider_images]?
//    let employee_details : [String]?
    let fav_provider : String?
    let store_day_details : [Store_day_details]?

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
        case licence_image = "licence_image"
        case rating = "rating"
        case rating_count = "rating_count"
        case provider_images = "provider_images"
//        case employee_details = "employee_details"
        case fav_provider = "fav_provider"
        case store_day_details = "store_day_details"
        case interval_time = "interval_time"
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
        licence_image = try values.decodeIfPresent(String.self, forKey: .licence_image)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        rating_count = try values.decodeIfPresent(Int.self, forKey: .rating_count)
        provider_images = try values.decodeIfPresent([Gallary_Provider_images].self, forKey: .provider_images)
//        employee_details = try values.decodeIfPresent([String].self, forKey: .employee_details)
        fav_provider = try values.decodeIfPresent(String.self, forKey: .fav_provider)
        store_day_details = try values.decodeIfPresent([Store_day_details].self, forKey: .store_day_details)
        interval_time = try values.decodeIfPresent(String.self, forKey: .interval_time)
    }
}

struct Gallary_Provider_images : Codable {
    let id : String?
    let user_id : String?
    let image : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case image = "image"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }
}

struct Store_day_details : Codable {
    let id : String?
    let store_id : String?
    let open_day : String?
    let open_time : String?
    let close_time : String?
    let store_ope_closs_status : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case store_id = "store_id"
        case open_day = "open_day"
        case open_time = "open_time"
        case close_time = "close_time"
        case store_ope_closs_status = "store_ope_closs_status"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        store_id = try values.decodeIfPresent(String.self, forKey: .store_id)
        open_day = try values.decodeIfPresent(String.self, forKey: .open_day)
        open_time = try values.decodeIfPresent(String.self, forKey: .open_time)
        close_time = try values.decodeIfPresent(String.self, forKey: .close_time)
        store_ope_closs_status = try values.decodeIfPresent(String.self, forKey: .store_ope_closs_status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
