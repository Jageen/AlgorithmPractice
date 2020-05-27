//
//  Tree.swift
//  AlgorithmPractice
//
//  Created by Shukla, Jageen | Jageen | AIPD on 2020/05/25.
//  Copyright © 2020 Shukla, Jageen. All rights reserved.
//

import Foundation

class TNode<Element>: CustomStringConvertible {

    /// Hold value of tree node
    var value:Element;
    
    /// Hold child nodes.
    var children:Array<TNode<Element>> = []
    
    /// Hold reference of parent node
    var parent:TNode<Element>?
    
    /// Indicate is it root node or not.
    var isRoot:Bool {
        get {
            return (self.parent != nil)
        }
    }
    
    /// Print tree structure
    var description: String {
        var text = "\(value)"
        if !children.isEmpty {
            text += " {" + children.map { $0.description }.joined(separator: ", ") + "} "
        }
        return text
    }

    /**
     Initialize object.
     - Parameters:
        - value: value of node.
        - childrens: list of childrens
     */
    init(value:Element, children:Array<TNode<Element>>?) {
        self.value = value;
        if let _children = children {
            self.children = _children;
        }
    }
    
    /**
     Add child nodes
     - Parameters:
        - node: Child node
     */
    func addChild(node:TNode<Element>) -> Void {
        self.children.append(node);
        node.parent = self;
    }
    
    /**
     Trave in tree structure.
     Travel will start from current node will go deeper.
     
     First it will visit self then look for children.
     
     - Parameters:
        - completion: callback witch will pass travelled node as parameter. And in return it will ask abuot it should continue travel or not. Default is true.
     */
    func travel(completion: ((_ element:TNode<Element>) -> Bool)? = nil) -> Void {
        if let _ = completion?(self) {
            for aChild in self.children {
                aChild.travel(completion: completion);
            }
        }
    }
}
