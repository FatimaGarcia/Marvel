//
//  Character.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation

struct Character {
    let id: Int?
    let name: String?
    let description: String?
    let modified: String?
    let resourceUri: String?
    let urls: [Url]?
    let thumbnail: Image?
    let comics: InfoList?
    let stories: InfoList?
    let events: InfoList?
    let series: InfoList?
    
    init(id: Int?, name: String?, description: String?, modified: String?, resourceUri: String?, urls: [Url]?, thumbnail: Image?, comics: InfoList?, stories: InfoList?, events: InfoList?, series: InfoList?) {
        self.id = id
        self.name = name
        self.description = description
        self.modified = modified
        self.resourceUri = resourceUri
        self.urls = urls
        self.thumbnail = thumbnail
        self.comics = comics
        self.stories = stories
        self.events = events
        self.series = series
    }
}

extension Character: Codable {
    fileprivate enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case modified
        case resourceUri = "resourceURI"
        case urls
        case thumbnail
        case comics
        case stories
        case events
        case series
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decodeIfPresent(Int.self, forKey: .id)
        let name = try container.decodeIfPresent(String.self, forKey: .name)
        let description = try container.decodeIfPresent(String.self, forKey: .description)
        let modified = try container.decodeIfPresent(String.self, forKey: .modified)
        let resourceUri = try container.decodeIfPresent(String.self, forKey: .resourceUri)
        let urls = try container.decodeIfPresent([Url].self, forKey: .urls)
        let thumbnail = try container.decodeIfPresent(Image.self, forKey: .thumbnail)
        let comics = try container.decodeIfPresent(InfoList.self, forKey: .comics)
        let stories = try container.decodeIfPresent(InfoList.self, forKey: .stories)
        let events = try container.decodeIfPresent(InfoList.self, forKey: .events)
        let series = try container.decodeIfPresent(InfoList.self, forKey: .series)
        self.init(id: id, name: name, description: description, modified: modified, resourceUri: resourceUri, urls: urls,
            thumbnail: thumbnail, comics: comics, stories: stories, events: events, series: series)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(modified, forKey: .modified)
        try container.encodeIfPresent(resourceUri, forKey: .resourceUri)
        try container.encodeIfPresent(urls, forKey: .urls)
        try container.encodeIfPresent(thumbnail, forKey: .thumbnail)
        try container.encodeIfPresent(comics, forKey: .comics)
        try container.encodeIfPresent(stories, forKey: .stories)
        try container.encodeIfPresent(events, forKey: .events)
        try container.encodeIfPresent(series, forKey: .series)
    }
}
