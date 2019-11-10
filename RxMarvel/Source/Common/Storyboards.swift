//
//  Storyboards.swift
//  RxMarvel
//
//  Created by Enric Pou Villanueva on 10/11/2019.
//  Copyright © 2019 Enric Pou Villanueva. All rights reserved.
//

import UIKit

enum Storyboards: String {
    case characterList = "CharactersList"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}
