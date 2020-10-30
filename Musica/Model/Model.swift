//
//  Model.swift
//  Musica
//
//  Created by Ulvi Bashirov on 10/15/20.
//

import Foundation

struct Artist: Codable {
    var id: Int?
    var name: String?
    var link: String?
    var picture: String?
    var picture_small: String?
    var picture_medium: String?
    var picture_big: String?
    var picture_xl: String?
    var tracklist: String?
    var type: Types?
}

struct Album: Codable {
    var id: Int?
    var title: String?
    var cover: String?
    var cover_small: String?
    var cover_medium: String?
    var cover_big: String?
    var cover_xl: String?
    var md5_image: String?
    var tracklist: String?
    var type: Types?
}

struct Track: Codable {
    var id: Int?
    var readable: Bool?
    var title: String?
    var title_short: String?
    var title_version: String?
    var link: String?
    var duration: Int?
    var rank: Int?
    var explicit_lyrics: Bool?
    var explicit_content_lyrics: Int?
    var explicit_content_cover: Int?
    var preview: String?
    var md5_image: String?
    var artist: Artist?
    var album: Album?
    var type: Types?
    
}

struct Result: Codable {
    var data: [Track]?
}

enum Types: String, Codable {    
    case artist = "artist"
    case album = "album"
    case track = "track"
}

