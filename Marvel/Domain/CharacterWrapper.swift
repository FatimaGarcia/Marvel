//
//  CharacterWrapper.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation

struct CharacterWrapper {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHtml: String?
    let etag: String?
    let data: CharacterContainer?
        
    init(code: Int?, status: String?, copyright: String?, attributionText: String?, attributionHtml: String?, etag: String?, data: CharacterContainer?) {
        self.code = code
        self.status = status
        self.copyright = copyright
        self.attributionText = attributionText
        self.attributionHtml = attributionHtml
        self.etag = etag
        self.data = data
    }

}

extension CharacterWrapper: Codable {
    fileprivate enum CodingKeys: String, CodingKey {
        case code
        case status
        case copyright
        case attributionText
        case attributionHtml = "attributionHTML"
        case etag
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let code = try container.decodeIfPresent(Int.self, forKey: .code)
        let status = try container.decodeIfPresent(String.self, forKey: .status)
        let copyright = try container.decodeIfPresent(String.self, forKey: .copyright)
        let attributionText = try container.decodeIfPresent(String.self, forKey: .attributionText)
        let attributionHtml = try container.decodeIfPresent(String.self, forKey: .attributionHtml)
        let etag = try container.decodeIfPresent(String.self, forKey: .etag)
        let data = try container.decodeIfPresent(CharacterContainer.self, forKey: .data)
        self.init(code: code, status: status, copyright: copyright, attributionText: attributionText,
                  attributionHtml: attributionHtml, etag: etag, data: data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(copyright, forKey: .copyright)
        try container.encodeIfPresent(attributionText, forKey: .attributionText)
        try container.encodeIfPresent(attributionHtml, forKey: .attributionHtml)
        try container.encodeIfPresent(etag, forKey: .etag)
        try container.encodeIfPresent(data, forKey: .data)
    }
}


//MARK: UI Models
extension CharacterWrapper {
    func generateCharacterUIModel() -> [CharacterUIModel] {
        guard let characters = ( self.data?.results?.map{
            CharacterUIModel(id: $0.id, image: $0.thumbnail?.imageUrl, name: $0.name, description: $0.description) } ) else { return [] }
        return characters
    }
    
    func generateCharacterDetailUIModel(for id: Int) -> CharacterDetailUIModel? {
        guard let characterDetail = self.data?.results?.filter({ $0.id == id }).first else { return nil }
        let general = CharacterUIModel(id: characterDetail.id, image: characterDetail.thumbnail?.imageUrl, name: characterDetail.name, description: characterDetail.description)
        let comicsNames = characterDetail.comics?.items?.compactMap{ $0.name }
        let seriesNames = characterDetail.series?.items?.compactMap{ $0.name }
        let storiesNames = characterDetail.stories?.items?.compactMap{ $0.name }

        let detail = CharacterDetailUIModel(basicInfo: general, comicsName: comicsNames, seriesName: seriesNames, storiesName: storiesNames)
        return detail
    }
}
