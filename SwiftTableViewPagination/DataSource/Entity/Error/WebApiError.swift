//
//  WebApiError.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/13.
//

import Foundation

enum WebApiError: Error {
    case invalidRequest
    case network
    case hasError(statusCode: Int)
    case decodingFailed(DecodingError)
    case unexpected(Error)
}
