//
//  BrooklynCLI.swift
//
//
//  Created by Luki on 13/10/2024.
//

import ArgumentParser

@main
private struct BrooklynCLI: AsyncParsableCommand {
	static let configuration = CommandConfiguration(
		commandName: "brooklyn",
		abstract: "A CLI tool to manage Brooklyn websites.",
		version: "0.1.0",
		subcommands: [NewCommand.self, RunCommand.self]
	)
}
