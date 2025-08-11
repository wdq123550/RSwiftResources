import SwiftCompilerPlugin
import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct RStringMacro: ExpressionMacro {
    public static func expansion(of node: some SwiftSyntax.FreestandingMacroExpansionSyntax, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> SwiftSyntax.ExprSyntax {
        guard let arg = node.arguments.first?.expression else {
            throw MacroError.message("Missing string key")
        }
        // 去掉多余空格和换行
        let name = arg.description.trimmingCharacters(in: .whitespacesAndNewlines)
        // 如果是 "xxx" 形式，去掉引号
        let cleanedName = name.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
        return "R.string.localizable.\(raw: cleanedName)"
    }
}

public struct RImageMacro: ExpressionMacro {
    public static func expansion(of node: some SwiftSyntax.FreestandingMacroExpansionSyntax, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> SwiftSyntax.ExprSyntax {
        guard let arg = node.arguments.first?.expression else {
            throw MacroError.message("Missing image name")
        }
        let name = arg.description.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedName = name.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
        return "R.image.\(raw: cleanedName)"
    }
}

enum MacroError: Error, CustomStringConvertible {
    case message(String)
    var description: String {
        switch self {
        case .message(let msg): return msg
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
