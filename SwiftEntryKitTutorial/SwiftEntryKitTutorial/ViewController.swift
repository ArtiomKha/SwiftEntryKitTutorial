//
//  ViewController.swift
//  SwiftEntryKitTutorial
//
//  Created by Artsiom Khaliliayeu on 12.03.23.
//

import UIKit

enum BannerType: CaseIterable {
	case toast
	case alert
	
	var cellTitle: String {
		switch self {
		case .toast:
			return "Present floating toast"
		case .alert:
			return "Present alert"
		}
	}
}

class ViewController: UIViewController {


	let presentationService = PresentationService()

	let buttonsStack: UIStackView = {
		let stack = UIStackView()
		stack.alignment = .fill
		stack.distribution = .fill
		stack.axis = .vertical
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.spacing = 12
		return stack
	}()
	
	let toastButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Present floating toast", for: .normal)
		button.backgroundColor = .blue
		return button
	}()

	let alertButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Present alert", for: .normal)
		button.backgroundColor = .blue
		return button
	}()

	let customBannerButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Present custom banner", for: .normal)
		button.backgroundColor = .blue
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(buttonsStack)
		buttonsStack.addArrangedSubview(toastButton)
		buttonsStack.addArrangedSubview(alertButton)
		buttonsStack.addArrangedSubview(customBannerButton)
		NSLayoutConstraint.activate([
			buttonsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			toastButton.heightAnchor.constraint(equalToConstant: 56),
			alertButton.heightAnchor.constraint(equalToConstant: 56),
			customBannerButton.heightAnchor.constraint(equalToConstant: 56)
		])
		toastButton.addTarget(self, action: #selector(presentToast), for: .primaryActionTriggered)
		alertButton.addTarget(self, action: #selector(presentAlert), for: .primaryActionTriggered)
		customBannerButton.addTarget(self, action: #selector(presentCustomBanner), for: .primaryActionTriggered)
	}

	@objc func presentToast() {
		presentationService.presentToast(
			title: "Error",
			description: "Something went wrong",
			image: UIImage(systemName: "exclamationmark.circle.fill")!
		)
	}

	@objc func presentAlert() {
		presentationService.presentAlert(
			title: "Enable push notification",
			description: "Enable push notifications so you won't miss any new orders",
			image: UIImage(systemName: "bell")!,
			confirmTitle: "OK",
			cancelTitle: "Cancel") {
				print("Confirm Action")
			} cancelAction: {
				print("Cancel Action")
			}
	}

	@objc func presentCustomBanner() {
		//TODO: - add logic for custom banner presentation
	}

}

