//
//  Stylesheet.swift
//
//
//  Created by Luki on 03/10/2024.
//

import Foundation

/// A protocol that describes a CSS stylesheet
public protocol Stylesheet {
	@CSSVariableBuilder
	var variables: [CSSVariable]  { get }

	@CSSFontFaceBuilder
	var fontFaces: [CSSFontFace] { get }

	@CSSClassBuilder
	var classes: [CSSClass] { get }

	@CSSKeyframeBuilder
	var keyframes: [CSSKeyframes] { get }

	@CSSMediaQueryBuilder
	var mediaQueries: [CSSMediaQuery] { get }

	func name() -> String
}

// - MARK: Rendering

internal extension Stylesheet {
	func render() {
		let variables = renderVariables()
		let fontFaces =	renderFontFaces()
		let classes = renderClasses()
		let keyframes = renderKeyframes()
		let mediaQueries = renderMediaQueries()

		var finalCSS = ""

		finalCSS.append(variables, if: self.variables.contains(where: { !$0.name.isEmpty && !$0.value.isEmpty }))
		finalCSS.append(fontFaces, if: fontFaces.count != 0)
		finalCSS.append(keyframes, if: keyframes.count != 0)
		finalCSS.append(mediaQueries, if: mediaQueries.count != 0)
		finalCSS.append(classes)
		finalCSS.write(toFile: name())
	}

	private func renderVariables() -> String {
		"""
		:root {
			\(variables.compactMap { "\($0.name): \($0.value);" }.joined(separator: .separator))
		}\n\n
		"""
	}

	private func renderFontFaces() -> String {
		fontFaces.reduce(into: "") { result, fontFace in
			let css = """
			@font-face {
				font-family: '\(fontFace.family.name)';
				font-weight: \(fontFace.weight.rawValue);
				src: url(\'\(fontFace.url)\');
			}\n\n
			"""
			result += css
		}
	}

	private func renderClasses() -> String {
		classes.reduce(into: "") { result, `class` in
			let rules = `class`.rules.reduce(into: "") { result, rule in
				let properties = rule.properties.compactMap { "\($0.name): \($0.value);" }.joined(separator: .separator)
				result += "\(rule.selector) {\(String.separator)\(properties)\n}\n\n"
			}
			result += rules
		}
	}

	private func renderKeyframes() -> String {
		keyframes.reduce(into: "") { result, keyframe in
			let points = keyframe.points.compactMap {
				"\(String.fourSpaces)\($0.percentage) { \($0.value.property): \($0.value.rawValue); }\n"
			}.joined()

			result += "@keyframes \(keyframe.name) {\n\(points)}\n\n"
		}
	}

	private func renderMediaQueries() -> String {
		mediaQueries.reduce(into: "") { result, mediaQuery in
			let cssClasses = mediaQuery.classes.reduce(into: "") { classes, cssClass in
				let rules = cssClass.rules.reduce(into: "") { rulesResult, rule in
					let properties = rule.properties.compactMap { "    \($0.name): \($0.value);"}.joined(separator: .separator)
					rulesResult += "\(String.fourSpaces)\(rule.selector) {\(String.separator)\(properties)\(String.separator)}\n"
				}
				classes += rules
			}

			let variables = mediaQuery.variables.reduce(into: "") { variables, variable in
				let css = """
					:root {
						\(variable.name): \(variable.value);
					}
				"""
				variables += "\n" + css + "\n"
			}

			result += "@media \(mediaQuery.condition.value) {\n\(cssClasses)\(variables)}\n\n"
		}
	}
}

public extension Stylesheet {
	var fontFaces: [CSSFontFace] {
		get { [] }
	}

	var variables: [CSSVariable] {
		get { [] }
	}

	var keyframes: [CSSKeyframes] {
		get { [] }
	}

	var mediaQueries: [CSSMediaQuery] {
		get { [] }
	}

	func name() -> String {
		return "styles.css"
	}
}

// MARK: - Private

private extension String {
	mutating func append(_ newString: String, if condition: Bool) {
		if condition {
			self.append(newString)
		}
	}
}
