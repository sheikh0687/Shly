//
//  Chats.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 26/02/24.
//ApiChats
//ResChats
//

import Foundation

struct Api_Chats : Codable {
    let result : [Res_Chats]?
    let status : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_Chats].self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}


struct Res_Chats : Codable {
    let id : String?
    let sender_id : String?
    let receiver_id : String?
    let chat_message : String?
    let request_id : String?
    let chat_image : String?
    let clear_chat : String?
    let type : String?
    let timezone : String?
    let date_time : String?
    let status : String?
    let result : String?
    let sender_detail : Sender_detail?
    let receiver_detail : Receiver_detail?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case sender_id = "sender_id"
        case receiver_id = "receiver_id"
        case chat_message = "chat_message"
        case request_id = "request_id"
        case chat_image = "chat_image"
        case clear_chat = "clear_chat"
        case type = "type"
        case timezone = "timezone"
        case date_time = "date_time"
        case status = "status"
        case result = "result"
        case sender_detail = "sender_detail"
        case receiver_detail = "receiver_detail"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        sender_id = try values.decodeIfPresent(String.self, forKey: .sender_id)
        receiver_id = try values.decodeIfPresent(String.self, forKey: .receiver_id)
        chat_message = try values.decodeIfPresent(String.self, forKey: .chat_message)
        request_id = try values.decodeIfPresent(String.self, forKey: .request_id)
        chat_image = try values.decodeIfPresent(String.self, forKey: .chat_image)
        clear_chat = try values.decodeIfPresent(String.self, forKey: .clear_chat)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        sender_detail = try values.decodeIfPresent(Sender_detail.self, forKey: .sender_detail)
        receiver_detail = try values.decodeIfPresent(Receiver_detail.self, forKey: .receiver_detail)
    }

}

struct Receiver_detail : Codable {
    let id : String?
    let customer_id : String?
    let card_id : String?
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
    let where_to_hear : String?
    let siren : String?
    let date_of_birth : String?
    let card : String?
    let cash : String?
    let paypal : String?
    let receiver_image : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case customer_id = "customer_id"
        case card_id = "card_id"
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
        case where_to_hear = "where_to_hear"
        case siren = "siren"
        case date_of_birth = "date_of_birth"
        case card = "card"
        case cash = "cash"
        case paypal = "paypal"
        case receiver_image = "receiver_image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        customer_id = try values.decodeIfPresent(String.self, forKey: .customer_id)
        card_id = try values.decodeIfPresent(String.self, forKey: .card_id)
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
        where_to_hear = try values.decodeIfPresent(String.self, forKey: .where_to_hear)
        siren = try values.decodeIfPresent(String.self, forKey: .siren)
        date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
        card = try values.decodeIfPresent(String.self, forKey: .card)
        cash = try values.decodeIfPresent(String.self, forKey: .cash)
        paypal = try values.decodeIfPresent(String.self, forKey: .paypal)
        receiver_image = try values.decodeIfPresent(String.self, forKey: .receiver_image)
    }
}

struct Sender_detail : Codable {
    let id : String?
    let customer_id : String?
    let card_id : String?
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
    let where_to_hear : String?
    let siren : String?
    let date_of_birth : String?
    let card : String?
    let cash : String?
    let paypal : String?
    let sender_image : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case customer_id = "customer_id"
        case card_id = "card_id"
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
        case where_to_hear = "where_to_hear"
        case siren = "siren"
        case date_of_birth = "date_of_birth"
        case card = "card"
        case cash = "cash"
        case paypal = "paypal"
        case sender_image = "sender_image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        customer_id = try values.decodeIfPresent(String.self, forKey: .customer_id)
        card_id = try values.decodeIfPresent(String.self, forKey: .card_id)
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
        where_to_hear = try values.decodeIfPresent(String.self, forKey: .where_to_hear)
        siren = try values.decodeIfPresent(String.self, forKey: .siren)
        date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
        card = try values.decodeIfPresent(String.self, forKey: .card)
        cash = try values.decodeIfPresent(String.self, forKey: .cash)
        paypal = try values.decodeIfPresent(String.self, forKey: .paypal)
        sender_image = try values.decodeIfPresent(String.self, forKey: .sender_image)
    }
}
