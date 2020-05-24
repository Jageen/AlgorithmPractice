//
//  CloneLinkList.swift
//  AlgorithmPractice
//
//  Created by Shukla, Jageen | Jageen | AIPD on 2020/05/24.
//  Copyright © 2020 Shukla, Jageen. All rights reserved.
//

/*
 Problem : Create solution for cloning linklist.
 
 Note : Node will contain two pointer one is nextNode, Which is pointing to next node of link list and another is random which randomly point to any node (object of linklist).
 
 Make sure cloned linklist contain same value of random property.
 */

import Foundation

/**
 Represent extended version of linklist.
 Extended linklist with random property.
 */
class LinkListExt: LinkList<Int> {

    /// Point to random linkList object
    var random:LinkListExt?
    
    /**
     Clone current link list.
     - Returns: cloned linklist.
     - Complexity:
        - time: O(n)
        - space O(1)
     */
    func clone() -> LinkListExt? {
        
        var head:LinkListExt? = self;
        // Trave each node
        while head != nil {
            head = head?.next as? LinkListExt;
        }
        return nil;
    }
    
    override func describe() -> String {
        var desc = super.describe();
        
        if let _rand = self.random {
            desc = "\(desc) \nrand: \(_rand.value)";
        }
        
        return desc;
    }
}
