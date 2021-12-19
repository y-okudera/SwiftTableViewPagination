//
//  BreweriesListViewBuilder.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/19.
//

import Foundation
import UIKit

enum BreweriesListViewBuilder {
    static func build(
        view: BreweriesListView,
        breweriesRepository: BreweriesRepository
    ) -> UIViewController {
        let presenter = BreweriesListPresenterImpl(breweriesRepository: breweriesRepository)
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
