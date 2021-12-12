//
//  GetRequest.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/13.
//

import Foundation

protocol GetRequest {
    associatedtype Response: Decodable

    var method: String { get }
    var baseURL: URL { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var timeoutInterval: TimeInterval { get }
    var allowsCellularAccess: Bool { get }
    var cachePolicy: URLRequest.CachePolicy { get }

    func buildURLRequest() -> URLRequest?
    func decode(from data: Data) throws -> Response
}

extension GetRequest {

    var method: String {
        return "GET"
    }

    var baseURL: URL {
        return URL(string: "https://api.openbrewerydb.org")! // Endpoint
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json; charset=utf-8",
        ]
    }

    var queryItems: [URLQueryItem]? {
        return nil
    }

    var timeoutInterval: TimeInterval {
        return 30
    }

    var allowsCellularAccess: Bool {
        return true
    }

    var cachePolicy: URLRequest.CachePolicy {
        return .useProtocolCachePolicy
    }

    func buildURLRequest() -> URLRequest? {
        var compnents = URLComponents.init(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        compnents?.queryItems = queryItems
        guard let url = compnents?.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = timeoutInterval
        urlRequest.allowsCellularAccess = allowsCellularAccess
        urlRequest.cachePolicy = cachePolicy
        return urlRequest
    }

    func decode(from data: Data) throws -> Response {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Response.self, from: data)
    }
}

