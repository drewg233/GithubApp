//
//  DefaultButton.swift
//  Github
//
//  Created by Andrew Garcia on 3/10/18.
//  Copyright © 2018 Andrew Garcia. All rights reserved.
//

import UIKit

class DefaultButton: UIButton {
    override public func awakeFromNib() {
        self.layer.cornerRadius = 4
        self.backgroundColor = Constant.Color.blue
        self.setTitleColor(.white, for: .normal)
    }
}
