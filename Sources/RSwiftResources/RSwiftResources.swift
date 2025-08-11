// The Swift Programming Language
// https://docs.swift.org/swift-book

@freestanding(expression)
public macro RImage(_ name: Any) -> Any = #externalMacro(module: "RSwiftResourcesMacros", type: "RImageMacro")

@freestanding(expression)
public macro RString(_ name: Any) -> Any = #externalMacro(module: "RSwiftResourcesMacros", type: "RStringMacro")
