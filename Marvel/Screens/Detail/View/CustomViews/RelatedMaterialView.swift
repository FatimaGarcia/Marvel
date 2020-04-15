//
//  RelatedMaterialView.swift
//  Marvel
//
//  Created by Fatima Garcia on 14/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import UIKit

class RelatedMaterialView: UIView, NibLoadable {
    
    private var materialNames: [String] = []
    
    @IBOutlet weak var stackView: UIStackView!
    
    func configure(with names: [String]){
        materialNames = names
        configureStackView()
    }
    
    private func configureStackView() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        materialNames.forEach  { name in
            let nameLabel = UILabel()
            nameLabel.numberOfLines = 0
            nameLabel.font = UIFont(name: "Futura", size: 16)
            nameLabel.text = name
            stackView.addArrangedSubview(nameLabel)
        }
    }
}
