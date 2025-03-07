//
//  JustifyContent.swift
//  Brooklyn
//
//  Created by Luki on 06/03/2025.
//

import Foundation

@frozen
public struct JustifyContent {
	@frozen
	public enum ContentDistribution: String {
		case spaceAround = "space-around"
		case spaceBetween = "space-between"
		case spaceEvenly = "space-evenly"
		case stretch
	}

	@frozen
	public enum ContentPosition: String {
		case center
		case start
		case end
		case flexStart = "flex-start"
		case flexEnd = "flex-end"
	}

	@frozen
	public enum OverflowPosition {
		case safe(ContentPosition)
		case unsafe(ContentPosition)

		var description: String {
			switch self {
				case .safe(let position): return "safe \(position.rawValue)"
				case .unsafe(let position): return "unsafe \(position.rawValue)"
			}
		}
	}

	private init() {}
}

public extension Stylable {
	func justifyContent(_ value: JustifyContent.ContentDistribution) -> Self {
		style("justify-content: \(value.rawValue)")
	}

	func justifyContent(_ value: JustifyContent.ContentPosition) -> Self {
		style("justify-content: \(value.rawValue)")
	}

	func justifyContent(_ value: JustifyContent.OverflowPosition) -> Self {
		style("justify-content: \(value.description)")
	}
}
