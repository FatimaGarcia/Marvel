//
//  MarvelDetailPresenter.swift
//  Marvel
//
//  Created by Fatima Garcia on 14/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation

protocol MarvelDetailPresenterProtocol: class {
    func getCharacterDetail()
}

final class MarvelDetailPresenter {
    //MARK: MVP
    weak var view: MarvelDetailViewControllerProtocol?
    
    //MARK: Properties
    private var characterId: Int
    
    private var characterInfo: CharacterDetailUIModel?
    
    //MARK: Initializers
    init(view: MarvelDetailViewControllerProtocol, characterId: Int) {
        self.view = view
        self.characterId = characterId
    }
    
    //MARK: Private Methods
    private func requestCharacterDetail() {
        let detailRequest = DetailRequest(characterId: characterId)
        detailRequest.performRequest { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let model):
                self.characterInfo = model.generateCharacterDetailUIModel(for: self.characterId)
                if let character = self.characterInfo {
                    self.view?.loadData(character)
                    self.view?.isLoading(false)
                }
            case .failure(_):
                self.view?.isError(true)
                self.view?.isLoading(false)
            }
        }
    }
}
//MARK: Marvel Detail Presenter Protocol
extension MarvelDetailPresenter : MarvelDetailPresenterProtocol {
    func getCharacterDetail() {
        self.view?.isLoading(true)
        requestCharacterDetail()
    }
}
