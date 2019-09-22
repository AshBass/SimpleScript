//
//  main.swift
//  SimpleScript
//
//  Created by Harry Houdini on 2019/9/19.
//  Copyright © 2019 CrimsonHo. All rights reserved.
//

import Foundation

var script = " int a = 10;"

let lexer = SimpleLexer.init()

var tokensReader = lexer.parse(word: script)


while (tokensReader.peek() != nil)
{
    let token = tokensReader.read()
    print("token \(token!.tokenType) \(token!.text)")
}


script = " 2 + 3 * 5"

tokensReader = lexer.parse(word: script)

let parser = SimpleParser.init()

var rootNode:ASTNode? = parser.parser(tokensReader: tokensReader)

rootNode?.outputAST()

