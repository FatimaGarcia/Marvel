//
//  MarvelDetailViewController.swift
//  Marvel
//
//  Created by Fatima Garcia on 14/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import UIKit
import Kingfisher

protocol MarvelDetailViewControllerProtocol: class {
    func loadData(_ character: CharacterDetailUIModel)
    func isLoading(_ loading: Bool)
    func isError(_ error: Bool)
}

class MarvelDetailViewController: UIViewController, NibLoadable {
    //MARK: MVP
    private var presenter: MarvelDetailPresenterProtocol!
    
    func configure(presenter: MarvelDetailPresenterProtocol) {
        self.presenter = presenter
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var info: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = UIConstants.detailTitle
        presenter.getCharacterDetail()
    }
    
    //MARK: Private Methods
    private func configureView(for character: CharacterDetailUIModel) {
        if let img = character.basicInfo.image, let url = URL(string: img) {
            image.kf.setImage(with: url)
        }
        name.text = character.basicInfo.name
        info.text = character.basicInfo.description
        configureMoreInfoView(comics: character.comicsName, series: character.seriesName, stories: character.storiesName)
        
    }
    
    private func configureMoreInfoView(comics:[String]?, series: [String]?, stories: [String]?) {
        let moreInfoView = MoreInfoView.instantiate()
        moreInfoView.configure(comics: comics, series: series, stories: stories)
        stackView.addArrangedSubview(moreInfoView)
    }
    
}

//MARK: Detail View ControllerProtocol
extension MarvelDetailViewController: MarvelDetailViewControllerProtocol {
    func loadData(_ character: CharacterDetailUIModel) {
        configureView(for: character)
    }
    
    func isLoading(_ loading: Bool) {
        loading ? showLoading() : hideLoading()
    }
    
    func isError(_ error: Bool) {
        error ? showError() : hideError()
    }
}
