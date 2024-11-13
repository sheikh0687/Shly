//
//  Reviews.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 25/10/23.
//

import Foundation

struct Api_ProviderReview : Codable {
    let result : [Res_ProviderDetail]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_ProviderDetail].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct Res_ProviderDetail : Codable {
    let id : String?
    let request_id : String?
    let form_id : String?
    let to_id : String?
    let welcome_rec_rating : String?
    let property_rating : String?
    let mood_rating : String?
    let service_quality_rating : String?
    let rating : String?
    let feedback : String?
    let type : String?
    let date_time : String?
    let form_details : Form_details?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case request_id = "request_id"
        case form_id = "form_id"
        case to_id = "to_id"
        case welcome_rec_rating = "welcome_rec_rating"
        case property_rating = "property_rating"
        case mood_rating = "mood_rating"
        case service_quality_rating = "service_quality_rating"
        case rating = "rating"
        case feedback = "feedback"
        case type = "type"
        case date_time = "date_time"
        case form_details = "form_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        request_id = try values.decodeIfPresent(String.self, forKey: .request_id)
        form_id = try values.decodeIfPresent(String.self, forKey: .form_id)
        to_id = try values.decodeIfPresent(String.self, forKey: .to_id)
        welcome_rec_rating = try values.decodeIfPresent(String.self, forKey: .welcome_rec_rating)
        property_rating = try values.decodeIfPresent(String.self, forKey: .property_rating)
        mood_rating = try values.decodeIfPresent(String.self, forKey: .mood_rating)
        service_quality_rating = try values.decodeIfPresent(String.self, forKey: .service_quality_rating)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        feedback = try values.decodeIfPresent(String.self, forKey: .feedback)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        form_details = try values.decodeIfPresent(Form_details.self, forKey: .form_details)
    }
}

struct Form_details : Codable {
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
    let user_image : String?

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
        case user_image = "user_image"
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
        user_image = try values.decodeIfPresent(String.self, forKey: .user_image)
    }

}
