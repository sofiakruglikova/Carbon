//
//  AddDataViewController.swift
//  cfa
//
//  Created by Sofiia Kruglikova on 04.03.2021.
//

import UIKit

class AddDataViewController: UIViewController {
    
    @IBOutlet weak var transportTextField: UITextField!
    
    @IBOutlet weak var frequencyTextField: UITextField!
    
    let viewModel = AddDataViewModel()
    
    let transportPickerView = UIPickerView()
    let frequencyPickerView = UIPickerView()
    
    var currentTransport: EditData.Transport? {
        didSet {
            if let textField = self.transportTextField, let transport = currentTransport {
                textField.text = transport.title
            }
        }
    }
    var currentFrequency: EditData.Frequency? {
        didSet {
            if let textField = self.frequencyTextField, let frequency = currentFrequency {
                textField.text = frequency.text
            }
        }
    }
    var currentTimes: Int = 1 {
        didSet {
            if  let frequency = currentFrequency {
                currentFrequency = EditData.Frequency.get(by: frequency, for: currentTimes)
                frequencyPickerView.reloadComponent(1)
            }
        }
    }
    
    var delegate: EditDataDelegate?
    
    var currentCarbonPair: (Int, EditData.Carbon)? {
        didSet {
            if let carbon = currentCarbonPair?.1 {
                self.currentTransport = carbon.transport
                self.currentFrequency = carbon.frequency
                self.currentTimes = carbon.frequency.times
            }
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpPickerView()

    }
    
    func setUpPickerView() {
        //Frequency
        frequencyPickerView.dataSource = self
        frequencyPickerView.delegate = self
        
        frequencyTextField.inputView = frequencyPickerView
        frequencyTextField.delegate = self
        
        //Transport
        transportPickerView.dataSource = self
        transportPickerView.delegate = self
        
        transportTextField.inputView = transportPickerView
        transportTextField.delegate = self
        
        createToolbar(textField: frequencyTextField, nameTF: "frequencyTextField")
        createToolbar(textField: transportTextField, nameTF: "transportTextField")
    }
    
    func createToolbar(textField: UITextField, nameTF: String) {
            
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        toolBar.barTintColor = .orange
        toolBar.tintColor = .white
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(hidePicker))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
        }
        
        @objc func hidePicker() {
            frequencyTextField.resignFirstResponder()
            transportTextField.resignFirstResponder()
        }
    
    private func saveData(completion: (() -> Void)? = nil) {
            if let transport = currentTransport, let frequency = currentFrequency {
                let carbon = EditData.Carbon(transport: transport, frequency: frequency)
                if let carbonPair = currentCarbonPair {
                    delegate?.updateData(carbonPair: (carbonPair.0, carbon))
                } else {
                    delegate?.addData(carbon: carbon)
                }
            }
            completion?()
        }
    
    private func clearUI() {
        currentTransport = .Bus
        currentFrequency = .EveryDay
        currentTimes = 1
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        saveData {
            self.clearUI()
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        saveData {
            self.dismiss(animated: true) { [weak self] in
                self?.delegate?.update()
            }
        }
    }
}

extension AddDataViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView === frequencyPickerView {
            return 2
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView === frequencyPickerView {
            switch component {
            case 0: return EditData.Frequency.count
            case 1: return EditData.Frequency.count(frequency: currentFrequency)
            default: return 0
            }
        } else {
            return EditData.Transport.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView === frequencyPickerView {
            switch component {
            case 0: return EditData.Frequency.titles[row]
            case 1:
                let count: Int = EditData.Frequency.count(frequency: currentFrequency)
                if row < count {
                    return (1...count).map({"\($0)"})[row]
                } else {
                    return "\(count)"
                }
            default: return ""
            }
        } else {
            return EditData.Transport.titles[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView === frequencyPickerView {
            switch component {
            case 0: currentFrequency = EditData.Frequency.get(by: EditData.Frequency.titles[row], for: currentTimes)
            case 1: currentTimes = row + 1
            default: break
            }
        } else {
            currentTransport = EditData.Transport.get(by: row)
        }
    }

}

extension AddDataViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}





