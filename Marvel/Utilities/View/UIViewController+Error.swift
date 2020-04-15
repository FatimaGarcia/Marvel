//
//  UIViewController+Error.swift
//  Marvel
//
//  Created by Fatima Garcia on 15/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError() {
        let error = ErrorView.init(frame: view.bounds)
        error.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(error)
    }
    
    func hideError() {
        view.subviews.filter { $0 is ErrorView }.forEach { $0.removeFromSuperview() }
    }
}
