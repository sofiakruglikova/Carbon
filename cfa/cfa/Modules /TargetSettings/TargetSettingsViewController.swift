//
//  TargetSettingsViewController.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 11.03.2021.
//

import UIKit

class TargetSettingsViewController: UIViewController {
    
    @IBOutlet weak var targetFootprintTextField: UITextField!
    
    let viewModel = TargetSettingsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let settings = viewModel.dm.targetSettings {
            targetFootprintTextField.text = "\(settings.emission)"
        }
    }
    
    private func saveTarget() {
        
        guard let text = targetFootprintTextField.text, let emission = Float(text) else { return }
        viewModel.saveTarget(emission: CGFloat(emission))
        
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        saveTarget()
    }
}
