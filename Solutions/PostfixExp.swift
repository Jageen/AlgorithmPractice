//
//  PostfixExp.swift
//  AlgoStackQueue
//
//  Created by Shukla, Jageen on 2020/05/16.
//  Copyright © 2020 Shukla, Jageen. All rights reserved.
//

import Foundation


/**
 Class to perform postfix operation
 */
class PostfixExp {
    
    /// Hold value of input string
    private var _input = "";
    /// Hold stack to process expression
    private var stack = Stack<Int>();
    /// Hold list of supported operators
    private let operators = ["+", "-", "*", "/"];
    
    /**
     Initialize object.
     - Parameters:
        - exp: postfix expression
     */
    init(exp:String) {
        self._input = exp;
    }
    
    /**
     Validate given expression.
     - Returns: validation result
     */
    private func validate() -> Bool {
        // TODO: write validation loginc
        return true;
    }
    /**
     Calculate expression.
     - Returns: result, If any.
     */
    func calculate() -> Int? {
        
        guard self.validate() else { // return nil, if exp is not valid
            return nil;
        }

        // Itterate string
        for ch in _input {
            
            let sCh = ch.uppercased();
            // If its num
            if let aNum = Int(sCh) { // Push into stack
                self.stack.push(data: aNum);
            } else if operators.contains(sCh) { // Perform operation
                if let values = self.stack.lastToNum(),
                    let sum = PostfixExp.utl_performCal(val1: values.val1, op: sCh, val2: values.val2) {
                    self.stack.push(data: sum);
                } else { // invlaid state
                    return nil;
                }
            } else {// invlaid state
                return nil;
            }
        }
        // --
        return self.stack.pop();
    }
    
    /**
     Utility method to perform arithmetic operations.
     - Parameters:
        - val1: First operand
        - op: Operator
        - val2 : Second operand
     */
    static private func utl_performCal(val1: Int, op: String, val2: Int) -> Int? {
        var sum: Int?;
        
        switch op {
        case "+":
            sum = val1 + val2;
            break;
        case "-":
            sum = val1 - val2;
            break;
        case "*":
            sum = val1 * val2;
            break;
        case "/":
            if(val2 == 0) {
                return nil;
            }
            sum = val1 / val2;
            break;
        default:
            sum = nil;
        }
        return sum;
    }
}


extension Stack {
    func lastToNum() -> (val1:Element, val2:Element)? {
        
        guard let v1 = self.pop() else {
            return nil;
        }
        guard let v2 = self.pop() else {
            return nil;
        }
        
        return (v1,v2);
    }
}
