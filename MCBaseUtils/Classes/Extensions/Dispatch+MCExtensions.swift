//
//  Dispatch+MCExtensions.swift
//  MCBaseUtils_Example
//
//  Created by mxx on 2022/8/26.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

public extension DispatchQueue {
    
    public func asyncAfter(delay: DispatchTimeInterval, execute work: @escaping @convention(block) () -> Swift.Void) {
        asyncAfter(deadline: .now() + delay, execute: work)
    }
    
    public func asyncAfter(delay seconds: TimeInterval, execute work: @escaping @convention(block) () -> Swift.Void) {
        asyncAfter(deadline: .now() + seconds, execute: work)
    }

    public func asyncAfter(delay: DispatchTimeInterval, execute: DispatchWorkItem) {
        asyncAfter(deadline: .now() + delay, execute: execute)
    }
    
    public func asyncAfter(delay seconds: TimeInterval, execute: DispatchWorkItem) {
        asyncAfter(deadline: .now() + seconds, execute: execute)
    }
}
