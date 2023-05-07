//
//  PeopleViewModel.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import Foundation

final class StarwarsViewModel: BaseViewModel {
    var peopleData: ResponsePeopleDataModel?
    var filmsData: [FilmDataModel] = []
    var speciesData: [SpeciesDataModel] = []
    var vehiclesData: [VehicleDataModel] = []
    var starshipsData: [StarshipDataModel] = []
    var listPeopleData: [ResponsePeopleDataModel] = []
    
    func filterData() {
        guard let peopleData else { return }
        filmsData = []
        speciesData = []
        starshipsData = []
        vehiclesData = []
        
        peopleData.films?.forEach({ url in
            if let id = getId(url: url) {
                filmsData.append(FilmDataModel(id: id))
            }
        })
        
        peopleData.species?.forEach({ url in
            if let id = getId(url: url) {
                speciesData.append(SpeciesDataModel(id: id))
            }
        })
        
        peopleData.vehicles?.forEach({ url in
            if let id = getId(url: url) {
                vehiclesData.append(VehicleDataModel(id: id))
            }
        })
        
        peopleData.starships?.forEach({ url in
            if let id = getId(url: url) {
                starshipsData.append(StarshipDataModel(id: id))
            }
        })
    }
    
    func getDetailFilm(id: Int, completion: ((Bool, Error?) -> Void)?) {
        if checkIsOffline() { return }
        
        fetchDetailFilm(id: id)
            .setupThread()
            .subscribe { response in
                self.insertFilmData(id: id, data: response)
                completion?(true, nil)
            } onFailure: { error in
                completion?(false, self.checkErrorInternet(error: error))
            }.disposed(by: disposeBag)
    }
    
    
    func getDetailSpecies(id: Int, completion: ((Bool, Error?) -> Void)?) {
        if checkIsOffline() { return }
        
        fetchDetailSpecies(id: id)
            .setupThread()
            .subscribe { response in
                self.insertSpeciesData(id: id, data: response)
                completion?(true, nil)
            } onFailure: { error in
                completion?(false, self.checkErrorInternet(error: error))
            }.disposed(by: disposeBag)
    }
    
    func getDetailVehicle(id: Int, completion: ((Bool, Error?) -> Void)?) {
        if checkIsOffline() { return }
        
        fetchDetailVehicle(id: id)
            .setupThread()
            .subscribe { response in
                self.insertVehicleData(id: id, data: response)
                completion?(true, nil)
            } onFailure: { error in
                completion?(false, self.checkErrorInternet(error: error))
            }.disposed(by: disposeBag)
    }
    
    func getDetailStarship(id: Int, completion: ((Bool, Error?) -> Void)?) {
        if checkIsOffline() { return }
        
        fetchDetailStarship(id: id)
            .setupThread()
            .subscribe { response in
                self.insertStarshipData(id: id, data: response)
                completion?(true, nil)
            } onFailure: { error in
                completion?(false, self.checkErrorInternet(error: error))
            }.disposed(by: disposeBag)
    }
    
    private func getId(url: String) -> Int? {
        var urlComponent = url.components(separatedBy: "/")
        
        if urlComponent.last?.isEmpty ?? false {
            urlComponent.removeLast()
        }
        
        if let lastComponent = urlComponent.last {
            return Int(lastComponent)
        }
        
        return nil
    }
    
    private func insertFilmData(id: Int, data: ResponseFilmDataModel) {
        for i in 0..<filmsData.count {
            if filmsData[i].id == id {
                filmsData[i].data = data
                break
            }
        }
    }
    
    private func insertSpeciesData(id: Int, data: ResponseSpeciesDataModel) {
        for i in 0..<speciesData.count {
            if speciesData[i].id == id {
                speciesData[i].data = data
                break
            }
        }
    }
    
    private func insertVehicleData(id: Int, data: ResponseVehicleDataModel) {
        for i in 0..<vehiclesData.count {
            if vehiclesData[i].id == id {
                vehiclesData[i].data = data
                break
            }
        }
    }
    
    private func insertStarshipData(id: Int, data: ResponseStarshipDataModel) {
        for i in 0..<starshipsData.count {
            if starshipsData[i].id == id {
                starshipsData[i].data = data
                break
            }
        }
    }
}
