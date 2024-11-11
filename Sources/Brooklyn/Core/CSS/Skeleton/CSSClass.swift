//
//  CSSClass.swift
//
//
//  Created by Luki on 08/10/2024.
//

import Foundation

/// A protocol that defines the basic structure a CSS class must have
public protocol CSSClass {
	var name: String { get }

	@CSSRuleBuilder
	var rules: [CSSRule] { get }
}
