//
//  Assembler.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import UIKit

var assembler : Assembler {
    get {
        return Assembler.instance
    }
}

final class Assembler : NSObject {
    fileprivate static var instance = Assembler()
}

extension Assembler {
    func provideList() -> UIViewController {
        let controller = MarvelListViewController.instantiate()
        let presenter = MarvelListPresenter(view: controller)
        controller.configure(presenter: presenter)
        return controller
    }
    
    func provideDetail(characterId: Int) -> UIViewController {
         let controller = MarvelDetailViewController.instantiate()
        let presenter = MarvelDetailPresenter(view: controller, characterId: characterId)
         controller.configure(presenter: presenter)
         return controller
    }
}


