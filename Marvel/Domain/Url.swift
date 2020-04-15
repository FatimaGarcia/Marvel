//
//  Url.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation

struct Url {
    let type: String?
    let url: String?
    
    init(type: String?, url: String?) {
        self.type = type
        self.url = url
    }
}

extension Url: Codable {
    fileprivate enum CodingKeys: String, CodingKey {
        case type
        case url
    }
       
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decodeIfPresent(String.self, forKey: .type)
        let url = try container.decodeIfPresent(String.self, forKey: .url)
        self.init(type: type, url: url)
    }
       
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(url, forKey: .url)
    }
}

