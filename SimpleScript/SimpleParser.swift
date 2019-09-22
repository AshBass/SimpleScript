//
//  SimpleParser.swift
//  SimpleScript
//
//  Created by Harry Houdini on 2019/9/19.
//  Copyright © 2019 CrimsonHo. All rights reserved.
//

import Foundation

class SimpleParser {
    
    func parser(tokensReader: TokensReader) -> ASTNode? {
        return additionOrSubtraction(tokensReader: tokensReader)
    }
    
    /// 数字表达式
    private func primary(tokensReader: TokensReader) -> ASTNode? {
        var node:ASTNode? = nil
        var token:Token? = tokensReader.peek()
        if (token != nil) {
            if (token!.tokenType == .IntLiteral) {
                token = tokensReader.read()
                node = ASTNode.init(aToken: token)
            }else if (token!.tokenType == .Identifier) {
                token = tokensReader.read()
                node = ASTNode.init(aToken: token)
            }else if (token!.tokenType == .LeftParen) {
                token = tokensReader.read()
                node = additionOrSubtraction(tokensReader: tokensReader)
                if (node != nil) {
                    token = tokensReader.peek()
                    if (token != nil && token!.tokenType == .RightParen) {
                        token = tokensReader.read()
                    }else {
                        /// 报错
                    }
                }else {
                    /// 报错
                }
            }
        }
        return node
    }
    
    /// 乘除
    private func multiplicationOrDivision(tokensReader: TokensReader) -> ASTNode? {
        let child1:ASTNode? = primary(tokensReader: tokensReader)
        var node:ASTNode? = child1
        
        var token:Token? = tokensReader.peek()
        if (child1 != nil && token != nil) {
            if (token!.tokenType == .Star || token!.tokenType == .Slash) {
                token = tokensReader.read()
                let child2:ASTNode? = primary(tokensReader: tokensReader)
                if (child2 != nil) {
                    node = ASTNode.init(aToken: token)
                    node?.leftChild = child1
                    node?.rightChild = child2
                }else {
                    /// 报错
                }
            }
        }
        return node
    }
    
    /// 加减
    private func additionOrSubtraction(tokensReader: TokensReader) -> ASTNode? {
        let child1:ASTNode? = multiplicationOrDivision(tokensReader: tokensReader)
        var node:ASTNode? = child1
        
        var token:Token? = tokensReader.peek()
        if (child1 != nil && token != nil) {
            if (token!.tokenType == .Plus || token!.tokenType == .Minus) {
                token = tokensReader.read()
                let child2:ASTNode? = additionOrSubtraction(tokensReader: tokensReader)
                if (child2 != nil) {
                    node = ASTNode.init(aToken: token)
                    node?.leftChild = child1
                    node?.rightChild = child2
                }else {
                    /// 报错
                }
            }
        }
        
        return node
    }
    
}

