//
//  UIViewTests.swift
//  Rex
//
//  Created by Andy Jacobs on 21/10/15.
//  Copyright © 2015 Neil Pankey. All rights reserved.
//

import ReactiveCocoa
import UIKit
import XCTest

class UIViewTests: XCTestCase {
    
    weak var _view: UIView?
    
    override func tearDown() {
        XCTAssert(_view == nil, "Retain cycle detected in UIView properties")
        super.tearDown()
    }
    
    func testAlphaPropertyDoesntCreateRetainCycle() {
        let view = UIView(frame: CGRectZero)
        _view = view
        
        view.rex_alpha <~ SignalProducer(value: 0.5)
        XCTAssert(_view?.alpha == 0.5)
    }
    
    func testHiddenPropertyDoesntCreateRetainCycle() {
        let view = UIView(frame: CGRectZero)
        _view = view
        
        view.rex_hidden <~ SignalProducer(value: true)
        XCTAssert(_view?.hidden == true)
    }
    
    func testHiddenProperty() {
        let view = UIView(frame: CGRectZero)
        view.hidden = true
        
        let firstChange = false
        let secondChange = true
        
        let (pipeSignal, observer) = Signal<Bool, NoError>.pipe()
        view.rex_hidden <~ SignalProducer(signal: pipeSignal)
        
        observer.sendNext(firstChange)
        XCTAssert(view.hidden == firstChange, "UIView.rex_hidden change #1 failed")
        observer.sendNext(secondChange)
        XCTAssert(view.hidden == secondChange, "UIView.rex_hidden change #2 failed")
    }
    
    func testAlphaProperty() {
        let view = UIView(frame: CGRectZero)
        view.alpha = 0.0
        
        let firstChange = CGFloat(0.5)
        let secondChange = CGFloat(0.7)
        
        let (pipeSignal, observer) = Signal<CGFloat, NoError>.pipe()
        view.rex_alpha <~ SignalProducer(signal: pipeSignal)
        
        observer.sendNext(firstChange)
        XCTAssert(view.alpha == firstChange, "UIView.rex_alpha change #1 failed")
        observer.sendNext(secondChange)
        XCTAssert(view.alpha == secondChange, "UIView.rex_alpha change #2 failed")
    }
}