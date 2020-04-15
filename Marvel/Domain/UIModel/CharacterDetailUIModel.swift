//
//  CharacterDetailUIModel.swift
//  Marvel
//
//  Created by Fatima Garcia on 14/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation

struct CharacterDetailUIModel {
    let basicInfo: CharacterUIModel
    let comicsName: [String]?
    let seriesName: [String]?
    let storiesName: [String]?
    
    init(basicInfo: CharacterUIModel, comicsName: [String]?, seriesName: [String]?, storiesName: [String]?) {
        self.basicInfo = basicInfo
        self.comicsName = comicsName
        self.seriesName = seriesName
        self.storiesName = storiesName
    }
}
