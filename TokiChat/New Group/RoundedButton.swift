//
//  RoundedButton.swift
//  TokiChat
//
//  Created by Petar Lemajic on 11/19/18.
//  Copyright © 2018 Metalic_archaea. All rights reserved.
//

import UIKit

class RoundedButton {
    public func buttonCornerRadiusSetup(button: UIButton) {
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.clear.cgColor
    }
}
