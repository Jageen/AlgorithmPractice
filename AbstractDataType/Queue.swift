//
//  Queue.swift
//  AlgoStackQueue
//
//  Created by Shukla, Jageen on 2020/05/14.
//  Copyright © 2020 Shukla, Jageen. All rights reserved.
//

import Foundation

protocol QueueProtocol {
    /**
    Enqueue data into queue
    - Parameters:
       - data: data you want to enqueue into queue
    */
    func enqueue(data:Int) -> Void;
    /**
    Remove data from queue and return it.
    - Returns: Deleted data, if any.
    */
    func dequeue() -> Int?;
    /**
    Get data from queue.
    - Returns: Data from stack, if any.
    */
    func peek() -> Int?
}
