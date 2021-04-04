//
//  ComicCharacter.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 03.04.2021.
//

import Foundation

public struct ComicCharacter: Decodable {
    let id: Int
    let name: String?
    let description: String?
    let thumbnail: Image?
    let comics, series: Comics?
    let events: Comics?
}
