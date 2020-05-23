//
//  Stack.swift
//  AlgoStackQueue
//
//  Created by Shukla, Jageen on 2020/05/14.
//  Copyright © 2020 Shukla, Jageen. All rights reserved.
//

import Foundation

protocol StackProtocols {
    associatedtype Element
    /**
     Push data into stack
     - Parameters:
        - data: data you want to push into stack
     */
    func push(data:Element) -> Void;

    /**
     Remove data from stack and return it.
     - Returns: Deleted data, if any.
     */
    func pop() -> Element?;
    
    /**
     Get data from stack.
     - Returns: Data from stack, if any.
     */
    func peek() -> Element?;
}

/**
 Represent generic stack data type.
 Which will store Int datatype.
 */
class Stack <Element>: StackProtocols {
    /// Hold collection of data
    private var _list: Array<Element> = [];
    
    func push(data: Element) {
        _list.append(data);
    }
    
    func pop() -> Element? {
        guard !_list.isEmpty else {
            return nil
        }
        
        return _list.removeLast();
    }
    
    func peek() -> Element? {
        return _list.last;
    }
    
    /// Show all data from curren stack
    func display() {
        for index in (0..<_list.count).reversed() {
            print(_list[index]);
        }
    }
}
