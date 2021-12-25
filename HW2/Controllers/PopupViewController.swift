//
//  PopupViewController.swift
//  HW2
//
//  Created by Erman Ufuk Demirci on 25.12.2021.
//

import UIKit

protocol PopupViewControllerDelegate: AnyObject {
    func popupViewController(didChange number: Int)
}

final class PopupViewController: UIViewController {

    // MARK: - Properties

    static let notificationCenterNumberNotificationName = Notification.Name(rawValue: "notificationCenterNumberNotificationName")

    private let closureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Closure: -"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private let delegateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Delegate: -"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private let notificationCenterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "NotificationCenter: -"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private let countButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Count!", for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 12
        return button
    }()

    private var clickCountNumber = 0
    private var closureNumber: Int
    private var delegateNumber: Int
    private var notificationCenterNumber: Int

    weak var delegate: PopupViewControllerDelegate?

    var closure: ((Int) -> Void)?

    // MARK: - Init

    init(closureNumber: Int, delegateNumber: Int, notificationCenterNumber: Int) {
        self.closureNumber = closureNumber
        self.delegateNumber = delegateNumber
        self.notificationCenterNumber = notificationCenterNumber
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

        setClosureLabel(with: closureNumber)
        setDelegateLabel(with: delegateNumber)
        setNotificationCenterLabel(with: notificationCenterNumber)
    }

    private func setupConstraints() {
        let labelStack = UIStackView(arrangedSubviews: [closureLabel, delegateLabel, notificationCenterLabel])
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.axis = .vertical
        labelStack.spacing = 8

        let vStack = UIStackView(arrangedSubviews: [labelStack, countButton])
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 30

        view.addSubview(vStack)

        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            countButton.heightAnchor.constraint(equalToConstant: 40),
            countButton.widthAnchor.constraint(equalToConstant: 200)
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

    @objc private func onCountButtonPressed() {
        // With closure
        closureNumber += 1
        closure?(closureNumber)

        // With delegate
        delegateNumber += 2
        delegate?.popupViewController(didChange: delegateNumber)

        // With NotificationCenter
        notificationCenterNumber += 3
        NotificationCenter.default.post(name: PopupViewController.notificationCenterNumberNotificationName,
                                        object: nil,
                                        userInfo: ["number": notificationCenterNumber])

        setClosureLabel(with: closureNumber)
        setDelegateLabel(with: delegateNumber)
        setNotificationCenterLabel(with: notificationCenterNumber)
    }
}
