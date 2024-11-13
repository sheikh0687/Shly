//
//  VerifyNumb.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 20/01/24.
//

import Foundation

struct ApiVerifyOtp : Codable {
    
    let result : ResOtp?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResOtp.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct ResOtp : Codable {
    
    let code : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
    }
}
