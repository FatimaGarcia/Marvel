//
//  Colors.swift
//  Marvel
//
//  Created by Fatima Garcia on 14/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import UIKit

extension UIColor {
    public static var marvelGrey: UIColor {
        return UIColor(red: 209.0/255.0, green: 218.0/255.0, blue: 232.0/255.0, alpha: 1.0)
    }
    
    public static var marvelRed: UIColor {
        return UIColor(red: 171.0/255.0, green: 42.0/255.0, blue: 58.0/255.0, alpha: 1.0)
    }
    
    public static var transparentWhite: UIColor {
        return UIColor.white.withAlphaComponent(0.8)
    }
}
