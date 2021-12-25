//
//  PopupViewController.swift
//  HW2
//
//  Created by Erman Ufuk Demirci on 25.12.2021.
//

import UIKit

final class PopupViewController: UIViewController {
    
    // MARK: - Properties
    
    private let numberOfCountsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private let countButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Count", for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 12
        return button
    }()
    
    private var number: Int = 0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - UI
    
    private func setupViews() {
        view.backgroundColor = .white
        countButton.addTarget(self, action: #selector(onCountButtonPressed), for: .touchUpInside)
        setLabel(for: number)
    }
    
    private func setupConstraints() {
        let vStack = UIStackView(arrangedSubviews: [numberOfCountsLabel, countButton])
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 40.0
        
        view.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            countButton.heightAnchor.constraint(equalToConstant: 40),
            countButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setLabel(for number: Int) {
        numberOfCountsLabel.text = "\(number)"
    }
    
    // MARK: - Action
    
    @objc private func onCountButtonPressed() {
        number += 1
        setLabel(for: number)
    }
}
