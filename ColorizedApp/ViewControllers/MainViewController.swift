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

final class MainViewController: UIViewController {
    
    // MARK: - Override Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        settingsVC.color = view.backgroundColor
    }
} 

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setBackground(with color: UIColor) {
        view.backgroundColor = color
    }
}
