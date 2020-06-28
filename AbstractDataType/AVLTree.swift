//
//  AVLTree.swift
//  AlgorithmPractice
//
//  Created by Shukla, Jageen | Jageen | AIPD on 2020/06/07.
//  Copyright © 2020 Shukla, Jageen. All rights reserved.
//

import Foundation


/**
 Represent AVL tree.
 An Extended version of binary search tree.
 Where tree is balanced. (i.e it's left node's and righ node's diff's absulate value is <= 1.
 */
class AVLTree: BSTree {
    @discardableResult
    override func addValue(value: Int) -> BSTNode {
        let nNode = super.addValue(value: value);
        print("Insert : \(nNode.description)");
        
        if let imbalancedNode = self.getImbalancedNode(frmNode: nNode) { // If found imbalancedNode
            self.balanceNode(targetNode: imbalancedNode);
        }
        return nNode;
    }
    
    /**
     Get first imbalanced node from give node.
     - Parameters:
        - frmNode: BSTNode from which you want to start serach
     
     It will start from given node and go upwords.
     */
    private func getImbalancedNode(frmNode:BSTNode) -> BSTNode? {
        var nTravel: BSTNode? = frmNode;
        var imbalancedNode: BSTNode? = nil;
        while nTravel != nil {
            if(nTravel?.isBalanced == false) {
                imbalancedNode = nTravel;
                break;
            }
            nTravel = nTravel!.parent;
        }
        print("Imbalance node : \(imbalancedNode?.description ?? "nil")")
        return imbalancedNode;
    }
    
    /**
     Balance given node
     */
    private func balanceNode(targetNode:BSTNode) {
        guard targetNode.isBalanced == false else {
            return;
        }
        
        let leftHeight = targetNode.left?.height ?? 0;
        let rightHeight = targetNode.right?.height ?? 0;
        
        if(leftHeight > rightHeight) {
            print("Perform right rotation")
            self.rightRotate(node: targetNode);
        } else {
            print("Perform left rotation")
            self.leftRotate(node: targetNode);
        }
    }
}
