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
    
    /// Hold parent node value.
    fileprivate var parent: BSTNode?
    
    /// Print tree structure
    var description: String {
        return "\(value)"
    }
    
    /// Return miminum value node from it's sub stree
    fileprivate var miminum: BSTNode {
        var _minNode = self;
        self.travel { (aNode) -> Bool in
            if(_minNode.value > aNode.value) {
                _minNode = aNode;
            }
            return true;
        }
        return _minNode;
    }
    
    /// Return maximum value node from it's sub stree
    fileprivate var maximum: BSTNode {
        var _minNode = self;
        self.travel { (aNode) -> Bool in
            if(_minNode.value < aNode.value) {
                _minNode = aNode;
            }
            return true;
        }
        return _minNode;
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
    
    init(node:BSTNode) {
        self.value = node.value;
        self.left = node.left;
        self.right = node.right;
        self.parent = node.parent;
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
    
    /**
     Delink node.
     - Parameters:
        - aNode: Node you want to delink, pass nill if you want to delink self.
     
     - Returns:
     
     If you pass child node to delink it will not dive deeper but instead only check of immidiate child (i.e left or right
     */
    fileprivate func delink() -> BSTNode? {
        
        if(self.left !== nil && self.right !== nil) {
            let newTarget = self.right!.miminum;
            self.value = newTarget.value;
            return newTarget.delink();
        } else {
            if let _parent = self.parent {
                _parent.delink(aNode: self);
                return self;
            } else {
                print("Deleting root");
                return nil;
            }
        }
    }
    
    private func delink(aNode: BSTNode) {
        if(self.left === aNode) {
            self.left = aNode.left ?? aNode.right;
        } else if (self.right === aNode) {
            self.right = aNode.left ?? aNode.right;
        }
    }
}

/**
 Represent Binary search tree
 */
class BSTree {
    /// Hold root node
    var root: BSTNode
    
    /// return minimum node from binary serch tree
    var minimum: BSTNode {
        return root.miminum;
    }
    
    /// return maximum node from binary serch tree
    var maximum: BSTNode {
        return root.maximum;
    }
    
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
        if(parentNode.value > value) {
            parentNode.left = newNode
        } else {
            parentNode.right = newNode;
        }
        newNode.parent = parentNode;
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
            if(tmpRoot!.value > aNode.value) {
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
    
    /**
     Remove value from binary search tree
     - Parameters:
        - value: value you want to delete.
     */
    func delete(value:Int) {
        let valueNode:BSTNode? = self.search(target: value)
        var nodeForDelete:BSTNode? = valueNode?.delink() ?? self.root;
        
        // If root is going to delete
        if(nodeForDelete === self.root) {
            print("Root node is changed")
            self.root = nodeForDelete?.left ?? nodeForDelete?.right ?? BSTNode(value: 0);
        }
        nodeForDelete = nil;
    }
    
    /**
     Delete node from binary search tree
     - Parameters:
        aNode: Node you want to delete from tree
     */
//    private func delete( aNode:inout BSTNode?) {
//        guard let _aNode = aNode else {
//            return;
//        }
//
//        if let _parent = _aNode.parent {
//            _parent.delink(aNode: _aNode)
//        } else {
//            // Its root not
//            print("Root node deleted")
//            _aNode.delink(aNode:_aNode);
//        }
////        if(_aNode.left == nil && _aNode.right == nil) {
////            _aNode.parent?.delink(aNode: _aNode);
////            aNode = nil;
////        } else if(_aNode.left == nil && _aNode.right != nil) {
////            if(_aNode.parent!.value > _aNode.value) {
////                _aNode.parent?.left = _aNode.right;
////            } else {
////                _aNode.parent?.right = _aNode.right;
////            }
////            aNode = nil;
////        } else if(_aNode.left != nil && _aNode.right == nil) {
////            if(_aNode.parent!.value > _aNode.value) {
////                _aNode.parent?.left = _aNode.left;
////            } else {
////                _aNode.parent?.right = _aNode.left;
////            }
////            aNode = nil;
////        } else if (_aNode.left != nil && _aNode.right != nil) {
////            var min: BSTNode? = _aNode.right!.miminum;
////            _aNode.value = min!.value;
////            self.delete(aNode: &min);
////        }
//    }
}
