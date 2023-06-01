//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Сергей Поляков on 01.06.2023.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setBackground(with color: UIColor)
}

class MainViewController: UIViewController {

    // MARK: - Private Properties
    private var color = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    
    // MARK: - Override Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.color = view.backgroundColor
    }
} 

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setBackground(with color: UIColor) {
        view.backgroundColor = color
    }
}
