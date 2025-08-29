//
//  Extensions.swift
//
//
//  Created by Luki on 04/11/2024.
//

import Foundation

extension Process {
	@discardableResult
	static func execute(command: String) throws -> String {
		let process = Process()
		process.arguments = ["-c", command]
		process.executableURL = .init(filePath: "/bin/zsh")

		let output = Pipe()
		process.standardOutput = output

		do {
			try process.run()
		}
		catch {
			print("❌ Error running process: \(error.localizedDescription)")
		}

		let data = try output.fileHandleForReading.readToEnd() ?? Data()
		return String(decoding: data, as: UTF8.self)
	}
}
