//
//  CSSColor.swift
//
//
//  Created by Luki on 12/10/2024.
//

import Foundation

/// A struct that represents a CSS color
public struct CSSColor: RawRepresentable {
	public let rawValue: String

	public init?(rawValue: String) {
		self.rawValue = rawValue
	}
}

// MARK: - Public

public extension CSSColor {
	/// Function that converts a hex integer to a CSS color
	/// - Parameter value: An integer that represents the hex color
	/// - Returns: `CSSColor`
	static func hex(_ value: Int) -> Self {
		let valueCount = String(describing: value).dropFirst().dropFirst().count
		let hexString: String

		switch valueCount {
			case 6:
				hexString = String(format: "#%06X", value & 0xFFFFFF)
				return CSSColor(stringLiteral: hexString)

			case 8:
				hexString = String(format: "#%08X", value & 0xFFFFFFFF)
				return CSSColor(stringLiteral: hexString)

			default: fatalError("This is not a valid hex format")
		}
	}
}

// MARK: - ExpressibleByStringLiteral

extension CSSColor: ExpressibleByStringLiteral {
	public init(stringLiteral value: String) {
		self.rawValue = value
	}
}

// MARK: - Dynamic Colors

public extension CSSColor {
	// TODO: Add secondary, tertiary & quaternary colors

	/// A variable that represents a dynamic CSS color based on the user's theme, defaulting to `white` for light mode / `black` for dark mode.
	///
	/// This static variable creates a CSS color using the CSS `light-dark()` function, which allows
	/// for different color values depending on the user's system color scheme preference.
	///
	/// - Note: In order for this property to take effect, you **must** set the `color-scheme` CSS property.
	static var background: CSSColor {
		return "light-dark(white, black)"
	}

	/// A variable that represents a dynamic CSS color based on the user's theme, defaulting to `black` for light mode / `white` for dark mode. Useful for setting dynamic colors on elements that should be visible over the current background color, e.g. texts.
	///
	/// This static variable creates a CSS color using the CSS `light-dark()` function, which allows
	/// for different color values depending on the user's system color scheme preference.
	///
	/// - Note: In order for this property to take effect, you **must** set the `color-scheme` CSS property.
	static var primary: CSSColor {
		return "light-dark(black, white)"
	}

	/// Function that creates a dynamic CSS color that automatically switches between light & dark mode.
	///
	/// This static function creates a CSS color using the CSS `light-dark()` function, which allows
	/// for different color values depending on the user's system color scheme preference.
	///
	/// - Parameters:
	///		- light: The color to use when the system is in light mode.
	///		- dark: The color to use when the system is in dark mode.
	/// - Returns: A new `CSSColor` instance that will adapt based on the system color scheme.
	///
	/// - Note: In order for this property to take effect, you **must** set the `color-scheme` CSS property.
	static func system(light: CSSColor, dark: CSSColor) -> Self {
		return .init(stringLiteral: "light-dark(\(light.rawValue), \(dark.rawValue))")
	}
}

