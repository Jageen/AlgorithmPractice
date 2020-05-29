//
//  BSTree.swift
//  AlgorithmPractice
//
//  Created by Shukla, Jageen | Jageen | AIPD on 2020/05/29.
//  Copyright © 2020 Shukla, Jageen. All rights reserved.
//

/*
 let btree = BSTree(value:9);
 btree.addValue(value: 5);
 btree.addValue(value: 15);
 
 btree.addValue(value: 1);
 btree.addValue(value: 8);
 
 btree.addValue(value: 11);
 btree.addValue(value: 20);
 
 btree.addValue(value: 100);
 
 let sNode = btree.search(target: 110);
 print(sNode ?? "Not found")
 */
import Foundation

class BSTNode: CustomStringConvertible {
    /// Hold node value
    var value: Int;
    /// Represent left child
    var left: BSTNode?
    /// Represent right child
    var right: BSTNode?
    
    /// Print tree structure
    var description: String {
        return "\(value)"
    }
    
    /// Default completion for travel method
    static private let defCompletion = { (aNode:BSTNode) -> Bool in
        print("\(aNode) : |L|->\(aNode.left?.description ?? "nil") |R|->\(aNode.right?.description ?? "nil")");
        return true;
    }
    
    /**
     Initiallize node.
     - Parameters:
        value: node value.
     */
    init(value:Int) {
        self.value = value;
    }
    
    /**
     Travel Binary tree from given node
     - Parameters:
        - completion: Call when travel a node. It's return value will indicate whether to continue travel or not ?
     */
    fileprivate func travel(completion: ((_ element:BSTNode) -> Bool) = defCompletion) -> Void {
        if completion(self) {
            self.left?.travel(completion:completion);
            self.right?.travel(completion:completion);
        }
    }
}

/**
 Represent Binary search tree
 */
class BSTree {
    var root: BSTNode
    
    /**
     Initialize Binary tree with given value.
     - Parameters:
        - value: value you want to assign to root node
     */
    init(value: Int) {
        root = BSTNode(value: value);
    }
    /**
     Add new node into binary tree
     - Parameters: new node
     */
    func addValue(value:Int) {
        let newNode = BSTNode(value: value);
        let parentNode = self.searchForPlace(aNode: newNode);
        if(parentNode.value >= value) {
            parentNode.left = newNode
        } else {
            parentNode.right = newNode;
        }
    }
    
    /**
     Search for place where given node can added as child node
     - Parameters:
        - aNode: a Node for which you want to search place.
     */
    private func searchForPlace(aNode:BSTNode) -> BSTNode {
        
        var tmpRoot:BSTNode? = root;
        var parentNode: BSTNode = root;
        while tmpRoot != nil {
            parentNode = tmpRoot!;
            if(tmpRoot!.value >= aNode.value) {
                tmpRoot = tmpRoot!.left;
            } else {
                tmpRoot = tmpRoot!.right;
            }
        }
        return parentNode;
    }
    
    func travel() -> Void {
        let tmpRoot: BSTNode? = root;
        tmpRoot?.travel();
    }
    
    /**
     Search value in binary tree.
     - Parameters:
        - target: Target integer value, you want to search in a tree.
        It will return first node found with given value.
     */
    func search(target: Int) -> BSTNode? {
        var searchedNode:BSTNode? = nil;
        let _root = self.root;
        
        _root.travel { (aNode) -> Bool in
            if(aNode.value == target) {
                searchedNode = aNode;
            }
            return (searchedNode == nil)
        }
        
        return searchedNode;
    }
}
