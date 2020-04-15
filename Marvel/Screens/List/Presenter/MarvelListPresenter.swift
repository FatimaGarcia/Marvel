//
//  MarvelListPresenter.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation

protocol MarvelListPresenterProtocol: class {
    func getCharacterList()
    func numberOfItems() -> Int
    func getReuseId(for indexPath: IndexPath) -> String
    func model(for indexPath: IndexPath) -> CharacterUIModel
    func filterContentForSearchText(_ searchText: String)
}

final class MarvelListPresenter {
    //MARK : MVP
    weak var view: MarvelListViewControllerProtocol?
    
    init(view: MarvelListViewControllerProtocol) {
        self.view = view
    }
    
    //MARK: Properties
    private var offset = 0
    private let limit = 5
    private var total: Int = 0{
        didSet {
            showLoadMore = offset < total ? true : false
        }
    }
    private var showLoadMore = true
    
    private var charactersInfo: [CharacterUIModel] = []
    private var filteredCharactersInfo: [CharacterUIModel] = []
    
    private var isFiltering: Bool {
        return filteredCharactersInfo.count > 0
    }
    
    //MARK: Private Methods
    private func requestCharactersList() {
        offset += (offset + limit <= total) ? limit : (total - offset)
        let listRequest = ListRequest(limit: self.limit, offset: self.offset)
        listRequest.performRequest { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let model):
                self.total = model.data?.total ?? 0
                self.charactersInfo.append(contentsOf: model.generateCharacterUIModel())
                self.view?.reloadData()
                self.view?.isLoading(false)
            case .failure(_):
                self.view?.isError(true)
                self.view?.isLoading(false)
            }
        }
    }
}

//MARK: MarvelList Protocol
extension MarvelListPresenter: MarvelListPresenterProtocol {
    func getCharacterList() {
        self.view?.isLoading(true)
        requestCharactersList()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredCharactersInfo = charactersInfo.filter {
            $0.name?.lowercased().contains(searchText.lowercased()) ?? false
        }
        self.view?.reloadData()
    }
    
    func numberOfItems() -> Int {
        let loadMore = showLoadMore ? 1 : 0
        let characters = isFiltering ? filteredCharactersInfo.count : charactersInfo.count + loadMore
        return characters
    }
    
    func getReuseId(for indexPath: IndexPath) -> String {
        var reuseId = CharacterCell.reuseId
        let count = isFiltering ? filteredCharactersInfo.count : charactersInfo.count
        if indexPath.row >= count {
            reuseId = LoadMoreCell.reuseId
        }
        return reuseId
    }
    
    func model(for indexPath: IndexPath) -> CharacterUIModel {
        let character = isFiltering ? filteredCharactersInfo[indexPath.row] : charactersInfo[indexPath.row]
        return character
    }
}
