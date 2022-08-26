//
//  UITextField+MCExtensions.swift
//  MCBaseUtils_Example
//
//  Created by mxx on 2022/8/26.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public extension UITextField {
        
    /// 设置 UITextField 的 placeholder 颜色
    func setPlaceholderColor(_ color: UIColor) {
        
        if let string = self.placeholder {
            if !string.isEmpty {
                let attributedString = NSAttributedString(string: string, attributes: [.foregroundColor : color])
                self.attributedPlaceholder = attributedString
            }
        } else if let string = self.attributedPlaceholder {
            if string.length > 0 {
                let attributedString = NSMutableAttributedString(attributedString: string)
                attributedString.addAttribute(.foregroundColor, value: color, range: NSMakeRange(0, string.length))
                self.attributedPlaceholder = attributedString
            }
        }
    }
}
