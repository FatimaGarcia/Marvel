//
//  DetailRequest.swift
//  Marvel
//
//  Created by Fatima Garcia on 14/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation

struct DetailRequest: BaseRequest {
    let characterId: Int
    
    init(characterId: Int) {
        self.characterId = characterId
    }
    
    typealias Response = CharacterWrapper
    
    var path: String { return APIUrls.detail(id: characterId).path }
    
    var httpMethod: HTTPMethod { return .GET }
}
