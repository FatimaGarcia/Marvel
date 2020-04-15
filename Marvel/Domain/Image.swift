//
//  Image.swift
//  Marvel
//
//  Created by Fatima Garcia on 13/04/2020.
//  Copyright © 2020 Fatima Garcia. All rights reserved.
//

import Foundation

struct Image {
    let imagePath: String?
    let imageExtension: String?
    let imageUrl: String?
    
    init(imagePath: String?, imageExtension: String?) {
        self.imagePath = imagePath
        self.imageExtension = imageExtension
        self.imageUrl = "\(imagePath ?? "").\(imageExtension ?? "")"
    }
}

extension Image: Codable {
    fileprivate enum CodingKeys: String, CodingKey {
        case imagePath = "path"
        case imageExtension = "extension"
    }
       
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath)
        let imageExtension = try container.decodeIfPresent(String.self, forKey: .imageExtension)
        self.init(imagePath: imagePath, imageExtension: imageExtension)
    }
       
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(imagePath, forKey: .imagePath)
        try container.encodeIfPresent(imageExtension, forKey: .imageExtension)
    }
}

