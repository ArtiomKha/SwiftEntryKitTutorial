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
	
}
