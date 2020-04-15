//
//  ListRequest.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation

struct ListRequest: BaseRequest {
    var limit: Int = 100
    var offset: Int = 0
    
    init(limit: Int? = nil, offset: Int? = nil) {
        if let limit = limit {
            self.limit = limit
        }
        if let offset = offset {
            self.offset = offset
        }
    }
    
    typealias Response = CharacterWrapper
    
    var path: String { return APIUrls.list.path }
    
    var httpMethod: HTTPMethod { return .GET }
    
    var parameters: Parameters {
        return ["apikey": NetworkConstants.publicKey,
        "hash" : "cc6f78a7afa0a6152c4cccba05c464f9",
        "ts": "1586810619.94981",
        "limit" : "\(limit)",
        "offset" : "\(offset)"]
    }
}