// MARK: - CSS Colors
@MainActor
public extension CSSColor {
	static let aliceBlue: CSSColor = "aliceblue",
			   antiqueWhite = "antiquewhite",
			   aqua: CSSColor = "aqua",
			   aquamarine: CSSColor = "aquamarine",
			   azure: CSSColor = "azure",
			   beige: CSSColor = "beige",
			   bisque: CSSColor = "bisque",
			   black: CSSColor = "black",
			   blanchedAlmond: CSSColor = "blanchedalmond",
			   blue: CSSColor = "blue",
			   blueViolet: CSSColor = "blueviolet",
			   brown: CSSColor = "brown",
			   burlywood: CSSColor = "burlywood",
			   cadetBlue: CSSColor = "cadetblue",
			   chartreuse: CSSColor = "chartreuse",
			   chocolate: CSSColor = "chocolate",
			   coral: CSSColor = "coral",
			   cornflowerBlue: CSSColor = "cornflowerblue",
			   cornsilk: CSSColor = "cornsilk",
			   crimson: CSSColor = "crimson",
			   cyan: CSSColor = "cyan",
			   darkBlue: CSSColor = "darkblue",
			   darkCyan: CSSColor = "darkcyan",
			   darkGoldenrod: CSSColor = "darkgoldenrod",
			   darkGray: CSSColor = "darkgray",
			   darkGreen: CSSColor = "darkgreen",
			   darkKhaki: CSSColor = "darkkhaki",
			   darkMagenta: CSSColor = "darkmagenta",
			   darkOliveGreen: CSSColor = "darkolivegreen",
			   darkOrange: CSSColor = "darkorange",
			   darkOrchid: CSSColor = "darkorchid",
			   darkRed: CSSColor = "darkred",
			   darkSalmon: CSSColor = "darksalmon",
			   darkSeaGreen: CSSColor = "darkseagreen",
			   darkSlateBlue: CSSColor = "darkslateblue",
			   darkSlateGray: CSSColor = "darkslategray",
			   darkTurquoise: CSSColor = "darkturquoise",
			   darkViolet: CSSColor = "darkviolet",
			   deepPink: CSSColor = "deeppink",
			   deepSkyBlue: CSSColor = "deepskyblue",
			   dimGray: CSSColor = "dimgray",
			   dodgerBlue: CSSColor = "dodgerblue",
			   firebrick: CSSColor = "firebrick",
			   floralWhite: CSSColor = "floralwhite",
			   forestGreen: CSSColor = "forestgreen",
			   fuchsia: CSSColor = "fuchsia",
			   gainsboro: CSSColor = "gainsboro",
			   ghostWhite: CSSColor = "ghostwhite",
			   gold: CSSColor = "gold",
			   goldenrod: CSSColor = "goldenrod",
			   gray: CSSColor = "gray",
			   green: CSSColor = "green",
			   greenYellow: CSSColor = "greenyellow",
			   honeydew: CSSColor = "honeydew",
			   hotPink: CSSColor = "hotpink",
			   indianRed: CSSColor = "indianred",
			   indigo: CSSColor = "indigo",
			   ivory: CSSColor = "ivory",
			   khaki: CSSColor = "khaki",
			   lavender: CSSColor = "lavender",
			   lavenderBlush: CSSColor = "lavenderblush",
			   lawnGreen: CSSColor = "lawngreen",
			   lemonChiffon: CSSColor = "lemonchiffon",
			   lightBlue: CSSColor = "lightblue",
			   lightCoral: CSSColor = "lightcoral",
			   lightCyan: CSSColor = "lightcyan",
			   lightGoldenrodYellow: CSSColor = "lightgoldenrodyellow",
			   lightGray: CSSColor = "lightgray",
			   lightGreen: CSSColor = "lightgreen",
			   lightPink: CSSColor = "lightpink",
			   lightSalmon: CSSColor = "lightsalmon",
			   lightSeaGreen: CSSColor = "lightseagreen",
			   lightSkyBlue: CSSColor = "lightskyblue",
			   lightSlateGray: CSSColor = "lightslategray",
			   lightSteelBlue: CSSColor = "lightsteelblue",
			   lime: CSSColor = "lime",
			   limeGreen: CSSColor = "limegreen",
			   linen: CSSColor = "linen",
			   magenta: CSSColor = "magenta",
			   maroon: CSSColor = "maroon",
			   mediumAquamarine: CSSColor = "mediumaquamarine",
			   mediumBlue: CSSColor = "mediumblue",
			   mediumOrchid: CSSColor = "mediumorchid",
			   mediumPurple: CSSColor = "mediumpurple",
			   mediumSeaGreen: CSSColor = "mediumseagreen",
			   mediumSlateBlue: CSSColor = "mediumslateblue",
			   mediumSpringGreen: CSSColor = "mediumspringgreen",
			   mediumTurquoise: CSSColor = "mediumturquoise",
			   mediumVioletRed: CSSColor = "mediumvioletred",
			   midnightBlue: CSSColor = "midnightblue",
			   mintCream: CSSColor = "mintcream",
			   mistyRose: CSSColor = "mistyrose",
			   moccasin: CSSColor = "moccasin",
			   navajoWhite: CSSColor = "navajowhite",
			   navy: CSSColor = "navy",
			   oldLace: CSSColor = "oldlace",
			   olive: CSSColor = "olive",
			   oliveDrab: CSSColor = "olivedrab",
			   orange: CSSColor = "orange",
			   orangeRed: CSSColor = "orangered",
			   orchid: CSSColor = "orchid",
			   paleGoldenrod: CSSColor = "palegoldenrod",
			   paleGreen: CSSColor = "palegreen",
			   paleTurquoise: CSSColor = "paleturquoise",
			   paleVioletRed: CSSColor = "palevioletred",
			   papayaWhip: CSSColor = "papayawhip",
			   peachPuff: CSSColor = "peachpuff",
			   peru: CSSColor = "peru",
			   pink: CSSColor = "pink",
			   plum: CSSColor = "plum",
			   powderBlue: CSSColor = "powderblue",
			   purple: CSSColor = "purple",
			   red: CSSColor = "red",
			   rosyBrown: CSSColor = "rosybrown",
			   royalBlue: CSSColor = "royalblue",
			   saddleBrown: CSSColor = "saddlebrown",
			   salmon: CSSColor = "salmon",
			   sandyBrown: CSSColor = "sandybrown",
			   seaGreen: CSSColor = "seagreen",
			   seaShell: CSSColor = "seashell",
			   sienna: CSSColor = "sienna",
			   silver: CSSColor = "silver",
			   skyBlue: CSSColor = "skyblue",
			   slateBlue: CSSColor = "slateblue",
			   slateGray: CSSColor = "slategray",
			   snow: CSSColor = "snow",
			   springGreen: CSSColor = "springgreen",
			   steelBlue: CSSColor = "steelblue",
			   tan: CSSColor = "tan",
			   teal: CSSColor = "teal",
			   thistle: CSSColor = "thistle",
			   tomato: CSSColor = "tomato",
			   turquoise: CSSColor = "turquoise",
			   violet: CSSColor = "violet",
			   wheat: CSSColor = "wheat",
			   white: CSSColor = "white",
			   whiteSmoke: CSSColor = "whitesmoke",
			   yellow: CSSColor = "yellow",
			   yellowGreen: CSSColor = "yellowgreen"
}
