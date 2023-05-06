//
//  Response+Util.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import RxSwift
import Moya

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func mapResponse<T: Codable>(type: T.Type) -> Single<T> {
        return flatMap { (element) -> Single<T> in
            return try self.handleResponse(element)
        }
    }
    
    func mapArrayResponse<T: Codable>(type: T.Type) -> Single<BaseResponseList<T>> {
        return flatMap { (element) -> Single<BaseResponseList<T>> in
            return try self.handleArrayResponse(element)
        }
    }
    
    private func handleResponse<T: Codable>(_ element: Response) throws -> Single<T> {
        do {
            let response = try element.filterSuccessfulStatusCodes()
            let model = try JSONDecoder().decode(T.self, from: response.data)
            return Single.just(model)
        } catch {
            return Single.error(NSError(domain: "error.starwars.api", code: element.statusCode, userInfo: [NSLocalizedDescriptionKey: "failed to fetch API"]))
        }
    }
    
    private func handleArrayResponse<T: Codable>(_ element: Response) throws -> Single<BaseResponseList<T>> {
        do {
            let response = try element.filterSuccessfulStatusCodes()
            let model = try JSONDecoder().decode(BaseResponseList<T>.self, from: response.data)
            return Single.just(model)
        } catch {
            return Single.error(NSError(domain: "error.starwars.api", code: element.statusCode, userInfo: [NSLocalizedDescriptionKey: "failed to fetch API"]))
        }
    }
}
