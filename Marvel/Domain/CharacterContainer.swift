//
//  MaverCharacterContainer.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation

struct CharacterContainer {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Character]?
    
    init(offset: Int?, limit: Int?, total: Int?, count: Int?, results: [Character]?) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }
}

extension CharacterContainer: Codable {
    fileprivate enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let offset = try container.decodeIfPresent(Int.self, forKey: .offset)
        let limit = try container.decodeIfPresent(Int.self, forKey: .limit)
        let total = try container.decodeIfPresent(Int.self, forKey: .total)
        let count = try container.decodeIfPresent(Int.self, forKey: .count)
        let results = try container.decodeIfPresent([Character].self, forKey: .results)
        self.init(offset: offset, limit: limit, total: total, count: count, results: results)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(offset, forKey: .offset)
        try container.encodeIfPresent(limit, forKey: .limit)
        try container.encodeIfPresent(total, forKey: .total)
        try container.encodeIfPresent(count, forKey: .count)
        try container.encodeIfPresent(results, forKey: .results)
    }
}
