//
//  CharactersListViewController.swift
//  RxMarvel
//
//  Created by Enric Pou Villanueva on 05/11/2019.
//  Copyright © 2019 Enric Pou Villanueva. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class CharactersListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Variables
    private let settingsManager: SettingsManagerProtocol = MarvelSettingsManager()
    private let disposeBag = DisposeBag()
    private var charactersListVM: CharacterListViewModel = CharacterListViewModel()
    
    // MARK: Add the behaviorRelay to create a varibale for use in this table
    private var characters = BehaviorRelay<String>(value: "")
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextfield: UITextField!
    
    //MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: CharacterListTableViewCell.cellIdentifier(), bundle: nil),
                           forCellReuseIdentifier: CharacterListTableViewCell.cellIdentifier())
        
        tableView.delegate = self
        tableView.dataSource = nil
        
        setupRx()
    }
    
    private func setupRx() {
        let url = settingsManager.apiURL
        let latestSearch = searchTextfield.rx.text.orEmpty
        let loadData = fetchCharactersFrom(url: url)
        
        
        // Binding to tableview
        Observable.combineLatest(loadData, latestSearch) { results, queryText in
            return results.filter { $0.characterResult.name.starts(with: queryText) || queryText.isEmpty }
        }.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: CharacterListTableViewCell.cellIdentifier(),
                                         cellType: CharacterListTableViewCell.self)) {
                                            (index, viewModel: CharacterViewModel, cell) in
                                            let url = URL(string: viewModel.characterResult.thumbnail.imageURL())!
                                            cell.characterLabel.text = viewModel.characterResult.name
                                            cell.characterImage.kf.setImage(with: url)
                                            cell.setNeedsLayout()
        }
        .disposed(by: disposeBag)
        
        
//        Observable.combineLatest(loadData, latestSearch) { results, queryText in
//            return results.filter { $0.characterResult.name.starts(with: queryText) || queryText.isEmpty }
//        }.subscribe(onNext: { (viewModels) in
//            self.charactersListVM.characterListVM = viewModels
//            self.updateTableView()
//        }).disposed(by: disposeBag)
    }
    
    //MARK: Reload Table
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //MARK: Fetch Characters
    
    func fetchCharactersFrom(url: String) -> Observable<[CharacterViewModel]> {
        guard let existUrl = URL(string: url) else { return .just([]) }
        let resource = Resource<MarvelAPI>(url: existUrl)
        
        return URLRequest.load(resource: resource).map({ (characterResponse) -> [CharacterViewModel] in
            let characters = characterResponse.data.results
            let viewModel = CharacterListViewModel.init(characters)
            return viewModel.characterListVM
        })
    }
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersListVM.characterListVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListTableViewCell.cellIdentifier(),for: indexPath) as? CharacterListTableViewCell else {
            assertionFailure("CharacterListTableViewCell is not found")
            return UITableViewCell()
        }
        
        let characterVM = charactersListVM.characterAt(indexPath.row)
//        characterVM.listOfImages = cell.imageView?.kf.setImage(with: url)
        
        characterVM.characterName.asDriver(onErrorJustReturn: "")
            .drive(cell.characterLabel.rx.text)
            .disposed(by: disposeBag)
        
//        characterVM.listOfImages.asDriver(onErrorJustReturn: UIImage())
//            .drive(cell.characterImage.rx.image)
//            .disposed(by: disposeBag)
        
        
//        cell.drawCornerRadius()
//        cell.addBorder()
        return cell
    }
}

