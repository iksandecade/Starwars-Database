//
//  BaseViewModel.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import Moya
import RxSwift
import RxCocoa

class BaseViewModel {
    lazy var disposeBag = DisposeBag()
    lazy var peopleProvider = MoyaProvider<PeopleService>(plugins: [NetworkLoggerPlugin()])
    
    init(){}
    
    func checkErrorInternet(error: Error?) -> Error? {
        if let error, (error as NSError).code == 6 {
            return NSError(domain: "error.starwars.connection", code: 6, userInfo: [NSLocalizedDescriptionKey: "Please check your internet connection"])
        } else if let error {
            if error.localizedDescription.contains("time out") {
                return NSError(domain: "error.starwars.connection", code: 6, userInfo: [NSLocalizedDescriptionKey: "Time out. Try again"])
            }
        }
        
        return error
    }
}
