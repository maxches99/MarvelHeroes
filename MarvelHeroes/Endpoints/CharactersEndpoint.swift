//
//  CharactersEndpoint.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 03.04.2021.
//

import Foundation

public struct CharactersEndpoint: APIRequest {
    public typealias Response = [ComicCharacter]

    public var resourceName: String {
        return "characters"
    }

    // Parameters
    public let name: String?
    public let nameStartsWith: String?
    public var limit: Int
    public var offset: Int

    // Note that nil parameters will not be used
    public init(name: String? = nil,
                nameStartsWith: String? = nil,
                limit: Int = 20,
                offset: Int = 0) {
        self.name = name
        self.nameStartsWith = nameStartsWith
        self.limit = limit
        self.offset = offset
    }
}
