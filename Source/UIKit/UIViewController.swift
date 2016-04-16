//
//  UIViewController.swift
//  Rex
//
//  Created by Rui Peres on 14/04/2016.
//  Copyright © 2016 Neil Pankey. All rights reserved.
//

import Result
import ReactiveCocoa
import UIKit

extension UIViewController {
    /// Returns a `Signal`, that will be triggered
    /// when `self`'s `viewDidDisappear` is called
    public var rex_viewDidDisappearSignal: Signal<(), NoError> {
        return triggerForSelector(#selector(UIViewController.viewDidDisappear(_:)))
    }
    
    /// Returns a `Signal`, that will be triggered
    /// when `self`'s `viewWillDisappear` is called
    public var rex_viewWillDisappearSignal: Signal<(), NoError> {
        return triggerForSelector(#selector(UIViewController.viewWillDisappear(_:)))
    }
    
    private func triggerForSelector(selector: Selector) -> Signal<(), NoError>  {
        return self
            .rac_signalForSelector(selector)
            .rex_toSignal()
            .map { _ in () }
            .ignoreError()
    }
}