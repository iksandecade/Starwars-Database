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
