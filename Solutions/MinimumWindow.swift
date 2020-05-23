//
//  MinimumWindow.swift
//  AlgoStackQueue
//
//  Created by Shukla, Jageen on 2020/05/18.
//  Copyright © 2020 Shukla, Jageen. All rights reserved.
//

import Foundation

/**
 Question: Given a string S and a string T, find the minimum window in S which will contain all the characters in T (matching or exceeding in frequency) in complexity O(n).

 Anytime we have time reduced to linear time and we know that much must be done, that is indicative of using some sort of auxiliary structure to keep track of information for us so time can stay low in complexity.

 Complexities

 s = length of search string
 t = length of "pattern" or "character" string

 Time: O( s + t )
 At worst we will touch each element twice, once by the left pointer and once by the right pointer.

 Ex:
 s = "aaaaat"
 t = "t"
 
  
 */

class MinWindow {
    /// Hold input value, i.e. s
    private var _input: String = "";
    /// Target string pattern need to be found in _input, i.e. t
    private var _target: String = "";
    
    /// Hold current window
    private var _curWindow: String = "";
    private var ans:Int?;
    
    /**
     Initialize object.
     - Parameters:
        - input: String in wich to find string pattern.
        - target: String pattern need tobe found in input.
     */
    init(input:String, target:String) {
        self._input = input;
        self._target = target;
    }

    /**
     Calculate window size
     - Returns: minimum window size. If any.
     */
    func calculate() -> Int? {
        var L = 0;
        var R = 0;
        
        while (L <= _input.count && R <= _input.count) {
            
            let sIndex = _input.index(_input.startIndex, offsetBy: L)
            let eIndex = _input.index(_input.startIndex, offsetBy: R)
            let range = sIndex..<eIndex;
            _curWindow = String(_input[range]);

            if(isSatisfied()) {
                let curAns = R - L;
                if let _ans = self.ans,
                    _ans > curAns {
                    self.ans = curAns
                } else {
                    self.ans = curAns;
                }
                
                L = L + 1;
            } else {
                R = R + 1;
            }
        }

        return ans;
    }

    /**
     Check whether current widnow is satisfied or not.
     - Returns: result off validation
     */
    private func isSatisfied() -> Bool {
        let _mapping: NSCountedSet = NSCountedSet();
        
        for ch in _target {
            _mapping.add(ch)
        }
        
        for ch in _curWindow {
            _mapping.remove(ch);
        }
        
        return (_mapping.count == 0);
    }
}

/**
 t : ct
 s : aabbct
 w : ct
 
 */
