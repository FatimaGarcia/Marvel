//
//  ReusableView.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var reuseId: String { get }
}

extension ReusableView where Self: UIView {
    static var reuseId: String {
        return String(describing: self)
    }
}
