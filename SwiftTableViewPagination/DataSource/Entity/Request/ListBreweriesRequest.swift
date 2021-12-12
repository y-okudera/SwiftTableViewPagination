//
//  ListBreweriesRequest.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/13.
//

import Foundation

struct ListBreweriesRequest: GetRequest {
    typealias Response = [Brewery]

    let path: String = "/breweries"

    let state: String
    let page: Int
    let perPage: Int = 50

    init(state: String, page: Int) {
        self.state = state
        self.page = page
    }

    var queryItems: [URLQueryItem]? {
        return [
            .init(name: "page", value: "\(page)"),
            .init(name: "per_page", value: "\(perPage)"),
            .init(name: "by_state", value: state),
        ]
    }
}
