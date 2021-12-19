//
//  ApiRemoteDataSource.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/13.
//

import Foundation

enum ApiRemoteDataSourceProvider {
    static func provide() -> ApiRemoteDataSource {
        ApiRemoteDataSourceImpl(session: URLSession.shared)
    }
}

protocol ApiRemoteDataSource {
    func request<T: GetRequest>(_ request: T) async throws -> T.Response
}

private struct ApiRemoteDataSourceImpl: ApiRemoteDataSource {

    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func request<T: GetRequest>(_ request: T) async throws -> T.Response {
        guard let urlRequest = request.buildURLRequest() else {
            throw ApiError.invalidRequest
        }
        do {
            let result = try await session.data(for: urlRequest)
            let data = try validate(result: result)
#if DEBUG
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) {
                print("Response JSON\n\(jsonObject)")
            }
#endif
            return try request.decodeFrom(data: data)
        } catch let apiError as ApiError {
            throw apiError
        } catch let decodingError as DecodingError {
            throw ApiError.decodingFailed(decodingError)
        } catch let urlError as URLError {
            switch urlError.code {
            case .timedOut,
                    .cannotFindHost,
                    .cannotConnectToHost,
                    .networkConnectionLost,
                    .dnsLookupFailed,
                    .httpTooManyRedirects,
                    .resourceUnavailable,
                    .notConnectedToInternet,
                    .secureConnectionFailed,
                    .cannotLoadFromNetwork:
                throw ApiError.cannotConnected
            default:
                throw ApiError.unexpected(urlError)
            }
        } catch {
            throw ApiError.unexpected(error)
        }
    }

    private func validate(result: (Data, URLResponse)) throws -> Data {
        guard let statusCode = (result.1 as? HTTPURLResponse)?.statusCode else {
            throw ApiError.cannotConnected
        }
        let successRange = 200..<300
        guard successRange.contains(statusCode) else {
            throw ApiError.hasError(statusCode: statusCode)
        }
        return result.0
    }
}
