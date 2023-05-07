//
//  UIView+Helper.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import UIKit
import RxSwift
import RxGesture

//MARK: View Tap Handler
extension UIView {
    struct properties {
        static var disposeBag = DisposeBag()
    }
    
    var disposeBag: DisposeBag {
        return properties.disposeBag
    }
    
    @objc func addTapHandler(_ handler: @escaping (() -> Void)) {
        self.rx
            .tapGesture()
            .when(.recognized)
            .subscribe { _ in
                handler()
            }.disposed(by: disposeBag)
    }
}

//MARK: Register NIB
extension UIView {
    static func nib<T: UIView>(withType type: T.Type, name: String? = nil) -> T {
        let _name = name ?? String(describing: type)
        return Bundle.main.loadNibNamed(_name, owner: self, options: nil)?.first as! T
    }
}

//MARK: Animation
extension UIView {
    static private let kRotationKey = "rotationanimationkey"
    
    func startRotating(repeating: Float? = nil) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = repeating == nil ? .infinity : repeating!
        self.layer.add(rotation, forKey: UIView.kRotationKey)
    }
    
    func stopRotating() {
        self.layer.removeAnimation(forKey: UIView.kRotationKey)
    }
}
