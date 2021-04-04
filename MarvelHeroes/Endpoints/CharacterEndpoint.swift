//
//  CharacterEndpoint.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 03.04.2021.
//

import Foundation

public struct CharacterEndpoint: APIRequest {
    public typealias Response = [ComicCharacter]

    // Notice how we create a composed resourceName
    public var resourceName: String {
        return "characters/\(characterId)"
    }

    // Parameters
    private let characterId: Int

    public init(characterId: Int) {
        self.characterId = characterId
    }
}
