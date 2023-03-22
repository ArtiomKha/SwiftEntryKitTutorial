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

	let bottomSheetButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Present bottom sheet", for: .normal)
		button.backgroundColor = .blue
		return button
	}()

	let formAlertButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Present form alert", for: .normal)
		button.backgroundColor = .blue
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(buttonsStack)
		buttonsStack.addArrangedSubview(toastButton)
		buttonsStack.addArrangedSubview(alertButton)
		buttonsStack.addArrangedSubview(bottomSheetButton)
		buttonsStack.addArrangedSubview(formAlertButton)
		NSLayoutConstraint.activate([
			buttonsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
			buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
			toastButton.heightAnchor.constraint(equalToConstant: 56),
			alertButton.heightAnchor.constraint(equalToConstant: 56),
			bottomSheetButton.heightAnchor.constraint(equalToConstant: 56),
			formAlertButton.heightAnchor.constraint(equalToConstant: 56)
		])
		toastButton.addTarget(self, action: #selector(presentToast), for: .primaryActionTriggered)
		alertButton.addTarget(self, action: #selector(presentAlert), for: .primaryActionTriggered)
		bottomSheetButton.addTarget(self, action: #selector(presentBottomSheet), for: .primaryActionTriggered)
		formAlertButton.addTarget(self, action: #selector(presentFormAlert), for: .primaryActionTriggered)
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

	@objc func presentBottomSheet() {
		presentationService.presentBottomSheet(
			title: "This is bottom sheet!",
			description: "You've just created this awesome bottom sheet using SwiftEntryKit!\nLook at this fancy gradient! What a powerfull library!",
			image: UIImage(systemName: "hand.thumbsup")!,
			buttonTitle: "Got it") {
				print("performing some action")
			}
	}

	@objc func presentFormAlert() {
		presentationService.presentFormAlert { user in
			dump(user)
		}
	}
}

struct UserData {
	let name: String
	let surname: String
	let phone: String
}
