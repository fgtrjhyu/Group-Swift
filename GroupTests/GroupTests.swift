//
//  GroupTests.swift
//  Group
//
//  Created by fgtrjhyu on 2015/04/06.
//  Copyright (c) 2015年 fgtrjhyu. All rights reserved.
//

import UIKit
import XCTest
import Group

class GroupTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        let g = Group<Int>(equivalent:==)
        g.add(4, 5, 1, 2, 3, 2, 3, 1, 3, 2, 4)
        var actual: [[Int]] = []
        for r in g {
            var mactual: [Int] = []
            for m in r {
                if m === r.first {
                    print(">\(m.value)");
                } else {
                    print(",\(m.value)");
                }
                mactual.append(m.value)
            }
            println()
            actual.append(mactual)
        }
        XCTAssertEqual(
            [[4, 4], [5], [1, 1], [2, 2, 2], [3, 3, 3]],
            actual,"")
    }
    
}
