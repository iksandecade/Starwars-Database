//
//  Environment.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import Foundation

let environment: Environment = .Development

enum Environment {
    case Production
    case Development
    
    var baseURL: String {
        switch self {
        case .Production: return "https://swapi.dev/api/"
        case .Development: return "https://swapi.dev/api/"
        }
    }
}
