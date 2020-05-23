//
//  MaxStack.swift
//  AlgoStackQueue
//
//  Created by Shukla, Jageen on 2020/05/15.
//  Copyright © 2020 Shukla, Jageen. All rights reserved.
//

import Foundation

/**
 Represet maximum value in stack
 */
class MaxValue {
    /// Hold max value
    var value: Int = Int.min;
    /// Hold number of count max value occured.
    var count: Int = 0;
}

/**
 Represent extended version of Stack.
 support extra operation max().
 It will return max element from stack in O(1) time complexity.
 */
class MaxStack: Stack<Int> {
    private var _cacheMax: Stack<MaxValue> = Stack <MaxValue>();
    
    override func push(data: Int) {
        super.push(data: data);
        
        if let _max = _cacheMax.peek() {
            if (_max.value == data) {
                _max.count = _max.count + 1;
            } else if (_max.value < data) {
                let newMax = MaxValue();
                newMax.value = data;
                newMax.count = 1;
                _cacheMax.push(data: newMax);
            }
        } else {
            let newMax = MaxValue();
           newMax.value = data;
           newMax.count = 1;
           _cacheMax.push(data: newMax);
        }
    }
    
    override func pop() -> Int? {
        let poped = super.pop();
        
        if let _max = _cacheMax.peek() {
            if (_max.value == poped) {
                _max.count = _max.count - 1;
            }
            
            if (_max.count == 0) {
                let _ = _cacheMax.pop();
            }
        }
        
        return poped;
    }
    
    /**
     Get max value of current stack
     - Returns: Maximum value, if any.
     */
    func max() -> Int? {
        return _cacheMax.pop()?.value;
    }
}
