//
//  APIRequest.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 03.04.2021.
//

import Foundation

public protocol APIRequest: Encodable {
    /// Response (will be wrapped with a DataContainer)
    associatedtype Response: Decodable

    /// Endpoint for this request (the last part of the URL)
    var resourceName: String { get }
}
