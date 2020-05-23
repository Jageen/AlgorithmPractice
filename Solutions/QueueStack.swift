//
//  QueueStack.swift
//  AlgoStackQueue
//
//  Created by Shukla, Jageen on 2020/05/14.
//  Copyright © 2020 Shukla, Jageen. All rights reserved.
//

import Foundation


/**
 Queue implemented using stack.
 */
class QueueStack: QueueProtocol {
    /// Hold reference of stack, used to enqueue operation
    private var _enqueueStack:Stack<Int> = Stack<Int>();
    /// Hold reference of stack, used to dequeue operation
    private var _dequeueStack:Stack<Int> = Stack<Int>();
    
    func enqueue(data: Int) {
        _enqueueStack.push(data: data);
    }
    
    func dequeue() -> Int? {
        
        // 1. Read data from dequeue
        if let removed = _dequeueStack.pop() {
            return removed;
        }
        
        // 2. Try to feel it from enqueue.
        self.utl_copyEnqueueIntoDequeue();
        
        // Try again.
        if let removed = _dequeueStack.pop() {
            return removed;
        }
        
        // Else nill
        return nil;
    }
    
    /// Utility function to copy all element from enqueue into dequeue
    private func utl_copyEnqueueIntoDequeue() {
        while(_enqueueStack.peek() != nil) {
            _dequeueStack.push(data: _enqueueStack.pop()!);
        }
    }
    
    func peek() -> Int? {
        self.utl_copyEnqueueIntoDequeue();
        return _dequeueStack.peek();
    }
    
    /// Show all data from curren stack
    func display() {
        self.utl_copyEnqueueIntoDequeue();
        _dequeueStack.display();
    }
}
