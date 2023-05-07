//
//  PeopleListLoader.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import RxSwift
import RxCocoa
import Moya

class PeopleListLoader {
    let items = BehaviorRelay<[ResponsePeopleDataModel]>(value: [])
    
    lazy var mainProvider = MoyaProvider<StarwarsService>(plugins: [NetworkLoggerPlugin()])
    
    var page: Int
    
    private let disposeBag = DisposeBag()
    
    private var isLoading = false
    private var hasMore = false
    
    init(page: Int = 1) {
        self.page = page
    }
    
    func loadInitial(_ completion: ((Error?) -> Void)?) {
        guard !isLoading else { return }
        isLoading = true
        self.page = 1
        
        fetchPeopleList()
            .subscribe { response in
                if let data = response.results {
                    self.items.accept(data)
                }
                
                self.isLoading = false
                self.hasMore = response.next != nil
                if self.hasMore {
                    self.page += 1
                }
                completion?(nil)
            } onFailure: { error in
                completion?(error)
            }.disposed(by: disposeBag)
    }
     
    func loadMore(_ completion: ((Error?) -> Void)? = nil) {
        guard !isLoading else { return }
        guard hasMore else { return }
        isLoading = true
        
        fetchPeopleList()
            .subscribe { response in
                if let data = response.results {
                    var values = self.items.value
                    values.append(contentsOf: data)
                    self.items.accept(values)
                }
                
                self.isLoading = false
                self.hasMore = response.next != nil
                if self.hasMore {
                    self.page += 1
                }
                completion?(nil)
            } onFailure: { error in
                completion?(error)
            }.disposed(by: disposeBag)
    }
    
    private func fetchPeopleList() -> Single<BaseResponseList<ResponsePeopleDataModel>> {
        return mainProvider.rx.request(.getPeople(page: page))
            .mapArrayResponse(type: ResponsePeopleDataModel.self)
    }
}
