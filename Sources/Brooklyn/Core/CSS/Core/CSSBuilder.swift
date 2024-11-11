//
//  CSSBuilder.swift
//
//
//  Created by Luki on 04/10/2024.
//

import Foundation

internal typealias CSSBuilder = GenericBuilder<CSSProperty>
internal typealias CSSClassBuilder = GenericBuilder<CSSClass>
internal typealias CSSFontFaceBuilder = GenericBuilder<CSSFontFace>
internal typealias CSSRuleBuilder = GenericBuilder<CSSRule>
internal typealias CSSVariableBuilder = GenericBuilder<CSSVariable>
internal typealias CSSKeyframeBuilder = GenericBuilder<CSSKeyframes>
internal typealias CSSKeyframePointBuilder = GenericBuilder<KeyframePoint>
internal typealias CSSMediaQueryBuilder = GenericBuilder<CSSMediaQuery>

@resultBuilder
internal struct GenericCSSBuilder<T> {
	static func buildBlock(_ components: T...) -> [T] {
		return components
	}
}
