//
//  StarwarsRepository.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import RxSwift

extension StarwarsViewModel {
    func fetchDetailFilm(id: Int) -> Single<ResponseFilmDataModel> {
        return starwarsProvider.rx
            .request(.getDetailFilm(id: id))
            .mapResponse(type: ResponseFilmDataModel.self)
    }
    
    func fetchDetailSpecies(id: Int) -> Single<ResponseSpeciesDataModel> {
        return starwarsProvider.rx
            .request(.getDetailSpecies(id: id))
            .mapResponse(type: ResponseSpeciesDataModel.self)
    }
    
    func fetchDetailVehicle(id: Int) -> Single<ResponseVehicleDataModel> {
        return starwarsProvider.rx
            .request(.getDetailVehicle(id: id))
            .mapResponse(type: ResponseVehicleDataModel.self)
    }
    
    func fetchDetailStarship(id: Int) -> Single<ResponseStarshipDataModel> {
        return starwarsProvider.rx
            .request(.getDetailStarship(id: id))
            .mapResponse(type: ResponseStarshipDataModel.self)
    }
}
