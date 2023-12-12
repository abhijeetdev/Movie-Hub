//
//  TabViewControllerTests.swift
//  MovieHubTests
//
//  Created by Abhijeet Banarase on 07/12/2023.
//

import XCTest
@testable import MovieHub

final class TabViewControllerTests: XCTestCase {
    
    var vc: TabViewController!
    
    override func setUp() {
        super.setUp()
        vc = TabViewController()
        vc.loadViewIfNeeded()
    }
    
    override func tearDown() {
        vc = nil
        super.tearDown()
    }
    
    func testViewControllersCount() {
        XCTAssertEqual(vc.viewControllers?.count, 2)
    }
    
    func testMovieViewControllerType() {
        XCTAssertTrue(vc.viewControllers?.first is UINavigationController)
    }
    
    func testSearchViewControllerType() {
        // Ensure the second view controller in the tab bar controller is of type UINavigationController
        XCTAssertTrue(vc.viewControllers?[1] is UINavigationController)
    }
    
    func testTabBarItemTitles() throws {
        XCTAssertEqual(vc.viewControllers?[0].tabBarItem.title, "Movie")
        XCTAssertEqual(vc.viewControllers?[1].tabBarItem.title, "Search")
    }
}

