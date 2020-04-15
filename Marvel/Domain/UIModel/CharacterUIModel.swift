//
//  CharacterUIModel.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation

struct CharacterUIModel {
    let id: Int?
    let image: String?
    let name: String?
    let description: String?
    
    init(id: Int?, image: String?, name: String?, description: String?) {
        self.id = id
        self.image = image
        self.name = name
        self.description = description
    }
}
