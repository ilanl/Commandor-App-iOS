//
//  UIView+xib.swift
//
//  Created by IlanL on 24/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import UIKit

extension UIView {
    
    @discardableResult
    func fromNib<T :UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            return nil
        }
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return contentView
    }
}
