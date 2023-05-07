//
//  VehicleDataModel.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import Foundation

struct ResponseVehicleDataModel: Codable {
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
    var vehicle_class: String?
    var pilots: [String]?
    var films: [String]?
    var created: String?
    var edited: String?
    var url: String?
}

struct VehicleDataModel {
    var id: Int
    var data: ResponseVehicleDataModel?
}
