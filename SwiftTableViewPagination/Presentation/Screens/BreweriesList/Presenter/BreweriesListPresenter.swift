//
//  BreweriesListPresenter.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/14.
//

import Foundation

protocol BreweriesListPresenter: AnyObject {
    var view: BreweriesListView? { get set }
    var page: Int { get }
    var breweries: [Brewery] { get }
    var isLoading: Bool { get }

    func viewDidLoad()
    func scrollViewReachedBottom()
}

final class BreweriesListPresenterImpl: BreweriesListPresenter {

    private let breweriesRepository: BreweriesRepository
    weak var view: BreweriesListView?

    private(set) var page: Int = 0
    private(set) var breweries: [Brewery] = []
    private(set) var isLoading: Bool = false
    private var hasNext = true

    init(breweriesRepository: BreweriesRepository) {
        self.breweriesRepository = breweriesRepository
    }

    func viewDidLoad() {
        fetchBreweries()
    }

    func scrollViewReachedBottom() {
        fetchBreweries()
    }

    func fetchBreweries() {
        if !hasNext {
            return
        }
        if isLoading {
            return
        }
        isLoading = true

        Task {
            do {
                page += 1
                let response = try await breweriesRepository.fetch(state: "new_york", page: page)
                hasNext = !response.isEmpty
                breweries.append(contentsOf: response)
                DispatchQueue.main.async { [weak self] in
                    self?.view?.reload()
                }
                isLoading = false

            } catch let e as ApiError {
                page -= 1
                isLoading = false
                DispatchQueue.main.async { [weak self] in
                    self?.view?.showErrorAlert(error: e, retryHandler: { [weak self] in
                        self?.fetchBreweries()
                    })
                }
            }
        }
    }
}
