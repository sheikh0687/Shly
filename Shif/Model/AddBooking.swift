//
//  AddBooking.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 28/10/23.
//

import Foundation

struct Api_AddBooking : Codable {
    let result : Res_AddBooking?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_AddBooking.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_AddBooking : Codable {
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
    }
}
