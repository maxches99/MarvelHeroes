//
//  APIErrors.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 03.04.2021.
//

import Foundation

enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Мы не смогли понять какую хуйню вернул сервак"
        case .errorCode(let code):
            return "Код - \(code) - хуевый"
        case .unknown:
            return "Биржа - хуиржа"
        }
    }
}

public enum MarvelError: Error {
    case encoding
    case decoding
    case server(message: String)
}