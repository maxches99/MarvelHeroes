//
//  MarvelError.swift
//  MarvelHeroes
//
//  Created by Max Chesnikov on 05.04.2021.
//

import Foundation

enum MarvelError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension MarvelError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Мы не смогли понять что вернул сервер"
        case .errorCode(let code):
            return "Код ошибки - \(code)"
        case .unknown:
            return "Мы не знаем что это"
        }
    }
}
