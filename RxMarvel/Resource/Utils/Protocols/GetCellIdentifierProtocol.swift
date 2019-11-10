//
//  GetCellIdentifierProtocol.swift
//  RxMarvel
//
//  Created by Enric Pou Villanueva on 06/11/2019.
//  Copyright © 2019 Enric Pou Villanueva. All rights reserved.
//

import UIKit

protocol GetCellIdentifierProtocol {
    static func cellIdentifier() -> String
}

extension GetCellIdentifierProtocol where Self: UITableViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}
