//
//  TextEnabledAlertController.swift
//  2048
//
//  Created by Pavel Koval on 8/23/18.
//  Copyright © 2018 Alkotsuki. All rights reserved.
//

import UIKit

//Alert controller with dependancy between text field and 'ok" button.
public class TextEnabledAlertController: UIAlertController {
    private var textFieldActions = [UITextField: ((UITextField)->Void)]()
    
    func addTextField(configurationHandler: ((UITextField) -> Void)? = nil, textChangeAction:((UITextField)->Void)?) {
        super.addTextField(configurationHandler: { (textField) in
            configurationHandler?(textField)
            
            if let textChangeAction = textChangeAction {
                self.textFieldActions[textField] = textChangeAction
                textField.addTarget(self, action: #selector(self.textFieldChanged), for: .editingChanged)
                
            }
        })
        
    }
    
    @objc private func textFieldChanged(sender: UITextField) {
        if let textChangeAction = textFieldActions[sender] {
            textChangeAction(sender)
        }
    }
}
