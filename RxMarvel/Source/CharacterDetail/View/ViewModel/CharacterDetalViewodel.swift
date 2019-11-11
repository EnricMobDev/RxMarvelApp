//
//  CharacterDetalViewodel.swift
//  RxMarvel
//
//  Created by Enric Pou Villanueva on 11/11/2019.
//  Copyright © 2019 Enric Pou Villanueva. All rights reserved.
//

import Foundation

class CharacterDetalViewModel {
    
    //MARK: Variables
    var characterDetailVM = CharacterModel(name: "", comics: "", series: "", stories: "", events: "")

    //MARK: Bind function
    func bind(character: CharacterViewModel) -> CharacterModel{
        characterDetailVM.name = character.characterResult.name
        characterDetailVM.comics = String(describing: character.characterResult.comics.available)
        characterDetailVM.comics = String(describing: character.characterResult.comics.available)
        characterDetailVM.series = String(describing: character.characterResult.series.available)
        characterDetailVM.stories = String(describing: character.characterResult.stories.available)
        characterDetailVM.events = String(describing: character.characterResult.events.available)

        return characterDetailVM
    }
}

struct CharacterModel {
    var name: String
    var comics: String
    var series: String
    var stories: String
    var events: String
}
