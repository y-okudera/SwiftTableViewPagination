//
//  BreweriesRepositoryProviderKey.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/19.
//

import Foundation

private struct BreweriesRepositoryProviderKey: InjectionKey {
    static var currentValue: BreweriesRepositoryProviding = BreweriesRepository()
}

extension InjectedValues {
    var breweriesRepositoryProvider: BreweriesRepositoryProviding {
        get { Self[BreweriesRepositoryProviderKey.self] }
        set { Self[BreweriesRepositoryProviderKey.self] = newValue }
    }
}
