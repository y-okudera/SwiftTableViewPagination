//
//  BreweriesListViewController.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/13.
//

import UIKit

protocol BreweriesListViewProviding where Self: UIViewController {
    func reload()
    func showErrorAlert(error: Error, retryHandler: @escaping () -> Void)
}

final class BreweriesListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue.dataSource = self
            newValue.delegate = self
        }
    }

    @Injected(\.breweriesListPresenterProvider)
    private var presenter: BreweriesListPresenterProviding

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Breweries"
        presenter.view = self
        presenter.viewDidLoad()
    }
}

// MARK: - BreweriesListViewProviding
extension BreweriesListViewController: BreweriesListViewProviding {

    func reload() {
        tableView.reloadData()
    }

    func showErrorAlert(error: Error, retryHandler: @escaping () -> Void) {
        let errorAlert = ErrorAlert.alertWith(error, retryHandler: retryHandler)
        present(errorAlert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension BreweriesListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.breweries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreweriesListCell", for: indexPath)
        cell.textLabel?.text = presenter.breweries[indexPath.row].name
        cell.detailTextLabel?.text = presenter.breweries[indexPath.row].city
        return cell
    }
}

// MARK: - UITableViewDelegate
extension BreweriesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath)
    }
}

// MARK: - UIScrollViewDelegate
extension BreweriesListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            return
        }
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            presenter.scrollViewReachedBottom()
        }
    }
}
