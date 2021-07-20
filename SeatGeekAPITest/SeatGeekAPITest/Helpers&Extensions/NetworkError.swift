//
//  NetworkError.swift
//  SeatGeekAPITest
//
//  Created by Colton Swapp on 7/16/21.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    case unauthorized
    
    var errorDescription: String? {
        switch self {
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        case .invalidURL:
            return "Unable to reach the server."
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "The server responded with bad data."
        case .unauthorized:
            return "Access denied. You are not authorized."
        }
    }
}//End of enum
