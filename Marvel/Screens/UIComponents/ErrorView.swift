//
//  ErrorView.swift
//  Marvel
//
//  Created by Fatima Garcia on 15/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    let image = UIImageView()
    let label = UILabel()
    
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
        backgroundView.backgroundColor = UIColor.marvelGray
        self.addSubview(backgroundView)
        
        image.frame = CGRect(x: (self.frame.width/2) - 50, y: (self.frame.height/2) - 200, width: 100, height: 100)
        image.image = UIImage(named: "warning")
        image.contentMode = .scaleAspectFit
        self.addSubview(image)
        
        label.frame = CGRect(x: (self.frame.width/2) - 125, y: image.frame.origin.y + image.frame.height + 32, width: 250, height: 50)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Futura", size: 25)
        label.text = UIConstants.errorTitle
        self.addSubview(label)
    }
}
