//
//  NibLoadable.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import UIKit

protocol NibLoadable: class {
    static var nibName: String { get }
    static func instantiate() -> Self
}

//MARK: View Controller
extension NibLoadable where Self: UIViewController {
    static var nibName: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        return Self.init(nibName: nibName, bundle: nil)
    }
}

//MARK: UI View
extension NibLoadable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        return UINib(nibName: nibName, bundle: Bundle(for: Self.self))
            .instantiate(withOwner: nil, options: nil).first as! Self
    }
}
