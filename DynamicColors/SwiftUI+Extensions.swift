//
//  SwiftUI+Extensions.swift
//  DynamicColors
//
//  Created by fruitcoder on 18.06.19.
//  Copyright © 2019 Fruitcode. All rights reserved.
//

import SwiftUI

extension UIColor {
	func resolved(for colorScheme: ColorScheme,
				  contrast: ColorSchemeContrast) -> UIColor{
		return resolvedColor(with: UITraitCollection(traitsFrom: [colorScheme.asTraitCollection, contrast.asTraitCollection]))
	}
}

extension ColorSchemeContrast {
	var asTraitCollection: UITraitCollection {
		switch self {
		case .standard:
			return UITraitCollection(accessibilityContrast: .normal)
		case .increased:
			return UITraitCollection(accessibilityContrast: .high)
		@unknown default:
			return UITraitCollection(accessibilityContrast: .normal)
		}
	}
}

extension ColorScheme {
	var asTraitCollection: UITraitCollection {
		switch self {
		case .dark:
			return UITraitCollection(userInterfaceStyle: .dark)
		case .light:
			return UITraitCollection(userInterfaceStyle: .light)
		@unknown default:
			return UITraitCollection(userInterfaceStyle: .light)
		}
	}
}
