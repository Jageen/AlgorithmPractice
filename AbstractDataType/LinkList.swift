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
class LinkList <Element> {
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
        var start: LinkList<Element>? = head;
        while(start != nil) {
            print(start?.describe() ?? "null");
            start = start?.next
        }
    }
}
