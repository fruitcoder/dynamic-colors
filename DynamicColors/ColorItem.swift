//
//  ColorItem.swift
//  DynamicColors
//
//  Created by fruitcoder on 18.06.19.
//  Copyright © 2019 Fruitcode. All rights reserved.
//

import SwiftUI

struct ColorItem : View {
	let input: Input

	var body: some View {
		ZStack {
			GeometryReader { g in
				Path(roundedRect: g.frame(in: .local), cornerRadius: 10)
					.fill(self.input.color)
			}
			VStack {
				Text("R: \(self.input.rValue)").allowsTightening(true) // without this iPhone Xs Max was truncated
				Text("G: \(self.input.gValue)").allowsTightening(true)
				Text("B: \(self.input.bValue)").allowsTightening(true)
				}.foregroundColor(input.textColor)
			}.frame(width: 100, height: 100)
	}
}

struct ColorItemWrapper: View {
	let color: ColorItem.ColorKind

	@Environment(\.colorScheme) private var colorScheme: ColorScheme
	@Environment(\.colorSchemeContrast) private var colorContrast: ColorSchemeContrast

	var body: some View {
		ColorItem(input: ColorItem.Input.from(colorKind: color,
											  colorScheme: colorScheme,
											  contrast: colorContrast))
	}
}

extension ColorItem {
	struct Input {
		let color: Color
		let textColor: Color
		let rValue: Int
		let gValue: Int
		let bValue: Int

		static var `default`: Input {
			return Input(color: .init(white: 0),
						 textColor: .init(white: 1),
						 rValue: 0,
						 gValue: 0,
						 bValue: 0)
		}

		static func from(colorKind: ColorKind,
						 colorScheme: ColorScheme,
						 contrast: ColorSchemeContrast) -> Input {
			switch colorKind {
			case let .swiftUiColor(color):
				return from(color: color, colorScheme: colorScheme)
			case let .uiColor(color):
				return from(uiColor: color,
							colorScheme: colorScheme,
							contrast: contrast)
			}
		}

		private static func from(uiColor: UIColor = .systemBlue,
								 colorScheme: ColorScheme,
								 contrast: ColorSchemeContrast) -> Input {
			let resolvedColor = uiColor.resolved(for: colorScheme, contrast: contrast)
			var r: CGFloat = 0
			var g: CGFloat = 0
			var b: CGFloat = 0
			var a: CGFloat = 0

			resolvedColor.getRed(&r, green: &g, blue: &b, alpha: &a)

			return Input(color: Color(red: Double(r), green: Double(g), blue: Double(b)),
						 textColor: (r + g + b) < 1.5 ? Color(white: 1) : Color(white: 0),
						 rValue: Int(r * 255.0),
						 gValue: Int(g * 255.0),
						 bValue: Int(b * 255.0))
		}

		private static func from(color: Color,
								 colorScheme: ColorScheme) -> Input {
			switch (color, colorScheme) {
			case (.primary, .light):
				return Input(color: color,
							 textColor: Color(white: 1),
							 rValue: 0,
							 gValue: 0,
							 bValue: 0)
			case (.primary, .dark):
				return Input(color: color,
							 textColor: Color(white: 0),
							 rValue: 255,
							 gValue: 255,
							 bValue: 255)
			case (.secondary, .light):
				return Input(color: color,
							 textColor: Color(white: 1),
							 rValue: 36,
							 gValue: 36,
							 bValue: 40)
			case (.secondary, .dark):
				return Input(color: color,
							 textColor: Color(white: 0),
							 rValue: 141,
							 gValue: 141,
							 bValue: 147)
			case (.accentColor, .light), (.accentColor, .dark):
				return Input(color: color,
							 textColor: Color(white: 1),
							 rValue: 10,
							 gValue: 132,
							 bValue: 255)
			default:
				return .default
			}
		}
	}

	enum ColorKind {
		case uiColor(UIColor)
		case swiftUiColor(Color)
	}
}

