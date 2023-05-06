//
//  BaseResponse.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import Foundation

struct BaseResponseList<T: Codable>: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [T]?
}
