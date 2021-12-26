//
//  ApiError.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/13.
//

import Foundation

enum ApiError: Error, Equatable {
    case invalidRequest
    case cannotConnected
    case hasError(statusCode: Int)
    case decodingFailed(DecodingError)
    case unexpected(Error)

    static func == (lhs: ApiError, rhs: ApiError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidRequest, invalidRequest):
            return true
        case (.cannotConnected, cannotConnected):
            return true
        case (.hasError(statusCode: let lStatusCode), hasError(statusCode: let rStatusCode)):
            return lStatusCode == rStatusCode
        case (.decodingFailed(let lError), decodingFailed(let rError)):
            return lError.localizedDescription == rError.localizedDescription
        case (.unexpected(let lError), unexpected(let rError)):
            return lError.localizedDescription == rError.localizedDescription
        default:
            return false
        }
    }
}

// MARK: - CustomNSError
extension ApiError: CustomNSError {
    /// The domain of the error.
    static var errorDomain: String {
        return "jp.yuoku.SwiftTableViewPagination.ApiError"
    }

    /// The error code within the given domain.
    var errorCode: Int {
        switch self {
        case .invalidRequest:
            return 0
        case .cannotConnected:
            return 1
        case .hasError:
            return 2
        case .decodingFailed:
            return 3
        case .unexpected:
            return 4
        }
    }

    /// The user-info dictionary.
    var errorUserInfo: [String: Any] {
        switch self {
        case .hasError(statusCode: let statusCode):
            return ["statusCode": statusCode]
        case .decodingFailed(let decodingError):
            return (decodingError as NSError).userInfo
        default:
            return [:]
        }
    }
}
