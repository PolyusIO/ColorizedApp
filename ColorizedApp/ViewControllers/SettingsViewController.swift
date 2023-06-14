//
//  SettingsViewController.swift
//  ColorizedApp
//
//  Created by Сергей Поляков on 21.04.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    // MARK: - Public Properties
    var color: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 10
        colorView.backgroundColor = color
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    // MARK: - IB Actions
    @IBAction func sliderActions(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(for: redLabel)
            setValue(for: redTextField)
        case greenSlider:
            setValue(for: greenLabel)
            setValue(for: greenTextField)
        default:
            setValue(for: blueLabel)
            setValue(for: blueTextField)
        }
        updateColor()
    }
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        delegate.setBackground(with: color)
        dismiss(animated: true)
    }
    
    
    // MARK: - Private Methods
    private func updateColor() {
        color = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        colorView.backgroundColor = color
    }
    
    private func setValue(for sliders: UISlider... ) {
        let color = CIColor(color: color)
        sliders.forEach { slider in
            switch slider {
            case redSlider: redSlider.value = Float(color.red)
            case greenSlider: greenSlider.value = Float(color.green)
            default: blueSlider.value = Float(color.blue)
            }
        }
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel: redLabel.text = showText(for: redSlider)
            case greenLabel: greenLabel.text = showText(for: greenSlider)
            default: blueLabel.text = showText(for: blueSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField: redTextField.text = showText(for: redSlider)
            case greenTextField: greenTextField.text = showText(for: greenSlider)
            default: blueTextField.text = showText(for: blueSlider)
            }
        }
    }
    
    private func showText(for slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    @objc private func keyboardDoneButtonPressed() {
        view.endEditing(true)
    }
    
}

extension SettingsViewController: UITextFieldDelegate {
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let floatValue = Float(newValue) else { return }
        
        switch textField {
        case redTextField:
            redSlider.setValue(floatValue, animated: true)
            redLabel.text = newValue
        case greenTextField:
            greenSlider.setValue(floatValue, animated: true)
            greenLabel.text = newValue
        default:
            blueSlider.setValue(floatValue, animated: false)
            blueLabel.text = newValue
        }
        updateColor()
    }
    
    internal func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(keyboardDoneButtonPressed)
        )
        
        keyboardToolbar.items = [doneButton]
    }
}

