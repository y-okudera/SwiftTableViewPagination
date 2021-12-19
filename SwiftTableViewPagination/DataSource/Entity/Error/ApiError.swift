//
//  ApiError.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/13.
//

import Foundation

enum ApiError: Error {
    case invalidRequest
    case cannotConnected
    case hasError(statusCode: Int)
    case decodingFailed(DecodingError)
    case unexpected(Error)
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
