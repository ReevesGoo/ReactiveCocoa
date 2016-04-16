//
//  UIViewControllerTests.swift
//  Rex
//
//  Created by Rui Peres on 16/04/2016.
//  Copyright © 2016 Neil Pankey. All rights reserved.
//

import ReactiveCocoa
import UIKit
import XCTest
import enum Result.NoError

class UIViewControllerTests: XCTestCase {
    
    weak var _viewController: UIViewController?
    
    override func tearDown() {
        XCTAssert(_viewController == nil, "Retain cycle detected in UIViewController properties")
        super.tearDown()
    }
    
    func testViewDidDisappear() {
        
        let expectation = self.expectationWithDescription("Expected rex_viewDidDisappearSignal to be triggered")
        defer { self.waitForExpectationsWithTimeout(2, handler: nil) }

        let viewController = UIViewController()
        _viewController = viewController
        
        viewController.rex_viewDidDisappearSignal.observeNext {
            expectation.fulfill()
        }
        
        viewController.viewDidDisappear(true)
    }
    
    func testViewWillDisappear() {
        
        let expectation = self.expectationWithDescription("Expected rex_viewWillDisappearSignal to be triggered")
        defer { self.waitForExpectationsWithTimeout(2, handler: nil) }
        
        let viewController = UIViewController()
        _viewController = viewController
        
        viewController.rex_viewWillDisappearSignal.observeNext {
            expectation.fulfill()
        }
        
        viewController.viewWillDisappear(true)
    }
}