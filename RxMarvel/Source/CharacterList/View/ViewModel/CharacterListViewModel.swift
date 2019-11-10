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
    var filteredCharacters: [CharacterViewModel] = []

    init(_ characterList: [Result] = []) {
        self.characterListVM = characterList.compactMap(CharacterViewModel.init)
    }
    
    func characterAt(_ index: Int) -> CharacterViewModel {
        return self.characterListVM[index]
    }
    
    func filterBy(_ character: String) {
        filteredCharacters
        //let observable = Observable.just(characterListVM.filter { $0.characterResult.name.starts(with: character)})
        
    }
}

//MARK: CharacterViewModel
struct CharacterViewModel {
    
    let characterResult: Result
    var listOfImages: UIImage

    init(_ character: Result) {
        self.characterResult = character
        self.listOfImages = UIImage()
    }
    
    var characterName: Observable<String> {
        return Observable<String>.just(characterResult.name)
    }
    
    var image: Observable<UIImage> {
        return Observable<UIImage>.just(listOfImages)
    }
}
