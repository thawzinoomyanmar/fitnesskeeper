//
//  button.swift
//  fitness app
//
//  Created by HaN  on 8/12/18.
//  Copyright © 2018 HaN . All rights reserved.
//

import UIKit

class Button: UIButton {

    @IBInspectable var borderColor : UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }

}
