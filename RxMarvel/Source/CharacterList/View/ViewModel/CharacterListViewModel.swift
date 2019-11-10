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
    
    //MARK: Fetch Characters
    func fetchCharactersFrom(url: String) -> Observable<[CharacterViewModel]> {
        let request: MarvelRequestProtocol = MarvelRequest()

        guard let existUrl = URL(string: url) else { return .just([]) }
        let resource = Resource<MarvelAPI>(url: existUrl)
        
        return request.load(resource: resource).map({ (characterResponse) -> [CharacterViewModel] in
            let characters = characterResponse.data.results
            let viewModel = CharacterListViewModel.init(characters)
            return viewModel.characterListVM
        })
    }
}

//MARK: CharacterViewModel
struct CharacterViewModel {
    
    let characterResult: Result
}
