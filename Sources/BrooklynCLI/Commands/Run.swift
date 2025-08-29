//
//  Run.swift
//  Brooklyn
//
//  Created by Luki on 07/03/2025.
//

import ArgumentParser
import Foundation

struct RunCommand: ParsableCommand {
	static let configuration: CommandConfiguration = CommandConfiguration(
		commandName: "run",
		abstract: "Builds the current website & runs it on a local http server."
	)

	@Flag(help: .watchHelp)
	var watch = false

	@Option(name: .shortAndLong, help: .portHelp)
	var port = 1337

	@Option(name: .shortAndLong, help: .browserHelp)
	var browser: Browser = .safari

	enum Browser: String, ExpressibleByArgument {
		case safari, chrome
	}

	func run() throws {
		if watch {
			watchFiles()
		}

		if let pid = getRunningServerPID() {
			print("🛑 Killing existing running server on port \(port) ⇝ PID: \(pid)")
			try Process.execute(command: "kill \(pid)")
		}

		print("✅ Starting local web server on http://localhost:\(port)")
		print("🔗 Open http://\(getLocalIPAddress()):1337 to view the website on your phone\n")

		try Process.execute(command: "swift run")
		try Process.execute(command: "python3 -m http.server -d Build/ \(port)")
	}

	private func getRunningServerPID() -> String? {
		guard let output = try? Process.execute(command: "lsof -t -i tcp:\(port)") else { return nil }
		return output.isEmpty ? nil : output
	}

	private func reloadTabScript() -> String {
		let activeTab = browser == .safari ? "current tab" : "active tab"

		return """
		tell application "\(browser.rawValue)"
			set currentTab to \(activeTab) of front window
			set URL of currentTab to (URL of currentTab)
		end tell
		"""
	}

	private func watchFiles() {
		FileMonitor.shared.onFileMonitor = {
			do {
				try Process.execute(command: "swift run")

				guard let reloadCurrentTabScript = NSAppleScript(source: reloadTabScript()) else { return }
				reloadCurrentTabScript.executeAndReturnError(nil)
			}
			catch {
				print(error.localizedDescription)
			}
		}
		FileMonitor.shared.startMonitoring()
	}
}

private extension RunCommand {
	private func getLocalIPAddress() -> String {
		var interfaceAddressPointer: UnsafeMutablePointer<ifaddrs>?
		guard getifaddrs(&interfaceAddressPointer) == 0, let firstPointer = interfaceAddressPointer else { return "" }

		defer { freeifaddrs(interfaceAddressPointer) }
		let interfaces = sequence(first: firstPointer) { $0.pointee.ifa_next }

		for interface in interfaces {
			let addr = interface.pointee.ifa_addr.pointee
			let addressFamily = addr.sa_family

			if addressFamily == UInt8(AF_INET) {
				let interfaceName = String(cString: interface.pointee.ifa_name)

				if interfaceName != "lo0" {
					var hostNameBuffer = [CChar](repeating: 0, count: Int(NI_MAXHOST))
					getnameinfo(
						interface.pointee.ifa_addr,
						socklen_t(MemoryLayout<sockaddr_in>.size),
						&hostNameBuffer,
						socklen_t(hostNameBuffer.count),
						nil,
						0,
						NI_NUMERICHOST
					)

					let ipAddressBytes = hostNameBuffer.prefix { $0 != 0 }.map { UInt8(bitPattern: $0) }
					return String(decoding: ipAddressBytes, as: UTF8.self)
				}
			}
		}
		return ""
	}
}

private extension ArgumentHelp {
	static let portHelp: ArgumentHelp = "The port number to run the http local server on."
	static let watchHelp: ArgumentHelp = "Wether to watch for file changes in your source code, better known as \"live reloading\"."
	static let browserHelp: ArgumentHelp = "The browser on which to reload the current tab, for live reloading."
}
