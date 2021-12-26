//
//  BreweriesListViewProviderKey.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/19.
//

import UIKit

private struct BreweriesListViewProviderKey: InjectionKey {
    static var currentValue: BreweriesListViewProviding = {
        let breweriesListView = UIStoryboard(name: "BreweriesListViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "BreweriesListViewController") as! BreweriesListViewController
        return breweriesListView
    }()
}

extension InjectedValues {
    var breweriesListViewProvider: BreweriesListViewProviding {
        get { Self[BreweriesListViewProviderKey.self] }
        set { Self[BreweriesListViewProviderKey.self] = newValue }
    }
}
