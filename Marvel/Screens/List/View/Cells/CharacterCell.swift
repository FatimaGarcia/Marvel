//
//  CharacterCell.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import UIKit
import Kingfisher

protocol CharacterCellDelegate: class {
    func didTapCell(_ cell: CharacterCell, for characterId: Int)
}

class CharacterCell: UITableViewCell, ReusableView {
    //MARK: Properties
    weak var delegate: CharacterCellDelegate?
    
    private var characterId: Int?
    
    //MARK: IB Outlets
    @IBOutlet weak var icon: UIImageView! {
        didSet{
            icon.layer.cornerRadius = 20
            icon.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var info: UILabel!{
        didSet{
            info.text = UIConstants.descriptionNotAvailables
        }
    }
    
    @IBOutlet weak var containerView: UIView! {
        didSet{
            containerView.layer.cornerRadius = 8
            containerView.layer.shadowColor = UIColor.gray.cgColor
            containerView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            containerView.layer.shadowRadius = 2
            containerView.layer.shadowOpacity = 0.8
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCell(gesture:)))
        addGestureRecognizer(gesture)
    }
    
    @objc private func didTapCell(gesture: UITapGestureRecognizer) {
        guard let id = characterId else { return }
        delegate?.didTapCell(self, for: id)
    }
    
    func configure(with model: CharacterUIModel) {
        characterId = model.id
        if let image = model.image, !image.isEmpty, let url = URL(string: image) {
            icon.kf.setImage(with: url)
        }
        if let character = model.name {
            name.text = character
        }
        if let description = model.description, !description.isEmpty {
            info.text = description
        }
    }
    
}
