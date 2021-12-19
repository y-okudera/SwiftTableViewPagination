//
//  BreweriesRepository.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/13.
//

import Foundation

protocol BreweriesRepositoryProviding {
    func fetch(state: String, page: Int) async throws -> [Brewery]
}

struct BreweriesRepository: BreweriesRepositoryProviding {

    @Injected(\.apiRemoteDataSourceProvider)
    private var apiRemoteDataSource: ApiRemoteDataSourceProviding

    func fetch(state: String, page: Int) async throws -> [Brewery] {
        let breweriesRequest = BreweriesRequest(state: state, page: page)
        return try await apiRemoteDataSource.request(breweriesRequest)
    }
}
