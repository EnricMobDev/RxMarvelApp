//
//  CharacterListViewModel.swift
//  RxMarvel
//
//  Created by Enric Pou Villanueva on 05/11/2019.
//  Copyright © 2019 Enric Pou Villanueva. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

//MARK: CharacterListViewModel
struct CharacterListViewModel {
    
    var characterListVM: [CharacterViewModel]

    init(_ characterList: [Result] = []) {
        self.characterListVM = characterList.compactMap(CharacterViewModel.init)
    }
    
    func characterAt(_ index: Int) -> CharacterViewModel {
        return self.characterListVM[index]
    }
}

//MARK: CharacterViewModel
struct CharacterViewModel {
    
    let characterResult: Result
}
