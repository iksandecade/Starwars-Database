//
//  UICollectionView+Helper.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import UIKit

extension UICollectionView {
    func registerNIB(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        self.register(UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
    }
    
    func dequeueCell<T>(with cellClass: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as? T
    }
    
    func registerHeaderNIB(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        self.register(UINib(nibName: className, bundle: nil),
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: className)
    }
    
    func dequeueHeader<T>(with cellClass: T.Type, for indexPath: IndexPath) -> T? {
        let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                    withReuseIdentifier: String(describing: cellClass),
                                                    for: indexPath) as? T
        return view
    }
    
    func registerFooter(_ footerClass: AnyClass) {
        let className = String(describing: footerClass)
        self.register(footerClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: className)
    }
    
    func dequeueFooter<T>(_ footerClass: T.Type, for indexPath: IndexPath) -> T? {
        let className = String(describing: footerClass)
        let footer = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: className, for: indexPath)
        return footer as? T
    }
}
