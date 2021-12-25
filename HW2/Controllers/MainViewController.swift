//
//  ViewController.swift
//  HW2
//
//  Created by Erman Ufuk Demirci on 25.12.2021.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - Properties

    private let closureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Closure: -"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()

    private let delegateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Delegate: -"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()

    private let notificationCenterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "NotificationCenter: -"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()

    private let popupButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Popup", for: .normal)
        button.setTitle("Highlighted", for: .highlighted)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 12
        return button
    }()

    private var closureNumber = 1 {
        didSet {
            setClosureLabel(with: closureNumber)
        }
    }
    private var delegateNumber = 2 {
        didSet {
            setDelegateLabel(with: delegateNumber)
        }
    }
    private var notificationCenterNumber = 3 {
        didSet {
            setNotificationCenterLabel(with: notificationCenterNumber)
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupObservers()
    }

    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onPopupViewNotification(notification:)),
                                               name: PopupViewController.notificationCenterNumberNotificationName,
                                               object: nil)
    }

    // MARK: - UI

    private func setupViews() {
        view.backgroundColor = .systemGray
        popupButton.addTarget(self, action: #selector(onPopupButtonPressed), for: .touchUpInside)

        setDelegateLabel(with: delegateNumber)
        setClosureLabel(with: closureNumber)
        setNotificationCenterLabel(with: notificationCenterNumber)
    }

    private func setupConstraints() {
        let labelStack = UIStackView(arrangedSubviews: [closureLabel, delegateLabel, notificationCenterLabel])
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.axis = .vertical
        labelStack.spacing = 8

        let vStack = UIStackView(arrangedSubviews: [labelStack, popupButton])
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 30

        view.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            popupButton.heightAnchor.constraint(equalToConstant: 40),
            popupButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }

    private func setDelegateLabel(with number: Int) {
        delegateLabel.text = "Delegate: \(number)"
    }

    private func setClosureLabel(with number: Int) {
        closureLabel.text = "Closure: \(number)"
    }

    private func setNotificationCenterLabel(with number: Int) {
        notificationCenterLabel.text = "NotificationCenter: \(number)"
    }

    // MARK: - Action

    @objc private func onPopupButtonPressed() {
        let popupViewController = PopupViewController(closureNumber: closureNumber,
                                                      delegateNumber: delegateNumber,
                                                      notificationCenterNumber: notificationCenterNumber)
        popupViewController.delegate = self
        popupViewController.closure = { [weak self] number in
            self?.closureNumber = number
        }
        present(popupViewController, animated: true) {
            print("Presented now!")
        }
    }

    @objc private func onPopupViewNotification(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let number = userInfo["number"] as? Int else {
            print("Number cannot be found!")
            return
        }

        notificationCenterNumber = number
    }
}

// MARK: - PopupViewControllerDelegate

extension MainViewController: PopupViewControllerDelegate {
    func popupViewController(didChange number: Int) {
        delegateNumber = number
    }
}


