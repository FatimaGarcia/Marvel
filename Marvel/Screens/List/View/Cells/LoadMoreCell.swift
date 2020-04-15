//
//  LoadMoreCell.swift
//  Marvel
//
//  Created by Fatima Garcia on 15/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import UIKit

protocol LoadMoreCellDelegate: class {
    func didTapLoadMore(_ sender: UIButton)
}

class LoadMoreCell: UITableViewCell, ReusableView {
    weak var delegate: LoadMoreCellDelegate?
    
    @IBAction func didTapLoadMore(_ sender: UIButton) {
        delegate?.didTapLoadMore(sender)
    }
}

