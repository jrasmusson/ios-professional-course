//
//  UITextField+Password.swift
//  Password
//
//  Created by jrasmusson on 2022-01-04.
//

import Foundation
import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField {
    
    func enablePasswordToggle() {
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = passwordToggleButton
        rightViewMode = .always
    }

    func enableLockImage() {
        let lockButton = UIButton(type: .custom)
        lockButton.setImage(UIImage(systemName: "lock.fill"), for: .normal)
        leftView = lockButton
        leftViewMode = .always
    }

    @objc func togglePasswordView(_ sender: Any) {
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
}
