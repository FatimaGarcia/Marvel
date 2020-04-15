//
//  MoreInfoHeader.swift
//  Marvel
//
//  Created by Fatima Garcia on 14/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import UIKit

protocol MoreInfoHeaderDelegate: class {
    func toggleSection(header: MoreInfoHeader, section: Int)
}

class MoreInfoHeader: UIView, NibLoadable {
    var section: Int = 0
    
    var isCollapsed: Bool = true {
        willSet{
            guard isCollapsed != newValue else { return }
            icon.image = newValue ? UIImage(systemName: "chevron.down")?.withTintColor(.red) : UIImage(systemName: "chevron.up")?.withTintColor(.red)
        }
    }
    
    weak var delegate: MoreInfoHeaderDelegate?
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var containerView: UIView!{
        didSet{
            containerView.layer.cornerRadius = containerView.frame.size.height/2
        }
    }
    
    @IBOutlet weak var info: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapHeader(gesture:)))
        addGestureRecognizer(gesture)
    }
    
    @objc private func didTapHeader(gesture: UITapGestureRecognizer) {
        delegate?.toggleSection(header: self, section: section)
    }
    
    func configure(title: String, info: String, section: Int, isCollapsed: Bool) {
        self.title.text = title
        self.info.text = info
        self.section = section
        self.isCollapsed = isCollapsed
    }
}
