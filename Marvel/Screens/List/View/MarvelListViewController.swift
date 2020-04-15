//
//  MarvelListViewController.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import UIKit

protocol MarvelListViewControllerProtocol: class {
    func reloadData()
    func isLoading(_ loading: Bool)
    func isError(_ error: Bool)
}

class MarvelListViewController: UIViewController, NibLoadable {
    //MARK: MVP
    private var presenter: MarvelListPresenterProtocol!
    
    private var searchController: UISearchController? {
        didSet{
            searchController?.searchResultsUpdater = self
            searchController?.obscuresBackgroundDuringPresentation = false
            searchController?.searchBar.placeholder = UIConstants.search
            navigationItem.searchController = searchController
            definesPresentationContext = true
        }
    }
    
    func configure(presenter: MarvelListPresenterProtocol) {
        self.presenter = presenter
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
            
            tableView.estimatedRowHeight = 200
            tableView.rowHeight = UITableView.automaticDimension
            tableView.separatorStyle = .none
            
            let cell = UINib(nibName: CharacterCell.reuseId, bundle: nil)
            tableView.register(cell, forCellReuseIdentifier: CharacterCell.reuseId)
            
            let loadMore = UINib(nibName: LoadMoreCell.reuseId, bundle: nil)
            tableView.register(loadMore, forCellReuseIdentifier: LoadMoreCell.reuseId)
        }
    }
    
    @IBOutlet weak var errorContainer: UIView!{
        didSet{
            errorContainer.isHidden = true
        }
    }
    
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = UIConstants.listTitle
        searchController = UISearchController(searchResultsController: nil)
        presenter.getCharacterList()
    }
    
    private func navigateToCharacterDetail(with id: Int) {
        let detail = assembler.provideDetail(characterId: id)
        navigationController?.pushViewController(detail, animated: true)
    }
    
}

//MARK: Marvel List View Controller Protocol
extension MarvelListViewController: MarvelListViewControllerProtocol {
    func reloadData() {
        tableView.reloadData()
    }
    
    func isLoading(_ loading: Bool) {
        loading ? showLoading() : hideLoading()
    }
    
    func isError(_ error: Bool) {
        error ? showError() : hideError()
    }
    
}

//MARK: UISearch Delegate
extension MarvelListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            presenter.filterContentForSearchText(text)
        }
    }
}

//MARK: Table View Delegate, Data Source
extension MarvelListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: presenter.getReuseId(for: indexPath), for: indexPath)
        cell.selectionStyle = .none
        if let cell = cell as? CharacterCell {
            let model = presenter.model(for: indexPath)
            cell.configure(with: model)
            cell.delegate = self
        }
        if let cell = cell as? LoadMoreCell {
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: CharacterCell Delegate
extension MarvelListViewController: CharacterCellDelegate {
    func didTapCell(_ cell: CharacterCell, for characterId: Int) {
        navigateToCharacterDetail(with: characterId)
    }
}

//MARK: Load More Cell
extension MarvelListViewController: LoadMoreCellDelegate {
    func didTapLoadMore(_ sender: UIButton) {
        presenter.getCharacterList()
    }
}

