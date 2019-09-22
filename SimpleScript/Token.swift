//
//  Token.swift
//  AshSimpleLexer
//
//  Created by Harry Houdini on 2019/9/19.
//  Copyright © 2019 CrimsonHo. All rights reserved.
//

import Foundation

enum TokenType {
    case Unknow
    case Identifier
    /// 数字类型
    case IntLiteral
    
    case Assignment
    
    /// Int 类型状态
    case Int
    /// > >=
    case GT
    case GE
    /// 加减乘除
    case Plus
    case Minus
    case Star
    case Slash
    
    /// 分号
    case SemiColon
    
    /// 括号
    case LeftParen
    case RightParen
}

class Token {
    var text = ""
    var tokenType:TokenType = .Unknow
}

class TokensReader {
    var position = 0
    private var array = [Token]()
    
    func addToken(token: Token) -> Void {
        array.append(token)
    }
    
    func peek() -> Token? {
        if position >= array.count {
            return nil
        }
        return array[position]
    }
    
    func read() -> Token? {
        if position >= array.count {
            return nil
        }
        let token = array[position]
        position += 1
        return token
    }
    
    func count() -> Int {
        return array.count
    }
}

