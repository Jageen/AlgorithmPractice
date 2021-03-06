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

    /// Hold parent node value.
    internal var parent: BSTNode?

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
    
    /**
     Indicate whether given tree is balanced or not.
     */
    internal var isBalanced:Bool {
        get {
            let leftHeight = self.left?.height ?? -1
            let rightHeight = self.right?.height ?? -1
            let diff = abs(leftHeight - rightHeight)
            return (diff <= 1);
        }
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
        print(aNode.description);
        return true;
    }
    
    /// Hold node value
    var value: Int;
    /// Represent left child
    var left: BSTNode?
    /// Represent right child
    var right: BSTNode?
    
    /// Print tree structure
    var description: String {
        var des = "\(value)";
        
        if let _p = self.parent {
            des = "\(des) : |P|->\(_p.value)"
        } else {
            des = "\(des) : |P|->nil"
        }
        
        if let _l = self.left {
            des = "\(des) : |L|->\(_l.value)"
        } else {
            des = "\(des) : |L|->nil"
        }
        
        if let _r = self.right {
            des = "\(des) : |R|->\(_r.value)"
        } else {
            des = "\(des) : |R|->nil"
        }
        
        return des
    }
    
    /**
     Return height of tree.
     
     It will calculate height from self node.
     i.e It will return max(leftNodeHight, rightNodeHeight) + 1.
     If either left or right node is null it will consider their height as -1.
     */
    var height: Int {
        let leftChildHegiht = self.left?.height ?? -1
        let rightChildHegiht = self.right?.height ?? -1
        
        let maxChildHeight = max(leftChildHegiht, rightChildHegiht);
        return maxChildHeight + 1;
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
     Delink child node from self.
     - Parameters:
        - aNode: Node you want to delink self from.
     
     It will only delink immidiate child (left or right), i.e It not going to dive deeprer to find node.
     */
    private func delink(aNode: BSTNode) {
        if(self.left === aNode) {
            self.left = aNode.left ?? aNode.right;
        } else if (self.right === aNode) {
            self.right = aNode.left ?? aNode.right;
        }
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
     
     - Returns: Node which is delinked from, nill in case of no parent exists.
     
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
                return nil;
            }
        }
    }
    
    /**
     Peform left rotation
     */
    fileprivate func leftRotate() -> BSTNode? {
        if let _ = self.right?.left {
            self.right = self.right?.rightRotate();
        }
        
        // If It does not have right child then return
        guard var rightChild = self.right else {
            return nil;
        }
        
        if let _ = rightChild.left {
            rightChild = rightChild.rightRotate() ?? rightChild;
        }
        
        if let _pRight = self.parent?.right,
        _pRight.value == self.value{
            self.parent?.right = rightChild;
        }
        
        if let _pLeft = self.parent?.left,
        _pLeft.value == self.value{
            self.parent?.left = rightChild;
        }
        
        rightChild.parent = self.parent;
        rightChild.left = self;
        self.parent = rightChild;
        self.right = nil;
        
        return rightChild;
    }
    
    /**
     Peform right rotation
     */
    fileprivate func rightRotate() -> BSTNode? {
        if let _ = self.left?.right {
            self.left = self.left?.leftRotate();
        }
        
        // If It does not have left child then return
        guard var leftChild = self.left else {
            return nil;
        }
        
        if let _ = leftChild.right {
            leftChild = leftChild.leftRotate() ?? leftChild;
        }
        

        // TODO: Decide to chose left or right
        if let _pRight = self.parent?.right,
        _pRight.value == self.value{
            self.parent?.right = leftChild;
        }
        
        if let _pLeft = self.parent?.left,
        _pLeft.value == self.value{
            self.parent?.left = leftChild;
        }
        
        leftChild.parent = self.parent;
        leftChild.right = self;
        self.parent = leftChild;
        self.left = nil;
        return leftChild;
    }
}

/**
 Represent Binary search tree
 */
class BSTree {
    /// Hold root node
    var root: BSTNode?
    
    /// return minimum node from binary serch tree
    var minimum: BSTNode? {
        return root?.miminum;
    }
    
    /// return maximum node from binary serch tree
    var maximum: BSTNode? {
        return root?.maximum;
    }
    
    /**
     Return height of tree
     
     Return -1 if root is null (i.e tree is empty)
     */
    var height: Int {
        return root?.height ?? -1;
    }
    
    /**
    Indicate whether given tree is balanced or not.
    */
    var isBalanced:Bool {
        get {
            return self.root?.isBalanced ?? false;
        }
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
     Search for place where given node can added as child node
     - Parameters:
        - aNode: a Node for which you want to search place.
     */
    private func searchForPlace(aNode:BSTNode) -> BSTNode? {
        
        var tmpRoot:BSTNode? = root;
        var parentNode: BSTNode? = root;
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

    /**
     Add new node into binary tree
     - Parameters: new node
     */
    @discardableResult
    func addValue(value:Int) -> BSTNode {
        let newNode = BSTNode(value: value);
        if let parentNode = self.searchForPlace(aNode: newNode) {
            if(parentNode.value > value) {
                parentNode.left = newNode
            } else {
                parentNode.right = newNode;
            }
            newNode.parent = parentNode;
        } else {
            root = newNode;
        }
        return newNode;
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
        guard let _root = self.root else{
            return nil;
        }
        var searchedNode:BSTNode? = nil;
        
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
            self.root = nodeForDelete?.left ?? nodeForDelete?.right
        }
        nodeForDelete = nil;
    }
    
    /**
     Rotate give node to left
     - Parameters:
        - node: Node you want to rotate. It will consider root in case of nill
     */
    func leftRotate(node: BSTNode?) -> Void {
        let targetNode = node ?? self.root;
        
        guard targetNode != nil else {
            return;
        }
        let rotatedNode = targetNode?.leftRotate();
        
        if(rotatedNode?.parent == nil) {
            self.root = rotatedNode;
        }
    }
    
    /**
    Rotate give node to right
    - Parameters:
       - node: Node you want to rotate. It will consider root in case of nill
    */
    func rightRotate(node: BSTNode?) -> Void {
        let targetNode = node ?? self.root;
        
        guard targetNode != nil else {
            return;
        }
        
        let rotatedNode = targetNode?.rightRotate();
        
        if(rotatedNode?.parent == nil) {
            self.root = rotatedNode;
        }
    }
}
