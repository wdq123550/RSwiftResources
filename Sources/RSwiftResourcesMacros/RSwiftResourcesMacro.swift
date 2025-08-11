import SwiftCompilerPlugin
import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct RStringMacro: ExpressionMacro {
    public static func expansion(of node: some SwiftSyntax.FreestandingMacroExpansionSyntax, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> SwiftSyntax.ExprSyntax {
        // 验证参数格式
        guard let identifier = node.arguments.first?.expression.as(DeclReferenceExprSyntax.self) else {
            fatalError("宏参数必须是标识符（非字符串）")
        }
        // 生成 R.string.localizable.xxx 表达式
        return "R.string.localizable.\(raw: identifier.baseName.text)"
    }
}

public struct RImageMacro: ExpressionMacro {
    public static func expansion(of node: some SwiftSyntax.FreestandingMacroExpansionSyntax, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> SwiftSyntax.ExprSyntax {
        // 验证参数格式
        guard let identifier = node.arguments.first?.expression.as(DeclReferenceExprSyntax.self) else {
            fatalError("宏参数必须是标识符（非字符串）")
        }
        // 生成 R.image.xxx 表达式
        return "R.image.\(raw: identifier.baseName.text)"
    }
}


@main
struct RSwiftResourcesPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        RImageMacro.self,
        RStringMacro.self
    ]
}
