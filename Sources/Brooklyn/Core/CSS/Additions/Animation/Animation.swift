//
//	Animation.swift
//
//
//  Created by Luki on 15/10/2024.
//

import Foundation

/// A struct that represents a CSS animation
public struct CSSAnimation {
	internal let name: String
	internal let duration: Duration

	internal var timingFunction: TimingFunction = .ease()
	internal var delay: Duration = .s(0)
	internal var iterationCount = 1
	internal var direction: Direction = .normal

	internal var description: String {
		var animationPieces = [name, duration.rawValue]

		if timingFunction != .ease() {
			animationPieces.append(timingFunction.rawValue)
		}
		if delay != .s(0) || delay != .ms(0) {
			animationPieces.append(delay.rawValue)
		}
		if iterationCount != 1 {
			animationPieces.append("\(iterationCount)")
		}
		if direction != .normal {
			animationPieces.append(direction.rawValue)
		}

		return animationPieces.compactMap { $0 }.joined(separator: " ")
	}

	/// Designated initializer
	/// - Parameters:
	///		- name: A string that represents the animation's name
	///		- duration: A `Duration` object that represents the animation's duration
	///		- timingFunction: A `TimingFunction` object that represents the animation's timing function
	///		- delay: A `Duration` object that represents the animation's delay
	///		- iterationCount: An integer that represents the animation's iteration count
	///		- direction: A `Direction` object that represents the animation's direction
	public init(
		name: String,
		duration: Duration,
		timingFunction: TimingFunction = .ease(),
		delay: Duration = .s(0),
		iterationCount: Int = 1,
		direction: Direction = .normal
	) {
		self.name = name
		self.duration = duration
		self.timingFunction = timingFunction
		self.delay = delay
		self.iterationCount = iterationCount
		self.direction = direction
	}
}
