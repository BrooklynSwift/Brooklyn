//
//  HTMLCoreTypes.swift
//
//
//  Created by Luki on 04/10/2024.
//

import HTMLCoreType
import Foundation

/// A protocol that describes content that is allowed to be inside an HTML button tag
public protocol ButtonContent: HTMLCoreRenderable {}

/// A struct that represents the HTML anchor tag
@HTMLCoreType
public struct A: HTMLCoreRenderable, ButtonContent {}

/// A struct that represents the HTML button tag
public struct Button: HTMLCoreRenderable {
	public let tag = "button"
	public var attributes: HTMLAttributes = .init()
	public var children: [HTMLRenderable] { content }

	private var content = [ButtonContent]()

	/// Designated initializer
	/// - Parameter content: Closure that takes no arguments & returns an array of `ButtonContent`
	public init(@ButtonBuilder content: () -> [ButtonContent]) {
		self.content = content()
	}
}

/// A struct that represents the HTML div tag
@HTMLCoreType
public struct Div: HTMLCoreRenderable {}

/// A struct that represents the HTML footer tag
@HTMLCoreType
public struct Footer: HTMLCoreRenderable {}

/// A struct that represents the HTML h1 tag
@HTMLCoreType
public struct H1: HTMLCoreRenderable {}

/// A struct that represents the HTML section tag
@HTMLCoreType
public struct Section: HTMLCoreRenderable {}

/// A struct that represents the HTML script tag
public struct Script: HTMLCoreRenderable {
	public let tag = "script"
	public let children = [HTMLRenderable]()
	public var attributes: HTMLAttributes = .init()

	private let filePath: StaticString
	private var code, file: String?

	/// Designated initializer
	/// - Parameter code: A `String` that represents a piece of JS code
	public init(_ code: String) {
		self.code = code
		self.filePath = #filePath
	}

	/// Designated initializer
	/// - Parameters:
	///		- file: A `String` that represents the JS file
	///		- filePath: A `StaticString` that represents the file path, defaults to `#filePath`
	public init(file: String, filePath: StaticString = #filePath) {
		self.file = file
		self.filePath = filePath
	}

	public func render(indent: String) -> String {
		render(indent: indent, from: filePath)
	}

	private func render(indent: String, from filePath: StaticString) -> String {
		if let code {
			let indentedCode = code
				.split(separator: "\n")
				.map { "\(indent)\($0)" }
				.joined(separator: "\n")

			return "\(indent)<script>\n\(indentedCode)\n\(indent)</script>\n"
		}
		else if let file {
			if !FileManager.default.fileExists(atPath: URL.findProjectRoot(from: filePath).path() + "Assets/\(file)") {
				fatalError("Attempting to link to a non existent script file")
			}
			return "\(indent)<script src=\"\(file)\"></script>\n"
		}
		else {
			fatalError("How did we get here?")
		}
	}
}

/// A struct that represents the HTML span tag
@HTMLCoreType
public struct Span: HTMLCoreRenderable {}

/// A struct that represents a plain string that can be rendered inside any HTML tag
public struct Text: ButtonContent {
	public let tag = ""
	public let children = [HTMLRenderable]()
	public var attributes: HTMLAttributes = .init()

	private let content: String

	/// Designated initializer
	/// - Parameter content: A `String` that represents the text
	public init(_ content: String) {
		self.content = content
	}

	public func render(indent: String) -> String {
		return "\(indent)\(content)\n"
	}
}
