//
//  SearchBarView.swift
//  iOSTakeHomeChallenge
//
//  Created by Karl Cridland on 07/06/2025.
//

import UIKit

class SearchBarView: UIView {
    
    @IBOutlet weak var textField: UITextField!
    
    var onValueChange: ((String?) -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        if let view = Bundle.main.loadNibNamed("SearchBarView", owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
        self.layer.cornerRadius = 8
        self.layer.cornerCurve = .continuous
        self.textField.addTarget(self, action: #selector(self.update), for: .allEditingEvents)
    }
    
    @objc func update() {
        let text: String? = self.textField.text
        self.onValueChange?(text == "" ? nil : text)
    }

}
