//
//  BreweriesRepository.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/13.
//

import Foundation

enum BreweriesRepositoryProvider {
    static func provide() -> BreweriesRepository {
        return BreweriesRepositoryImpl(apiRemoteDataSource: ApiRemoteDataSourceProvider.provide())
    }
}

protocol BreweriesRepository {
    func fetch(state: String, page: Int) async throws -> [Brewery]
}

private struct BreweriesRepositoryImpl: BreweriesRepository {

    private let apiRemoteDataSource: ApiRemoteDataSource

    init(apiRemoteDataSource: ApiRemoteDataSource) {
        self.apiRemoteDataSource = apiRemoteDataSource
    }

    func fetch(state: String, page: Int) async throws -> [Brewery] {
        let breweriesRequest = BreweriesRequest(state: state, page: page)
        return try await apiRemoteDataSource.request(breweriesRequest)
    }
}
