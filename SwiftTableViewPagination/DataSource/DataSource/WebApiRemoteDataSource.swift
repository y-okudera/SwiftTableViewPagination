//
//  WebApiRemoteDataSource.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/13.
//

import Foundation

enum WebApiRemoteDataSourceProvider {
    static func provide() -> WebApiRemoteDataSource {
        WebApiRemoteDataSourceImpl(session: URLSession.shared)
    }
}

protocol WebApiRemoteDataSource {
    func httpGet<T: GetRequest>(for request: T) async throws -> T.Response
}

private final class WebApiRemoteDataSourceImpl: WebApiRemoteDataSource {

    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func httpGet<T: GetRequest>(for request: T) async throws -> T.Response {
        guard let urlRequest = request.buildURLRequest() else {
            throw WebApiError.invalidRequest
        }
        let result = try await session.data(for: urlRequest)
        do {
            let data = try validate(result: result)

            #if DEBUG
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []){
                print("Response JSON\n\(jsonObject)")
            }
            #endif

            return try request.decode(from: data)
        } catch let webApiError as WebApiError {
            throw webApiError
        } catch let decodingError as DecodingError {
            throw WebApiError.decodingFailed(decodingError)
        } catch {
            throw WebApiError.unexpected(error)
        }
    }

    private func validate(result: (Data, URLResponse)) throws -> Data {
        guard let statusCode = (result.1 as? HTTPURLResponse)?.statusCode else {
            throw WebApiError.network
        }
        let successRange = 200..<300
        guard successRange.contains(statusCode) else {
            throw WebApiError.hasError(statusCode: statusCode)
        }
        return result.0
    }
}
