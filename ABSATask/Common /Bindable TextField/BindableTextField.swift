//
//  BindableTextField.swift
//  ABSATask
//
//  Created by Dnyaneshwar on 09/06/21.
//

import Foundation
import UIKit

class BindableTextField: UITextField {
    
    var textChangeClosure: (String) -> () = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    func bind(callback: @escaping (String) -> ()) {
        self.textChangeClosure = callback
    }
    
    private func commonInit() {
        self.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
    }
    
    @objc func textFieldChange(_ textField: UITextField) {
        
        if let text = textField.text {
            self.textChangeClosure(text)
        }
    }
    
}
