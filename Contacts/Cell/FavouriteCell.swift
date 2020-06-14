//
//  FavouriteCell.swift
//  Contacts
//
//  Created by Алексей Пархоменко on 13.06.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

class FavouriteCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "FavouriteCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
    }
    
    func configure(with user: ContactsModel.User) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
