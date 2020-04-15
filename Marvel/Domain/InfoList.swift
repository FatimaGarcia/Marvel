//
//  InfoList.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation

struct InfoList {
    let available: Int?
    let returned: Int?
    let collectionUri: String?
    let items: [Summary]?
    
    init(available: Int?, returned: Int?, collectionUri: String?, items: [Summary]?) {
        self.available = available
        self.returned = returned
        self.collectionUri = collectionUri
        self.items = items
    }
}

extension InfoList: Codable {
    fileprivate enum CodingKeys: String, CodingKey {
        case available
        case returned
        case collectionUri = "collectionURI"
        case items
    }
       
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let available = try container.decodeIfPresent(Int.self, forKey: .available)
        let returned = try container.decodeIfPresent(Int.self, forKey: .returned)
        let collectionUri = try container.decodeIfPresent(String.self, forKey: .collectionUri)
        let items = try container.decodeIfPresent([Summary].self, forKey: .items)
        self.init(available: available, returned: returned, collectionUri: collectionUri,
                  items: items)
    }
       
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(available, forKey: .available)
        try container.encodeIfPresent(returned, forKey: .returned)
        try container.encodeIfPresent(collectionUri, forKey: .collectionUri)
        try container.encodeIfPresent(items, forKey: .items)
    }
}
