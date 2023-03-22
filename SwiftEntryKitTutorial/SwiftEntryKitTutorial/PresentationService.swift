//
//  PresentationService.swift
//  SwiftEntryKitTutorial
//
//  Created by Artsiom Khaliliayeu on 12.03.23.
//

import UIKit
import SwiftEntryKit

class PresentationService {
	
	func presentToast(title: String, description: String, image: UIImage) {
		
		var attributes: EKAttributes = .topFloat
		
		attributes.entryBackground = EKAttributes.BackgroundStyle.color(color: EKColor(.red))
		
		attributes.displayDuration = 5
		attributes.entryInteraction = .dismiss
		attributes.screenInteraction = .dismiss
		
		let titleLabel = EKProperty.LabelContent(text: title, style: EKProperty.LabelStyle(font: .systemFont(ofSize: 18, weight: .semibold), color: EKColor(.white)))
		let descriptionLabel = EKProperty.LabelContent(text: description, style: EKProperty.LabelStyle(font: .systemFont(ofSize: 16, weight: .regular), color: EKColor(.white)))
		let image = EKProperty.ImageContent(image: image, size: CGSize(width: 32, height: 32), tint: EKColor(.white), contentMode: .scaleAspectFill)
		let simpleMessage = EKSimpleMessage(image: image, title: titleLabel, description: descriptionLabel)
		let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
		let entry = EKNotificationMessageView(with: notificationMessage)
		
		SwiftEntryKit.display(entry: entry, using: attributes)
	}
	
	func presentAlert(title: String, description: String, image: UIImage, confirmTitle: String, cancelTitle: String, confirmAction: @escaping () -> Void, cancelAction: @escaping () -> Void) {
		
		var attributes: EKAttributes = EKAttributes()
		attributes.position = .center
		attributes.displayDuration = .infinity
		
		let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 0.9)
		let heightConstraint = EKAttributes.PositionConstraints.Edge.intrinsic
		attributes.positionConstraints.size = EKAttributes.PositionConstraints.Size(width: widthConstraint, height: heightConstraint)

		attributes.entryInteraction = .absorbTouches
		attributes.scroll = .disabled
		
		attributes.entryBackground = .color(color: .white)
		attributes.screenBackground = .color(color: EKColor(UIColor(white: 0.5, alpha: 0.5)))
		
		attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 10, offset: .zero))
		attributes.roundCorners = .all(radius: 12)
		
		let titleLabel = EKProperty.LabelContent(text: title, style: EKProperty.LabelStyle(font: .systemFont(ofSize: 18, weight: .semibold), color: EKColor(.black)))
		let descriptionLabel = EKProperty.LabelContent(text: description, style: EKProperty.LabelStyle(font: .systemFont(ofSize: 16, weight: .regular), color: EKColor(.black)))
		let image = EKProperty.ImageContent(image: image, size: CGSize(width: 32, height: 32), tint: EKColor(.black), contentMode: .scaleAspectFill)
		let simpleMessage = EKSimpleMessage(image: image, title: titleLabel, description: descriptionLabel)
		
		let okButton = EKProperty.ButtonContent(
			label: EKProperty.LabelContent(text: confirmTitle, style: EKProperty.LabelStyle(font: .systemFont(ofSize: 20, weight: .bold), color: EKColor(.blue))),
			backgroundColor: EKColor(.white),
			highlightedBackgroundColor: EKColor(.lightGray),
			action: {
				confirmAction()
				SwiftEntryKit.dismiss()
			}
		)
		
		let cancelButton = EKProperty.ButtonContent(
			label: EKProperty.LabelContent(text: cancelTitle, style: EKProperty.LabelStyle(font: .systemFont(ofSize: 20, weight: .bold), color: EKColor(.red))),
			backgroundColor: EKColor(.white),
			highlightedBackgroundColor: EKColor(.lightGray),
			action: {
				cancelAction()
				SwiftEntryKit.dismiss()
			}
		)

		let buttonBarContent = EKProperty.ButtonBarContent(
			with: okButton, cancelButton,
			separatorColor:  EKColor(.black),
			expandAnimatedly: false
		)
		
		let entry = EKAlertMessageView(
			with: EKAlertMessage(
				simpleMessage: simpleMessage,
				buttonBarContent: buttonBarContent
			)
		)
		
		SwiftEntryKit.display(entry: entry, using: attributes)
	}

	func presentBottomSheet(title: String, description: String, image: UIImage, buttonTitle: String, buttonAction: (() -> Void)?) {
		var attributes: EKAttributes = .bottomToast
		
		let colors: [EKColor] = [
			EKColor(red: 173, green: 70, blue: 137),
			EKColor(red: 194, green: 77, blue: 136),
			EKColor(red: 216, green: 85, blue: 135),
			EKColor(red: 237, green: 92, blue: 134),
		]
		attributes.entryBackground = .gradient(gradient: .init(colors: colors, startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
		
		attributes.roundCorners = .top(radius: 12)
		
		attributes.displayDuration = .infinity
		attributes.entryInteraction = .absorbTouches
		attributes.screenInteraction = .absorbTouches
		
		let titleLabel = EKProperty.LabelContent(
			text: title,
			style: EKProperty.LabelStyle(
				font: .systemFont(ofSize: 18, weight: .semibold),
				color: EKColor(.white),
				alignment: .center,
				numberOfLines: 1
			)
		)

		let descriptionLabel = EKProperty.LabelContent(
			text: description,
			style: EKProperty.LabelStyle(
				font: .systemFont(ofSize: 16, weight: .regular),
				color: EKColor(.white),
				alignment: .center,
				numberOfLines: 0
			)
		)

		let image = EKProperty.ImageContent(
			image: image,
			size: CGSize(width: 32, height: 32),
			tint: EKColor(.white),
			contentMode: .scaleAspectFill
		)

		let buttonLabel = EKProperty.LabelContent(
			text: buttonTitle,
			style: EKProperty.LabelStyle(
				font: .systemFont(ofSize: 16, weight: .semibold),
				color: .black,
				alignment: .center,
				numberOfLines: 1
			)
		)

		let button = EKProperty.ButtonContent(
			label: buttonLabel,
			backgroundColor: .white,
			highlightedBackgroundColor: .white,
			contentEdgeInset: 8
		)
	
		let popUpMessage = EKPopUpMessage(
			themeImage: .init(image: image),
			title: titleLabel,
			description: descriptionLabel,
			button: button) {
				buttonAction?()
				SwiftEntryKit.dismiss()
			}

		let entry = EKPopUpMessageView(with: popUpMessage)
		SwiftEntryKit.display(entry: entry, using: attributes)
	}

	func presentFormAlert(completion: @escaping (UserData) -> Void) {
		var attributes: EKAttributes = .centerFloat
		
		let colors: [EKColor] = [
			EKColor(red: 211, green: 211, blue: 223),
			EKColor(red: 198, green: 197, blue: 229),
			EKColor(red: 185, green: 182, blue: 234),
			EKColor(red: 172, green: 168, blue: 240),
		]
		attributes.entryBackground = .gradient(gradient: .init(colors: colors, startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
		
		attributes.roundCorners = .all(radius: 12)
		
		attributes.displayDuration = .infinity
		attributes.entryInteraction = .absorbTouches
		attributes.screenInteraction = .absorbTouches

		let offset = EKAttributes.PositionConstraints.KeyboardRelation.Offset(bottom: 10, screenEdgeResistance: 20)
		let keyboardRelation = EKAttributes.PositionConstraints.KeyboardRelation.bind(offset: offset)
		attributes.positionConstraints.keyboardRelation = keyboardRelation
		
		let titleLabel = EKProperty.LabelContent(
			text: "Tell us about youself",
			style: EKProperty.LabelStyle(
				font: .systemFont(ofSize: 18, weight: .semibold),
				color: EKColor(red: 37, green: 35, blue: 34),
				alignment: .center,
				numberOfLines: 1
			)
		)

		let nameTF = createTextField(placeholder: "Name", leadingImage:  UIImage(systemName: "person.crop.circle"))

		let surnameTF = createTextField(placeholder: "Surname", leadingImage:  UIImage(systemName: "person.crop.square"))

		let phoneTF = createTextField(placeholder: "+13142244371", leadingImage:  UIImage(systemName: "phone"), keyboardType: .phonePad)

		let buttonLabel = EKProperty.LabelContent(
			text: "Submit",
			style: EKProperty.LabelStyle(
				font: .systemFont(ofSize: 16, weight: .semibold),
				color: EKColor(red: 37, green: 35, blue: 34),
				alignment: .center,
				numberOfLines: 1
			)
		)

		let button = EKProperty.ButtonContent(
			label: buttonLabel,
			backgroundColor: .white,
			highlightedBackgroundColor: .white,
			contentEdgeInset: 8) {
				let userData = UserData(name: nameTF.textContent, surname: surnameTF.textContent, phone: phoneTF.textContent)
				completion(userData)
				SwiftEntryKit.dismiss()
			}

		

		let entry = EKFormMessageView(
			with: titleLabel,
			textFieldsContent: [nameTF, surnameTF, phoneTF],
			buttonContent: button
		)
	
		SwiftEntryKit.display(entry: entry, using: attributes)
	}

	private func createTextField(placeholder: String, leadingImage: UIImage?, keyboardType: UIKeyboardType = .default) -> EKProperty.TextFieldContent {
		EKProperty.TextFieldContent(
			keyboardType: keyboardType,
			placeholder: getPlaceholder(with: placeholder),
			tintColor: EKColor(red: 37, green: 35, blue: 34),
			textStyle: EKProperty.LabelStyle(font: .systemFont(ofSize: 16), color: EKColor(red: 37, green: 35, blue: 34)),
			leadingImage: leadingImage,
			bottomBorderColor: EKColor(red: 93, green: 89, blue: 87)
		)
	}

	private func getPlaceholder(with text: String) -> EKProperty.LabelContent {
		EKProperty.LabelContent(
			text: text,
			style: EKProperty.LabelStyle(
				font: .systemFont(ofSize: 16),
				color: EKColor(red: 93, green: 89, blue: 87)
			)
		)
	}
}
