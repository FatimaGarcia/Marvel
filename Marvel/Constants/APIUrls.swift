//
//  APIUrls.swift
//  Marvel
//
//  Created by Fatima Garcia on 14/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation

enum APIUrls {
    case list
    case detail(id: Int)
    
    var path: String {
        switch self {
        case .list:
            return "/v1/public/characters"
        case .detail(id: let id):
            return "/v1/public/characters/\(id)"
        }
    }
    
}
