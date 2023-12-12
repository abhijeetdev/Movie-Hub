//
//  MovieDBTests.swift
//  MovieDBTests
//
//  Created by Abhijeet Banarase on 07/12/2023.
//

import XCTest
@testable import MovieDB

final class MDTabViewControllerTests: XCTestCase {
    
    var sut: MDTabViewController!
        
    override func setUp() {
        super.setUp()
        sut = MDTabViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testViewControllersCount() {
        XCTAssertEqual(sut.viewControllers?.count, 2)
    }

    func testMovieViewControllerType() {
        XCTAssertTrue(sut.viewControllers?.first is UINavigationController)
    }

    func testSearchViewControllerType() {
        // Ensure the second view controller in the tab bar controller is of type UINavigationController
        XCTAssertTrue(sut.viewControllers?[1] is UINavigationController)
    }

    func testTabBarItemTitles() throws {
        XCTAssertEqual(sut.viewControllers?[0].tabBarItem.title, "Movie")
        XCTAssertEqual(sut.viewControllers?[1].tabBarItem.title, "Search")
    }

}

