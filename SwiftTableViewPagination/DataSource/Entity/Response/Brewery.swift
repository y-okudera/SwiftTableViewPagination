//
//  Brewery.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/13.
//

import Foundation

struct Brewery: Decodable {
    let id: String
    let name: String
    let breweryType: String
    let street: String?
    let city: String
    let state: String?
    let country: String
    let postalCode: String
    let latitude: String?
    let longitude: String?
    let phone: String?
    let websiteUrl: URL?
}
