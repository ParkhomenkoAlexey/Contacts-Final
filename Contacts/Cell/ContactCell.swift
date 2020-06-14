//
//  ContactCell.swift
//  Contacts
//
//  Created by Алексей Пархоменко on 13.06.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

class ContactCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "ContactCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
    }
    
    func configure(with user: ContactsModel.User) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
