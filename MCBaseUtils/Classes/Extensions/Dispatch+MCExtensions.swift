//
//  Dispatch+MCExtensions.swift
//  MCBaseUtils_Example
//
//  Created by mxx on 2022/8/26.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation


//延时当前时间开始 -- 不同版本写法

public extension DispatchQueue {
    
    
    func asyncAfter(delay: DispatchTimeInterval, execute work: @escaping @convention(block) () -> Swift.Void) {
        asyncAfter(deadline: .now() + delay, execute: work)
    }
    
    func asyncAfter(delay seconds: TimeInterval, execute work: @escaping @convention(block) () -> Swift.Void) {
        asyncAfter(deadline: .now() + seconds, execute: work)
    }

    func asyncAfter(delay: DispatchTimeInterval, execute: DispatchWorkItem) {
        asyncAfter(deadline: .now() + delay, execute: execute)
    }
    
    func asyncAfter(delay seconds: TimeInterval, execute: DispatchWorkItem) {
        asyncAfter(deadline: .now() + seconds, execute: execute)
    }
}
