//
//  ApiRemoteDataSourceProviderKey.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/19.
//

import Foundation

private struct ApiRemoteDataSourceProviderKey: InjectionKey {
    static var currentValue: ApiRemoteDataSourceProviding = ApiRemoteDataSource(session: URLSession.shared)
}

extension InjectedValues {
    var apiRemoteDataSourceProvider: ApiRemoteDataSourceProviding {
        get { Self[ApiRemoteDataSourceProviderKey.self] }
        set { Self[ApiRemoteDataSourceProviderKey.self] = newValue }
    }
}
