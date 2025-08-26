//
//  WebsiteManager.swift
//
//
//  Created by Luki on 09/10/2024.
//

import Foundation

@MainActor
internal
final class WebsiteManager {
	private
	static var instance: WebsiteManager?

	static var shared: WebsiteManager {
		guard let instance else { fatalError("WebsiteManager.shared accessed before calling configure(file:)") }
		return instance
	}

	static func configure(file: StaticString) {
		guard instance == nil else { return }
		instance = WebsiteManager(file: file)
		instance?.cleanBuildDirectory()
		instance?.copyAssets()
		instance?.copyFonts()
	}

	// MARK: - Private

	private let assetsDirectory, buildDirectory, fontsDirectory: URL

	private init(file: StaticString) {
		let rootDir: URL = .findProjectRoot(from: file)
		assetsDirectory = rootDir.appending(path: "Assets/")
		buildDirectory = rootDir.appending(path: "Build/")
		fontsDirectory = rootDir.appending(path: "Fonts/")
	}

	private func cleanBuildDirectory() {
		do {
			try FileManager.default.removeItem(at: buildDirectory)
			try FileManager.default.createDirectory(at: buildDirectory, withIntermediateDirectories: true)
		}
		catch {
			print(error.localizedDescription)
		}
	}

	private func copyAssets() {
		guard FileManager.default.fileExists(atPath: assetsDirectory.path(percentEncoded: false)) else { return }

		do {
			let assets = try FileManager.default.contentsOfDirectory(at: assetsDirectory, includingPropertiesForKeys: nil)
			try assets.forEach {
				try FileManager.default.copyItem(
					at: assetsDirectory.appending(path: $0.lastPathComponent),
					to: buildDirectory.appending(path: $0.lastPathComponent)
				)
			}
		}
		catch {
			print(error.localizedDescription)
		}
	}

	private func copyFonts() {
		guard FileManager.default.fileExists(atPath: fontsDirectory.path(percentEncoded: false)) else { return }

		do {
			let fonts = try FileManager.default.contentsOfDirectory(at: fontsDirectory, includingPropertiesForKeys: nil)

			let buildFontsDir = buildDirectory.appending(path: "Fonts/")
			try FileManager.default.createDirectory(at: buildFontsDir, withIntermediateDirectories: true)

			try fonts.forEach {
				try FileManager.default.copyItem(
					at: fontsDirectory.appending(path: $0.lastPathComponent),
					to: buildFontsDir.appending(path: $0.lastPathComponent)
				)
			}
		}
		catch {
			print(error.localizedDescription)
		}
	}
}
