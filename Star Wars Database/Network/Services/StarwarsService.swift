//
//  PeopleService.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import Moya

enum StarwarsService {
    case getPeople(page: Int)
    case getDetailFilm(id: Int)
    case getDetailSpecies(id: Int)
    case getDetailVehicle(id: Int)
    case getDetailStarship(id: Int)
}

extension StarwarsService: TargetType {
    var baseURL: URL {
        return URL(string: environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getPeople:
            return Endpoints.people
        case .getDetailFilm(let id):
            return Endpoints.films + "/\(id)"
        case .getDetailSpecies(let id):
            return Endpoints.species + "/\(id)"
        case .getDetailVehicle(let id):
            return Endpoints.vehicles + "/\(id)"
        case .getDetailStarship(let id):
            return Endpoints.starships + "/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getPeople(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
}
