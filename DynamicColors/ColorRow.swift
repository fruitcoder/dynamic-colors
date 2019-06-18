//
//  ColorRow.swift
//  DynamicColors
//
//  Created by fruitcoder on 18.06.19.
//  Copyright © 2019 Fruitcode. All rights reserved.
//

import SwiftUI

struct ColorRow: View {
	let color: ColorItem.ColorKind

	init(_ color: ColorItem.ColorKind) {
		self.color = color
	}

	private var name: String {
		switch color {
		case let .swiftUiColor(color):
			return color.description
		case let .uiColor(color):
			let systemColorName = color.value(forKey: "_systemColorName") as? String
			return systemColorName.map { $0.replacingOccurrences(of: "Color", with: "") } ?? "unknown"
		}
	}

	var body: some View {
		HStack(spacing: 0) {
			ColorItemWrapper(color: color)
				.environment(\.colorScheme, .light)
			Spacer()
			Text(name)
			Spacer()
			ColorItemWrapper(color: color)
				.environment(\.colorScheme, .dark)

			/*
			// It's currently not possible to override the color scheme contrast (readonly)
			ColorItemWrapper(uiColor: uiColor)
			.environment(\.colorScheme, .light)
			.environment(\.colorSchemeContrast, .high)
			ColorItemWrapper(uiColor: uiColor)
			.environment(\.colorScheme, .dark)
			.environment(\.colorSchemeContrast, .high)
			*/
		}
	}
}
