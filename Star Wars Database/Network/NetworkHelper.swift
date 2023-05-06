//
//  NetworkHelper.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import RxSwift
import Moya

extension PrimitiveSequence {
    func setupThread() -> PrimitiveSequence<Trait, Element> {
        return self.subscribe(on: SerialDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
    }
}

extension Observable {
    func setupThread() -> Observable<Element> {
        return self.subscribe(on: SerialDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
    }
}

extension Single {
    static func empty() -> PrimitiveSequence<SingleTrait, Element> {
        return Observable<Element>.empty().asSingle()
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
