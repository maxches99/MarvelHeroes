//
//  DataContainer.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 03.04.2021.
//

import Foundation

public struct DataContainer<Results: Decodable>: Decodable {
    public let offset: Int
    public let limit: Int
    public let total: Int
    public let count: Int
    public let results: Results
}
