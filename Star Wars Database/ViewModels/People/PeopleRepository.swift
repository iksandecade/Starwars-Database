//
//  PeopleRepository.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import RxSwift

extension PeopleViewModel {
    func fetchDetailPeople(id: Int) -> Single<ResponsePeopleDataModel> {
        return peopleProvider.rx
            .request(.getDetailPeople(id: id))
            .mapResponse(type: ResponsePeopleDataModel.self)
    }
}
