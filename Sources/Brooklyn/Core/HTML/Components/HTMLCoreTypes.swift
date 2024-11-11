//
//  HTMLComponents.swift
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
	public var tag = "button"
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
	public var tag = "script"
	public var attributes: HTMLAttributes = .init()
	public var children = [HTMLRenderable]()

	private var code: String?
	private var file: String?

	/// Designated initializer
	/// - Parameter code: A string that represents a piece of JS code
	public init(_ code: String) {
		self.code = code
	}

	/// Designated initializer
	/// - Parameter code: A string that represents the source file for a JS file
	public init(file: String) {
		self.file = file
	}

	public func render(indent: String) -> String {
		if let code {
			let indentedCode = code
				.split(separator: "\n")
				.map { "\(indent)\($0)" }
				.joined(separator: "\n")

			return "\(indent)<script>\n\(indentedCode)\n\(indent)</script>\n"
		}
		else if let file {
			let currentDir = URL(filePath: FileManager.default.currentDirectoryPath)
			let rootDir = currentDir.findProjectRoot(startingAt: currentDir)

			if !FileManager.default.fileExists(atPath: rootDir.path() + "Assets/\(file)") {
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
	public var tag = ""
	public var attributes: HTMLAttributes = .init()
	public var children = [HTMLRenderable]()

	private let content: String

	/// Designated initializer
	/// - Parameter content: A string that represents the text
	public init(_ content: String) {
		self.content = content
	}

	public func render(indent: String) -> String {
		return "\(indent)\(content)\n"
	}
}
