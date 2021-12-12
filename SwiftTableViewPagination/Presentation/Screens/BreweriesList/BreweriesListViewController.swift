//
//  BreweriesListViewController.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/13.
//

import UIKit

class BreweriesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        requestBreweries()
    }

    private func requestBreweries() {
        Task {
            do {
                let request = ListBreweriesRequest(state: "new_york", page: 1)
                let response = try await WebApiRemoteDataSourceProvider.provide().httpGet(for: request)
                print("response:", response)

            } catch let e as WebApiError {
                print(e)
            }
        }
    }
}
