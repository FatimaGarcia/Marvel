//
//  LoaderView.swift
//  Marvel
//
//  Created by Fatima Garcia on 14/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import UIKit

class LoaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    private func configureView() {
        self.backgroundColor = .clear
        
        let backgroundView = UIView(frame: self.frame)
        backgroundView.backgroundColor = UIColor.transparentWhite
        self.addSubview(backgroundView)
        
        let indicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        indicator.startAnimating()
        indicator.center = self.center
        self.addSubview(indicator)
    }
}


