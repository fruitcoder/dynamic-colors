# dynamic-colors
SwiftUI App to present iOS 13 dynamic colors in light and dark mode

## Motivation
While looking up documentation on how to implement Dark Mode for one of my apps I realized that the nice color overviews were missing for some dynamic colors (last section  [https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/#dynamic-system-colors]). I thought it would be nice to try out SwiftUI to display all the different colors in light/dark mode. 
Initially, I also wanted to add a toggle to switch between high/standard contrast but it turns out that the `ColorSchemeContrast` is a readonly `EnvironmentValue`.

## Notes 
It seems like SwiftUI doesn't have access to some UIKit colors (sections *System Grays* and *Dynamic Colors*) but comes with three colors on its own. **Primary** seems to be the same as `UIColor.label` while **Secondary** doesn't seem to have a matching UIKit color. **Accent** is the same in light and dark mode but since `accentColor` is also writable in the `Environment` it might be intended for customization.

The purpose of `ColorItemWrapper` is to observe changes to the color scheme environment value and push those changes into the `ColorItem`. I couldn't find a way to make this work without the wrapper.

## Screenshot
![Screenshot of simulator](https://github.com/fruitcoder/dynamic-colors/blob/master/Preview.png)
