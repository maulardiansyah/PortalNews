//
//  AlbumPhoto.swift
//  PortalNews
//
//  Created by Maul on 24/02/22.
//

import Foundation

struct Album: Codable {
    let userId, id: Int?
    let title: String?
}

struct Photo: Codable {
    let albumId, id: Int?
    let title: String?
    let url, thumbnailUrl: String?
}
