//
//  LinkList.swift
//  AlgoStackQueue
//
//  Created by Shukla, Jageen on 2020/05/24.
//  Copyright © 2020 Shukla, Jageen. All rights reserved.
//

import Foundation

/**
 Represent link list datatype
 */
class LinkList <Element>: NSObject {
    /// Store value
    var value:Element;
    /// Store pointer of next node
    var next: LinkList<Element>?;
    
    /**
     Initialize object with value and it's next node.
     - Parameters:
        - value: value of object.
        - next: Node for next pointer.
     */
    init(value:Element, next:LinkList?) {
        self.value = value;
        self.next = next
    }
    
    /**
     Describe current node
     */
    func describe() -> String {
        let desc = "val: \(self.value)"
        return desc;
    }
    
    /**
     Travel linkklit from given head and print it's value
     - Parameters:
        - head: Head pointer. i.e. starting position
     */
    static func travel(head:LinkList<Element>) {
        /// A object which will travel each node.
        var traveler: LinkList<Element>? = head;
        
        /// A faster traveler, created to detect cycle in linklist.
        var rabbit = traveler;
        while(traveler != nil) {
            print(traveler?.describe() ?? "null")
            traveler = traveler?.next
            rabbit = rabbit?.next?.next
            
            if(traveler != nil &&
                rabbit == traveler) {
                print("Break travel. \nDetected cycle in current linklist.");
                break;
            }
        }
    }
}
