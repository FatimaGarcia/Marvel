//
//  Colors.swift
//  Marvel
//
//  Created by Fatima Garcia on 14/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import UIKit

extension UIColor {
    public static var marvelGray: UIColor {
      if let color = UIColor(named: "marvelGray") {
          return color
      }
      fatalError("Could not find marvelGray color")
    }
    
    public static var marvelBackRed: UIColor {
      if let color = UIColor(named: "marvelBackRed") {
          return color
      }
      fatalError("Could not find marvelBackRed color")
    }
    
    public static var marvelRed: UIColor {
      if let color = UIColor(named: "marvelRed") {
          return color
      }
      fatalError("Could not find marvelRed color")
    }
    
    public static var transparentWhite: UIColor {
        return UIColor.white.withAlphaComponent(0.8)
    }
}
