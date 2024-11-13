//
//  RetrieveCard.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 18/01/24.
//

import Foundation

struct Api_RetriveCard : Codable {
    let result : Res_RetrieveCard?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_RetrieveCard.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct Res_RetrieveCard : Codable {
    let object : String?
    let data : [Res_Data]?
    let has_more : Bool?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case object = "object"
        case data = "data"
        case has_more = "has_more"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        object = try values.decodeIfPresent(String.self, forKey: .object)
        data = try values.decodeIfPresent([Res_Data].self, forKey: .data)
        has_more = try values.decodeIfPresent(Bool.self, forKey: .has_more)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}

struct Res_Data : Codable {
    let id : String?
    let object : String?
    let address_city : String?
    let address_country : String?
    let address_line1 : String?
    let address_line1_check : String?
    let address_line2 : String?
    let address_state : String?
    let address_zip : String?
    let address_zip_check : String?
    let brand : String?
    let country : String?
    let customer : String?
    let cvc_check : String?
    let dynamic_last4 : String?
    let exp_month : Int?
    let exp_year : Int?
    let fingerprint : String?
    let funding : String?
    let last4 : String?
    let metadata : Metadata?
    let name : String?
    let tokenization_method : String?
    let wallet : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case object = "object"
        case address_city = "address_city"
        case address_country = "address_country"
        case address_line1 = "address_line1"
        case address_line1_check = "address_line1_check"
        case address_line2 = "address_line2"
        case address_state = "address_state"
        case address_zip = "address_zip"
        case address_zip_check = "address_zip_check"
        case brand = "brand"
        case country = "country"
        case customer = "customer"
        case cvc_check = "cvc_check"
        case dynamic_last4 = "dynamic_last4"
        case exp_month = "exp_month"
        case exp_year = "exp_year"
        case fingerprint = "fingerprint"
        case funding = "funding"
        case last4 = "last4"
        case metadata = "metadata"
        case name = "name"
        case tokenization_method = "tokenization_method"
        case wallet = "wallet"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        object = try values.decodeIfPresent(String.self, forKey: .object)
        address_city = try values.decodeIfPresent(String.self, forKey: .address_city)
        address_country = try values.decodeIfPresent(String.self, forKey: .address_country)
        address_line1 = try values.decodeIfPresent(String.self, forKey: .address_line1)
        address_line1_check = try values.decodeIfPresent(String.self, forKey: .address_line1_check)
        address_line2 = try values.decodeIfPresent(String.self, forKey: .address_line2)
        address_state = try values.decodeIfPresent(String.self, forKey: .address_state)
        address_zip = try values.decodeIfPresent(String.self, forKey: .address_zip)
        address_zip_check = try values.decodeIfPresent(String.self, forKey: .address_zip_check)
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        customer = try values.decodeIfPresent(String.self, forKey: .customer)
        cvc_check = try values.decodeIfPresent(String.self, forKey: .cvc_check)
        dynamic_last4 = try values.decodeIfPresent(String.self, forKey: .dynamic_last4)
        exp_month = try values.decodeIfPresent(Int.self, forKey: .exp_month)
        exp_year = try values.decodeIfPresent(Int.self, forKey: .exp_year)
        fingerprint = try values.decodeIfPresent(String.self, forKey: .fingerprint)
        funding = try values.decodeIfPresent(String.self, forKey: .funding)
        last4 = try values.decodeIfPresent(String.self, forKey: .last4)
        metadata = try values.decodeIfPresent(Metadata.self, forKey: .metadata)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        tokenization_method = try values.decodeIfPresent(String.self, forKey: .tokenization_method)
        wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
    }

}

struct Metadata : Codable {

//    enum CodingKeys: String, CodingKey {
//
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//    }

}
