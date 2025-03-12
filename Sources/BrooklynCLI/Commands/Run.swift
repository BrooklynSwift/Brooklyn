//
//  Run.swift
//  Brooklyn
//
//  Created by Luki on 07/03/2025.
//

import ArgumentParser
import Foundation

private let fileWatcher = FileWatcher(paths: [FileManager.default.currentDirectoryPath + "/Sources/"])

struct RunCommand: ParsableCommand {
	static let configuration: CommandConfiguration = CommandConfiguration(
		commandName: "run",
		abstract: "Builds the current website & runs it on a local http server."
	)

	@Flag(help: .forceHelp)
	var force = false

	@Flag(help: .watchHelp)
	var watch = false

	@Option(name: .shortAndLong, help: .portHelp)
	var port = 1337

	@Option(name: .shortAndLong, help: .browserHelp)
	var browser = "Safari"

	func run() throws {
		if watch {
			watchFiles()
		}

		if force {
			let pid = getRunningServerPID()
			Process.execute(command: "kill \(pid)")
		}

		Process.execute(command: "swift run")
		Process.execute(command: "python3 -m http.server -d Build/ \(port)")
	}

	private func watchFiles() {
		fileWatcher.callback = {
			Process.execute(command: "swift run")

			guard let reloadCurrentTabScript = NSAppleScript(source: reloadCurrentTab(onBrowser: browser)) else { return }
			reloadCurrentTabScript.executeAndReturnError(nil)
		}
		fileWatcher.start()
	}

	private func getRunningServerPID() -> String {
		return Process.execute(command: "lsof -t -i tcp:\(port)")
	}

	private func reloadCurrentTab(onBrowser browser: String) -> String {
		return """
		tell application "\(browser)"
			set currentTab to current tab of front window
			set URL of currentTab to (URL of currentTab)
		end tell
		"""
	}
}

private extension ArgumentHelp {
	static let portHelp: ArgumentHelp = "The port number to run the http local server on."
	static let forceHelp: ArgumentHelp = "Wether to force quit any currently running http server before starting another one."
	static let watchHelp: ArgumentHelp = "Wether to watch for file changes in your source code, better known as \"live reloading\"."
	static let browserHelp: ArgumentHelp = "The browser on which to reload the current tab, for live reloading."
}
