//
//  ASTNode.swift
//  SimpleScript
//
//  Created by Harry Houdini on 2019/9/22.
//  Copyright © 2019 CrimsonHo. All rights reserved.
//

import Foundation

class ASTNode {
    var parent:ASTNode? = nil
    var leftChild:ASTNode? = nil
    var rightChild:ASTNode? = nil
    var token:Token? = nil
    
    init(aToken: Token?) {
        token = aToken
    }
    
    func outputAST() -> Void {
        outputNode(node: self)
    }
    
    private func outputNode(node: ASTNode) -> Void {
        if (node.token != nil) {
            print("\(node.token!.tokenType) \(node.token!.text)")
            if (node.leftChild != nil) {
                outputNode(node: node.leftChild!)
            }
            if (node.rightChild != nil) {
                outputNode(node: node.rightChild!)
            }
        }
    }
}
