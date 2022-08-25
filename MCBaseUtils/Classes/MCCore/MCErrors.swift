//
//  MCErrors.swift
//  MCBaseUtils_Example
//
//  Created by mxx on 2022/8/25.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation


///  框架所有异常信息定义
enum MCError: Error {
    
    /// 设备不支持打电话
    case phoneCallNotSupported
    
    /// 未定义的错误
    case unknown
}

extension MCError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .phoneCallNotSupported: return "设备不支持拨打电话"
        default: return "未知错误"
        }
    }
}
