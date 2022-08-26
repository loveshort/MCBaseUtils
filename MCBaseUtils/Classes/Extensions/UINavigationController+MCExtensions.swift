//
//  UINavigationController+MCExtensions.swift
//  MCBaseUtils_Example
//
//  Created by mxx on 2022/8/26.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    /// 替换当前导航控制器栈顶的视图
    open func replaceTop(with viewController: UIViewController, animated: Bool = true) {
        var vcs = self.viewControllers
        vcs.removeLast()
        vcs.append(viewController)
        setViewControllers(vcs, animated: animated)
    }
    
    /// 简化 push 函数
    open func push(_ viewController: UIViewController, animated: Bool = true) {
        pushViewController(viewController, animated: animated)
    }
    
    /// 简化 pop 函数，且不强制要求接收返回值
    @discardableResult
    open func pop(animated: Bool = true) -> UIViewController? {
        let poped = popViewController(animated: animated)
        return poped
    }
}
