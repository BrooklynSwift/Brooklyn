//
//  Stylable.swift
//  
//
//  Created by Luki on 16/10/2024.
//

import Foundation

/// A protocol that describes a set of attributes an HTML tag may have
public protocol Stylable {
	var attributes: HTMLAttributes { get set }
}

// MARK: - Internal

internal extension Stylable {
	func attributes() -> String {
		let keys = [
			"aria-label": attributes.ariaLabel,
			"class": attributes.class,
			"href": attributes.href,
			"id": attributes.id,
			"onclick": attributes.onClick,
			"style": attributes.styles.joined(separator: " ")
		]

		return keys.sorted { $0 < $1 }.reduce("") { result, pair in
			let (key, value) = pair
			guard !key.isEmpty, !value.isEmpty else { return result }
			return result + " \(key)=\"\(value)\""
		}
	}

	private func setAttribute<V>(_ keyPath: WritableKeyPath<HTMLAttributes, V>, to value: V) -> Self {
		var copy = self
		copy.attributes[keyPath: keyPath] = value
		return copy
	}
}

// MARK: - Attributes

public extension Stylable {
	func ariaLabel(_ label: String) -> Self {
		setAttribute(\.ariaLabel, to: label)
	}

	func `class`<C: CSSClass>(_ cls: C) -> Self {
		setAttribute(\.class, to: cls.name.replacingOccurrences(of: ".", with: ""))
	}

	internal func `class`(_ cls: String) -> Self {
		setAttribute(\.class, to: cls.replacingOccurrences(of: ".", with: ""))
	}

	func href(_ ref: String) -> Self {
		setAttribute(\.href, to: ref)
	}

	func id(_ id: String) -> Self {
		setAttribute(\.id, to: id)
	}

	func onClick(_ action: String) -> Self {
		setAttribute(\.onClick, to: action)
	}

	func style(_ styles: String...) -> Self {
		var copy = self
		copy.attributes.styles.append(contentsOf: HTMLAttributes.applyStyles(styles.sorted { $0 < $1 }))
		return copy
	}
}
