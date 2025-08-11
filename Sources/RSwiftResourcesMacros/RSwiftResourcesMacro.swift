import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct RStringMacro: ExpressionMacro {
    public static func expansion(of node: some SwiftSyntax.FreestandingMacroExpansionSyntax, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> SwiftSyntax.ExprSyntax {
        guard let argument = node.arguments.first?.expression else {
            throw CustomError.message("Missing string key")
        }
        return ExprSyntax("R.string.localizable.\(argument)")
    }
}

public struct RImageMacro: ExpressionMacro {
    public static func expansion(of node: some SwiftSyntax.FreestandingMacroExpansionSyntax, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> SwiftSyntax.ExprSyntax {
        guard let argument = node.arguments.first?.expression else {
            throw CustomError.message("Missing image name")
        }
        return ExprSyntax("R.image.\(argument)")
    }
}

enum CustomError: Error, CustomStringConvertible {
    case message(String)
    var description: String {
        switch self {
            case .message(let msg):
                return msg
        }
    }
}


@main
struct RSwiftResourcesPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        RImageMacro.self,
        RStringMacro.self
    ]
}
