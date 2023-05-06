//
//  PeopleService.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import Moya

enum PeopleService {
    case getPeople(page: Int)
    case getDetailPeople(id: Int)
}

extension PeopleService: TargetType {
    var baseURL: URL {
        return URL(string: environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getPeople:
            return Endpoints.people
        case .getDetailPeople(let id):
            return Endpoints.people + "/\(id)"
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
