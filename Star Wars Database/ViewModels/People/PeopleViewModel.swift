//
//  PeopleViewModel.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import Foundation

final class PeopleViewModel: BaseViewModel {
    var peopleData: ResponsePeopleDataModel?
    var listPeopleData: [ResponsePeopleDataModel] = []
    
    var peopleId: Int?
    
    func getDetailPeople(completion: ((Bool, Error?) -> Void)?) {
        if !NetworkManager.isOnline() {
            NotificationCenter.default.post(name: connectionNotif, object: nil)
            return
        }
        
        if let peopleId {
            fetchDetailPeople(id: peopleId)
                .setupThread()
                .subscribe { response in
                    self.peopleData = response
                    completion?(true, nil)
                } onFailure: { error in
                    completion?(false, self.checkErrorInternet(error: error))
                }.disposed(by: disposeBag)
        }
    }
}
