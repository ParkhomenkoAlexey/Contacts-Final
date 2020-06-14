//
//  SelfConfiguringCell.swift
//  Contacts
//
//  Created by Алексей Пархоменко on 13.06.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure(with user: ContactsModel.User)
}
