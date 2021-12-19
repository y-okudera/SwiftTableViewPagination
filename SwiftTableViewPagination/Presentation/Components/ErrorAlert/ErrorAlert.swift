//
//  ErrorAlert.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/19.
//

import UIKit

enum ErrorAlert {

    static func alertWith(_ error: Error, retryHandler: @escaping () -> Void) -> UIAlertController {
        if let apiError = error as? ApiError {
            return alertWith(apiError, retryHandler: retryHandler)
        }
        return defaultAlertWith(error)
    }
}

extension ErrorAlert {

    private static func defaultAlertWith(_ error: Error) -> UIAlertController {
        let alert = UIAlertController(title: "An error has occurred.", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(
            .init(title: "Close", style: .default)
        )
        return alert
    }

    private static func alertWith(_ apiError: ApiError, retryHandler: @escaping () -> Void) -> UIAlertController {
        switch apiError {
        case .cannotConnected:
            let message = "Please check your internet connection and then try again."
            let alert = UIAlertController(title: "Cannot connect to the network.", message: message, preferredStyle: .alert)
            alert.addAction(
                .init(title: "Retry", style: .default, handler: { _ in
                    retryHandler()
                })
            )

            alert.addAction(
                .init(title: "Cancel", style: .cancel)
            )
            return alert

        case .invalidRequest, .hasError, .decodingFailed, .unexpected:
            return defaultAlertWith(apiError)
        }
    }
}
