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

class CharactersListViewController: UIViewController, UITableViewDelegate {
    
    //MARK: Variables
    var settingsManager: SettingsManagerProtocol = MarvelSettingsManager()
    var request: MarvelRequestProtocol = MarvelRequest()
    
    private let disposeBag = DisposeBag()
    private var charactersListVM: CharacterListViewModel = CharacterListViewModel()

    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchTextfield: UITextField!
    
    //MARK: Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: CharacterListTableViewCell.cellIdentifier(), bundle: nil),
                           forCellReuseIdentifier: CharacterListTableViewCell.cellIdentifier())
        
        tableView.delegate = self
        tableView.backgroundView = loadingView()
        setupRx()
    }
    
    private func loadingView() -> UIView {
        let view = UIView()
        let loader = UIActivityIndicatorView(style: .large)
        loader.startAnimating()
        view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        return view
    }
    
    private func errorView() -> UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    
    private func setupRx() {
        let url = settingsManager.apiURL
        let latestSearch = searchBar.rx.text.orEmpty
        let loadData = fetchCharactersFrom(url: url).do(onError: { (error) in
            switch error {
            case RxCocoaURLError.httpRequestFailed:
                break
            default:
                break
            }
            
            DispatchQueue.main.async {
                self.tableView.backgroundView = self.errorView()
            }
        }, onCompleted: {
            DispatchQueue.main.async {
                self.tableView.backgroundView = nil
            }
        }).catchErrorJustReturn([])
        
        
        // Binding to tableview
        Observable.combineLatest(loadData, latestSearch) { results, queryText in
            return results.filter { $0.characterResult.name.lowercased().hasPrefix(queryText.lowercased()) || queryText.isEmpty }
        }.bind(to: tableView.rx.items(cellIdentifier: CharacterListTableViewCell.cellIdentifier(),
                                         cellType: CharacterListTableViewCell.self)) {
                                            (index, viewModel: CharacterViewModel, cell) in
                                            let url = viewModel.characterResult.thumbnail.imageURL()
                                            cell.characterLabel.text = viewModel.characterResult.name
                                            //Bind with kingfisher
                                            cell.characterImage.kf.setImage(with: url)
        }
        .disposed(by: disposeBag)
    }

    //MARK: Fetch Characters
    
    func fetchCharactersFrom(url: String) -> Observable<[CharacterViewModel]> {
        guard let existUrl = URL(string: url) else { return .just([]) }
        let resource = Resource<MarvelAPI>(url: existUrl)
        
        return request.load(resource: resource).map({ (characterResponse) -> [CharacterViewModel] in
            let characters = characterResponse.data.results
            let viewModel = CharacterListViewModel.init(characters)
            return viewModel.characterListVM
        })
    }
}

extension CharactersListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}
