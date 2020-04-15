//
//  Summary.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation

struct Summary {
    let name: String?
    let resourceUri: String?
    let type: String?
    
    init(name: String?, resourceUri: String?, type: String?) {
        self.name = name
        self.resourceUri = resourceUri
        self.type = type
    }
}

extension Summary: Codable {
    fileprivate enum CodingKeys: String, CodingKey {
        case name
        case resourceUri = "resourceURI"
        case type
    }
       
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decodeIfPresent(String.self, forKey: .name)
        let resourceUri = try container.decodeIfPresent(String.self, forKey: .resourceUri)
        let type = try container.decodeIfPresent(String.self, forKey: .type)
        self.init(name: name, resourceUri: resourceUri, type: type)
    }
       
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(resourceUri, forKey: .resourceUri)
        try container.encodeIfPresent(type, forKey: .type)
    }
}
