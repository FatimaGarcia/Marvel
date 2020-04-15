//
//  UIViewControllerLoader.swift
//  Marvel
//
//  Created by Fatima Garcia on 14/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import UIKit

extension UIViewController {
    func showLoading() {
        let loader = LoaderView.init(frame: view.bounds)
        loader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loader)
      }
      
    func hideLoading() {
        view.subviews.filter { $0 is LoaderView }.forEach { $0.removeFromSuperview() }
    }
}
