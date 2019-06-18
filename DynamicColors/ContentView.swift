//
//  ContentView.swift
//  DynamicColors
//
//  Created by fruitcoder on 17.06.19.
//  Copyright © 2019 Fruitcode. All rights reserved.
//

import SwiftUI

struct SectionHeader : View {
	var body: some View {
		HStack {
			Text("Light")
				.color(Color(white: 0))
				.frame(minWidth: 0, maxWidth: .infinity)
				.background(Color(white: 0.9))
			Text("Dark")
				.color(Color(white: 1))
				.frame(minWidth: 0, maxWidth: .infinity)
				.background(Color(white: 0))
		}
	}
}

struct ContentView: View {
	private let colors: [UIColor] = [.systemBlue, .systemGray, .systemGreen, .systemIndigo, .systemOrange, .systemPink, .systemPurple, .systemRed, .systemTeal, .systemYellow]
	private let grays: [UIColor] = [.systemGray, .systemGray2, .systemGray3, .systemGray4, .systemGray5, .systemGray6]
	private let dynamic: [UIColor] = [.label, .secondaryLabel, .tertiaryLabel, .quaternaryLabel, .placeholderText, .separator, .opaqueSeparator, .link]
	private let swiftUIOnly: [Color] = [.primary, .secondary, .accentColor]

	var body: some View {
		NavigationView {
			List {
				SectionHeader()
				Section(header: Text("System Colors (UIKit+SwiftUI)")) {
					ForEach(colors.identified(by: \.self)) { color in
						ColorRow(.uiColor(color))
					}
				}
				Section(header: Text("System Grays (UIKit)")) {
					ForEach(grays.identified(by: \.self)) { color in
						ColorRow(.uiColor(color))
					}
				}
				Section(header: Text("Dynamic Colors (UIKit)")) {
					ForEach(dynamic.identified(by: \.self)) { color in
						ColorRow(.uiColor(color))
					}
				}
				Section(header: Text("Others (SwiftUI)")) {
					ForEach(swiftUIOnly.identified(by: \.self)) { color in
						ColorRow(.swiftUiColor(color))
					}
				}
			}
			.navigationBarTitle(Text("Dynamic Colors"), displayMode: .inline)
		}
	}
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
#endif
