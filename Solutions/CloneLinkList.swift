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
 
 Sample code
 
 let node1 = LinkListExt(value: 1, next: nil, random: nil)
 let node2 = LinkListExt(value: 2, next: nil, random: nil)
 let node3 = LinkListExt(value: 3, next: nil, random: nil)
 let node4 = LinkListExt(value: 4, next: nil, random: nil)
 
 node1.next = node2;
 node1.random = node2;
 
 node2.next = node3;
 node2.random = node2;
 
 node3.next = node4;
 node3.random = node2;
 
 node4.random = node2;
 
 let clone = node1.clone();
 LinkListExt.travel(head: clone);
 
 Output
 [1] -> [2] | random -> [2]
 [2] -> [3] | random -> [2]
 [3] -> [4] | random -> [2]
 [4] -> [null] | random -> [2]
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
     Initialize object with value and it's next node.
     - Parameters:
        - value: value of object.
        - next: Node for next pointer.
     */
    init(value:Int, next:LinkListExt?, random:LinkListExt?) {
        super.init(value: value, next: next);
        self.random = random;
    }
    
    init(node:LinkListExt) {
        super.init(value: node.value, next: node.next);
        self.random = node.random;
    }

    /**
     Clone current link list.
     - Returns: cloned linklist.
     - Complexity:
        - time: O(n)
        - space O(1)
     */
    func clone() -> LinkListExt {
        
        var cur:LinkListExt? = self;
        var cloneHead: LinkListExt? = nil;
        
        // Travel to create clone
        while cur != nil {
            let cloned = LinkListExt(node: cur!);
            cloned.next = cur!.next;
            cur?.next = cloned;
            
            if(cloneHead == nil) { // Set clone head
                cloneHead = cloned;
            }
            
            cur = cloned.next as? LinkListExt;
        }
        
        // Travel to fix random pointer
        cur = self;
        while cur != nil {
            let cloned = cur?.next as? LinkListExt;
            cloned?.random = cur?.random?.next as? LinkListExt;
            cur = cur?.next?.next as? LinkListExt;
        }
        
        // Travel to fix next pointer
        cur = self;
        while cur != nil {
            let cloned = cur?.next as? LinkListExt;
            cur?.next = cloned?.next;
            cloned?.next = cloned?.next?.next;

            cur = cur?.next as? LinkListExt;
        }

        return cloneHead!;
    }
    
    override func describe() -> String {
        var desc = super.describe();
        
        if let _rand = self.random {
            desc = "\(desc) | random -> [\(_rand.value)]";
        }
        
        return desc;
    }
}
