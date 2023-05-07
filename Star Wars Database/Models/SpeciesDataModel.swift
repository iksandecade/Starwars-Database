//
//  SpeciesDataModel.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import Foundation

struct ResponseSpeciesDataModel: Codable {
    var name: String?
    var classification: String?
    var designation: String?
    var average_height: String?
    var skin_colors: String?
    var hair_colors: String?
    var eye_colors: String?
    var average_lifespan: String?
    var homeworld: String?
    var language: String?
    var people: [String]?
    var films: [String]?
    var created: String?
    var edited: String?
    var url: String?
}

struct SpeciesDataModel {
    var id: Int
    var data: ResponseSpeciesDataModel?
}
