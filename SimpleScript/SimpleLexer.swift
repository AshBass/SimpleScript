//
//  SimpleLexer.swift
//  AshSimpleLexer
//
//  Created by Harry Houdini on 2019/9/19.
//  Copyright © 2019 CrimsonHo. All rights reserved.
//

import Foundation

enum SimpleLexerState {
    /// 初始状态
    case Initial
    
    ///
    case Identifier
    
    /// 数字类型
    case IntLiteral
    
    case Assignment
    
    /// Int 类型状态
    case Int1
    case Int2
    case Int3
    
    /// = >=
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

class SimpleLexer {
    
    var nowState = SimpleLexerState.Initial
    var token:Token? = nil
    
    private func initToken(aCharacter: Character) -> Void {
        if (isBlank(aCharacter: aCharacter)) {
            nowState = .Initial
            return
        }
        
        token = Token.init()
        token?.text += String(aCharacter)
        
        if (isAlpha(aCharacter: aCharacter)) {
            if (aCharacter == "i") {
                nowState = .Int1
            }else {
                nowState = .Identifier
            }
            token?.tokenType = .Identifier
        }else if (isDigit(aCharacter: aCharacter)) {
            nowState = .IntLiteral
            token?.tokenType = .IntLiteral
        }else if (aCharacter == ">") {
            nowState = .GT
            token?.tokenType = .GT
        }else if (aCharacter == "+") {
            nowState = .Plus
            token?.tokenType = .Plus
        }else if (aCharacter == "-") {
            nowState = .Minus
            token?.tokenType = .Minus
        }else if (aCharacter == "*") {
            nowState = .Star
            token?.tokenType = .Star
        }else if (aCharacter == "/") {
            nowState = .Slash
            token?.tokenType = .Slash
        }else if (aCharacter == ";") {
            nowState = .SemiColon;
            token?.tokenType = .SemiColon;
        }else if (aCharacter == "(") {
            nowState = .LeftParen;
            token?.tokenType = .LeftParen;
        }else if (aCharacter == ")") {
            nowState = .RightParen;
            token?.tokenType = .RightParen;
        }else if (aCharacter == "=") {
            nowState = .Assignment;
            token?.tokenType = .Assignment;
        }else {
            nowState = .Initial;
        }
        
    }
    
    func parse(word: String) -> TokensReader {
        token = nil
        nowState = SimpleLexerState.Initial
        
        let tokensReader = TokensReader.init()
        for aCharacter in word {
            switch nowState   {
            case .Initial:
                initToken(aCharacter: aCharacter)
            case .Identifier :
                if (isAlpha(aCharacter: aCharacter)) {
                    token?.text += String(aCharacter)
                }else {
                    tokensReader.addToken(token: token!)
                    initToken(aCharacter: aCharacter)
                }
            case .IntLiteral:
                if (isDigit(aCharacter: aCharacter)) {
                    token?.text += String(aCharacter)
                }else {
                    tokensReader.addToken(token: token!)
                    initToken(aCharacter: aCharacter)
                }
            case .Int1:
                if (isAlpha(aCharacter: aCharacter) || isDigit(aCharacter: aCharacter)) {
                    if (aCharacter == "n") {
                        nowState = .Int2
                    }else {
                        nowState = .Identifier
                    }
                    token?.text += String(aCharacter)
                }else {
                    tokensReader.addToken(token: token!)
                    initToken(aCharacter: aCharacter)
                }
            case .Int2:
                if (isAlpha(aCharacter: aCharacter) || isDigit(aCharacter: aCharacter)) {
                    if (aCharacter == "t") {
                        nowState = .Int3
                    }else {
                        nowState = .Identifier
                    }
                    token?.text += String(aCharacter)
                }else {
                    tokensReader.addToken(token: token!)
                    initToken(aCharacter: aCharacter)
                }
            case .Int3:
                if (isBlank(aCharacter: aCharacter)) {
                    nowState = .Initial
                    token?.tokenType = .Int
                    tokensReader.addToken(token: token!)
                }else if (isAlpha(aCharacter: aCharacter) || isDigit(aCharacter: aCharacter)) {
                    nowState = .Identifier
                    token?.tokenType = .Identifier
                    token?.text += String(aCharacter)
                }else {
                    tokensReader.addToken(token: token!)
                    initToken(aCharacter: aCharacter)
                }
            case .GT:
                if (aCharacter == "=") {
                    nowState = .GE
                    token?.text += String(aCharacter)
                }else {
                    tokensReader.addToken(token: token!)
                    initToken(aCharacter: aCharacter)
                }
            case .GE:
                token?.tokenType = .GE
                tokensReader.addToken(token: token!)
                initToken(aCharacter: aCharacter)
            case .Plus:
                token?.tokenType = .Plus
                tokensReader.addToken(token: token!)
                initToken(aCharacter: aCharacter)
            case .Minus:
                token?.tokenType = .Minus
                tokensReader.addToken(token: token!)
                initToken(aCharacter: aCharacter)
            case .Star:
                token?.tokenType = .Star
                tokensReader.addToken(token: token!)
                initToken(aCharacter: aCharacter)
            case .Slash:
                token?.tokenType = .Slash
                tokensReader.addToken(token: token!)
                initToken(aCharacter: aCharacter)
            case .SemiColon:
                token?.tokenType = .SemiColon
                tokensReader.addToken(token: token!)
                initToken(aCharacter: aCharacter)
            case .LeftParen:
                token?.tokenType = .LeftParen
                tokensReader.addToken(token: token!)
                initToken(aCharacter: aCharacter)
            case .RightParen:
                token?.tokenType = .RightParen
                tokensReader.addToken(token: token!)
                initToken(aCharacter: aCharacter)
            case .Assignment:
                token?.tokenType = .Assignment
                tokensReader.addToken(token: token!)
                initToken(aCharacter: aCharacter)
            }
        }
        if (token != nil) {
            tokensReader.addToken(token: token!)
        }
        return tokensReader
    }

    
    private func isDigit(aCharacter: Character) -> Bool {
        return (aCharacter >= "0" && aCharacter <= "9")
    }
    
    private func isAlpha(aCharacter: Character) -> Bool {
        return ((aCharacter >= "A" && aCharacter <= "Z") || (aCharacter >= "a" && aCharacter <= "z"))
    }
    
    private func isBlank(aCharacter: Character) -> Bool {
        return ((aCharacter == " ") || (aCharacter == "\n") || (aCharacter == "\t"))
    }
}
