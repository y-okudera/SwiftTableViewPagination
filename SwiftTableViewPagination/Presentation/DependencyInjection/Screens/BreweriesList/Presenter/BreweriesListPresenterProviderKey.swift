//
//  BreweriesListPresenterProviderKey.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/19.
//

import Foundation

private struct BreweriesListPresenterProviderKey: InjectionKey {
    static var currentValue: BreweriesListPresenterProviding = BreweriesListPresenter()
}

extension InjectedValues {
    var breweriesListPresenterProvider: BreweriesListPresenterProviding {
        get { Self[BreweriesListPresenterProviderKey.self] }
        set { Self[BreweriesListPresenterProviderKey.self] = newValue }
    }
}
