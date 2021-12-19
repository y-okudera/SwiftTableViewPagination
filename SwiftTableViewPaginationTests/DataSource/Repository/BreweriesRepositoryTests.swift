//
//  BreweriesRepositoryTests.swift
//  SwiftTableViewPaginationTests
//
//  Created by Yuki Okudera on 2021/12/20.
//

import XCTest
@testable import SwiftTableViewPagination

final class BreweriesRepositoryTests: XCTestCase {

    let sut = BreweriesRepository()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchSucceeded() throws {
        InjectedValues[\.apiRemoteDataSourceProvider] = ApiRemoteDataSourceSucceededMock()
        let expectation = XCTestExpectation(description: "Fetch the breweries")

        Task {
            do {
                let result = try await sut.fetch(state: "california", page: 1)
                XCTAssertEqual(result.first?.id, "10-barrel-brewing-co-san-diego")
                expectation.fulfill()
            } catch {
                XCTFail(error.localizedDescription)
            }

        }
        wait(for: [expectation], timeout: 1)
    }

    func testFetchFailed() throws {
        InjectedValues[\.apiRemoteDataSourceProvider] = ApiRemoteDataSourceFailedMock()
        let expectation = XCTestExpectation(description: "Fetch the breweries")

        Task {
            do {
                _ = try await sut.fetch(state: "california", page: 1)
                XCTFail("Unexpected")
            } catch let e as ApiError {
                XCTAssertEqual(e, .cannotConnected)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
}

// MARK: - Mock

private struct ApiRemoteDataSourceSucceededMock: ApiRemoteDataSourceProviding {
    func request<T: GetRequest>(_ request: T) async throws -> T.Response {
        return AssetLoader.loadWithDecode(name: "Breweries")
    }
}

private struct ApiRemoteDataSourceFailedMock: ApiRemoteDataSourceProviding {
    func request<T: GetRequest>(_ request: T) async throws -> T.Response {
        throw ApiError.cannotConnected
    }
}
