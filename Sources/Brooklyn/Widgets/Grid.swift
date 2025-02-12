//
//  Grid.swift
//
//
//  Created by Luki on 15/11/2024.
//

import Foundation

/// A struct that represents a CSS grid to create responsive layouts, e.g., to display a certain number of columns which varies between mobile/tablets/desktop
public struct Grid: CustomRenderable {
	public var attributes: HTMLAttributes = .init()

	internal var body: [HTMLRenderable] {
		var div = Div(children)
		div.attributes = attributes
		div.attributes.class = "brooklyn-simple-grid"
		return [div]
	}

	internal let columns: Column
	internal let children: () -> [HTMLRenderable]

	/// Designated initializer
	/// - Parameters:
	///		- columns: A `Column` object which represents the number of columns
	///		- children: Escaping closure that takes no arguments & returns an array of `HTMLRenderable`, which represents the children for this object
	public init(columns: Column, @HTMLBuilder children: @escaping () -> [HTMLRenderable]) {
		self.columns = columns
		self.children = children
	}

	public func render(indent: String) -> String {
		let styles = """
		<style>
			.brooklyn-simple-grid {
				display: grid;
				gap: 10px;
				grid-template-columns: repeat(\(columns.base), 1fr);
			}

			@media (max-width: 48em) {
				.brooklyn-simple-grid {
					grid-template-columns: repeat(\(columns.tablet), 1fr);
				}
			}

			@media (max-width: 30em) {
				.brooklyn-simple-grid {
					grid-template-columns: repeat(\(columns.mobile), 1fr);
				}
			}
		</style>\n
		"""

		return styles + body.map { $0.render(indent: indent) }.joined()
	}
}

public extension Grid {
	/// A struct that represents a column for a CSS grid
	struct Column {
		internal let base: Int
		internal let tablet: Int
		internal let mobile: Int

		/// Designated initializer
		/// - Parameters:
		///		- base: An integer that represents the base number of columns
		///		- tablet: An integer that represents the number of columns for tablets
		///		- mobile: An integer that represents the number of columns for mobile
		public init(base: Int, tablet: Int = 0, mobile: Int = 0) {
			self.base = base
			self.tablet = tablet
			self.mobile = mobile
		}
	}
}
