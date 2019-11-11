//
//  CharacterDetailViewController.swift
//  RxMarvel
//
//  Created by Enric Pou Villanueva on 11/11/2019.
//  Copyright © 2019 Enric Pou Villanueva. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    //MARK: Variables
    private enum Constants {
        static let emptyCharacter = Result(name: "", thumbnail: Thumbnail(path: "", thumbnailExtension: .jpg), comics: Comics(available: 0), series: Comics(available: 0), stories: Stories(available: 0), events: Comics(available: 0))
    }
    
    var characterVM: CharacterViewModel
    
    //MARK: IBOutlets
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var numberOfComicsLabel: UILabel!
    @IBOutlet weak var numberOfSeriesLabel: UILabel!
    @IBOutlet weak var numberOfStoriesLabel: UILabel!
    @IBOutlet weak var numberOfEventsLabel: UILabel!
    
    //MARK: Lyfecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCharacterDetailView()
    }

    init(character: CharacterViewModel){
        self.characterVM = character
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder decoder: NSCoder) {
        self.characterVM = CharacterViewModel(characterResult: Constants.emptyCharacter)
        super.init(coder: decoder)
    }
    
    //MARK: Setup View
    private func setupCharacterDetailView() {
        
        let characterDetailVM = CharacterDetalViewModel()

        let character = characterDetailVM.bind(character: characterVM)
        characterName.text = character.name
        numberOfComicsLabel.text = character.comics
        numberOfSeriesLabel.text = character.series
        numberOfStoriesLabel.text = character.stories
        numberOfEventsLabel.text = character.events
    }
}
