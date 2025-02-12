import SwiftSyntax
import SwiftSyntaxMacros
import SwiftCompilerPlugin

public struct HTMLCoreTypeMacro: MemberMacro {
	private enum MacroError: String, Error {
		case notAStruct = "@HTMLCoreType must not be applied to a non struct object"
	}

	public
	static func expansion(
		of node: AttributeSyntax,
		providingMembersOf declaration: some DeclGroupSyntax,
		in context: some MacroExpansionContext
	) throws -> [DeclSyntax] {
		guard let structDecl = declaration.as(StructDeclSyntax.self) else { throw MacroError.notAStruct.rawValue }

		let structName = structDecl.name.text
		let tag = structName != "Text" ? structName.lowercased() : ""

		let newMembers = """
		public var tag = "\(tag)"
		public var attributes: HTMLAttributes = .init()
		public var children = [HTMLRenderable]()

		public init(@HTMLBuilder _ children: () -> [HTMLRenderable]) {
			self.children = children()
		}
		"""

		return [DeclSyntax(stringLiteral: newMembers)]
	}
}

@main
private struct HTMLComponentPlugin: CompilerPlugin {
	let providingMacros: [Macro.Type] = [HTMLCoreTypeMacro.self]
}

extension String: @retroactive Error {}
