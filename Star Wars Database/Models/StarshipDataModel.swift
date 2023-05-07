//
//  StarshipDataModel.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import Foundation

struct ResponseStarshipDataModel: Codable {
    var name: String?
    var model: String?
    var manufacturer: String?
    var cost_in_credits: String?
    var length: String?
    var max_atmosphering_speed: String?
    var crew: String?
    var passengers: String?
    var cargo_capacity: String?
    var consumables: String?
    var hyperdrive_rating: String?
    var MGLT: String?
    var starship_class: String?
    var pilots: [String]?
    var films: [String]?
    var created: String?
    var edited: String?
    var url: String?
}

struct StarshipDataModel {
    var id: Int
    var data: ResponseStarshipDataModel?
}
