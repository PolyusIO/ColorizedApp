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
    }

    // MARK: - IB Actions
    @IBAction func sliderActions(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redLabel.text = showText(for: redSlider)
            redTextField.text = showText(for: redSlider)
        case greenSlider:
            greenLabel.text = showText(for: greenSlider)
            greenTextField.text = showText(for: greenSlider)
        default:
            blueLabel.text = showText(for: blueSlider)
            blueTextField.text = showText(for: blueSlider)
        }
        setColor()
        colorView.backgroundColor = color
    }
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        delegate.setBackground(with: color)
        dismiss(animated: true)
    }
    
    
    // MARK: - Private Methods
    private func setColor() {
        color = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func showText(for slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
}

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let floatValue = Float(newValue) else { return }
        
        switch textField {
        case redTextField: redSlider.value = floatValue
        case greenTextField: greenSlider.value = floatValue
        default: blueSlider.value = floatValue
        }
    }
    
}

