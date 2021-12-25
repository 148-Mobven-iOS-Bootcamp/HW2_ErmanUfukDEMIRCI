//
//  ViewController.swift
//  HW2
//
//  Created by Erman Ufuk Demirci on 25.12.2021.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private let popupButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Popup", for: .normal)
        button.setTitle("Highlighted", for: .highlighted)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 12
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - UI
    
    private func setupViews() {
        view.backgroundColor = .systemGray
        popupButton.addTarget(self, action: #selector(onPopupButton), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        view.addSubview(popupButton)
        
        NSLayoutConstraint.activate([
            popupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popupButton.heightAnchor.constraint(equalToConstant: 40),
            popupButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    // MARK: - Action
    
    @objc private func onPopupButton() {
        let popupViewController = PopupViewController()
        present(popupViewController, animated: true) {
            print("Presented now")
        }
    }
}


