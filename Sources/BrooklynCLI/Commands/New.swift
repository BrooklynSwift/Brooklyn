//
//  New.swift
//  Brooklyn
//
//  Created by Luki on 07/03/2025.
//

import ArgumentParser
import class Foundation.FileManager
import class Foundation.Process

struct NewCommand: ParsableCommand {
	static let configuration = CommandConfiguration(
		commandName: "new",
		abstract: "Creates a new Brooklyn website in a folder of your choosing."
	)

	@Option(name: .shortAndLong, help: .templateHelp)
	var template = "https://github.com/BrooklynSwift/BrooklynEmptyTemplate"

	@Argument(help: .folderHelp)
	var folderName: String

	func run() throws {
		guard template.starts(with: "https://") else {
			print("❌ The template url must start with https://")
			return
		}

		guard !FileManager.default.fileExists(atPath: "./\(folderName)") else {
			print("❌ The directory '\(folderName)' already exists; quitting.")
			return
		}

		try Process.execute(command: "git clone \(template) \(folderName)")
		print("✅ Success!")
	}
}

private extension ArgumentHelp {
	static let templateHelp: ArgumentHelp = "The git repository to clone."
	static let folderHelp: ArgumentHelp = "The name of the subfolder where you want the new website to be created, which must not currently exist."
}
