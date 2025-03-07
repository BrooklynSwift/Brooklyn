//
//  TextDecoration.swift
//
//
//  Created by Luki on 13/10/2024.
//

import Foundation

@frozen
public enum TextDecorationLine: String {
	case lineThrough, none, overline, underline

	var description: String {
		switch self {
			case .lineThrough: return "line-through"
			default: return rawValue
		}
	}
}

public extension Stylable {
	func textDecoration(_ value: TextDecorationLine) -> Self {
		style("text-decoration: \(value.description)")
	}
}
