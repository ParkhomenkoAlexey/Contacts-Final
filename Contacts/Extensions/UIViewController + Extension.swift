//
//  UIViewController + Extension.swift
//  Contacts
//
//  Created by Алексей Пархоменко on 14.06.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func configure<T: SelfConfiguringCell>(collectionView: UICollectionView, cellType: T.Type, with user: ContactsModel.User, for indexPath: IndexPath) -> T {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { fatalError( "Unable to dequeue \(cellType)") }
        cell.configure(with: user)
        return cell
    }
}
