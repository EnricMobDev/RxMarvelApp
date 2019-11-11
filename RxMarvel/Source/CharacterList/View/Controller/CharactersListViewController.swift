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
    var viewModel: CharacterListViewModel = CharacterListViewModel()
    
    private let disposeBag = DisposeBag()

    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: CharacterListTableViewCell.cellIdentifier(), bundle: nil),
                           forCellReuseIdentifier: CharacterListTableViewCell.cellIdentifier())
        tableView.delegate = nil
        tableView.backgroundView = loadingView()
        setupRxCells()
    }
    
    //MARK: Load Views
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
    
    private func showErrorView() {
        DispatchQueue.main.async {
            let errorServiceView = ErrorServiceViewController()
            errorServiceView.delegate = self
            self.present(errorServiceView, animated: true)
        }
    }
    
    func setupRxCells() {
        let url = settingsManager.apiURL
        let latestSearch = searchBar.rx.text.orEmpty
        let loadData = viewModel.fetchCharactersFrom(url: url).do(onError: { [weak self] (error) in
            
            guard let self = self else { return }
            switch error {
            case RxCocoaURLError.httpRequestFailed:
                self.showErrorView()
            default:
                self.showErrorView()
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
                                        
                                        cell.characterLabel.text = viewModel.characterResult.name
                                        //Bind with kingfisher
                                        let url = viewModel.characterResult.thumbnail.imageURL()
                                        cell.characterImage.kf.setImage(with: url)
        }
        .disposed(by: disposeBag)
        
        //Pass the character with the user interaction
        tableView.rx.modelSelected(CharacterViewModel.self)
            .subscribe(onNext: { value in                
                
                self.present(CharacterDetailViewController(character: value), animated: true)
        })
        .disposed(by: disposeBag)
    }
}

//MARK: UIScrollViewDelegate
extension CharactersListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

//MARK: ErrorServiceVCDelegate
extension CharactersListViewController: ErrorServiceVCDelegate {
    
    func retryButton() {
        self.viewDidLoad()
    }
}
