//
//  LTMorphingLabelDemoTests.swift
//  LTMorphingLabelDemoTests
//
//  Created by Lex on 6/18/14.
//  Copyright (c) 2014 LexTang.com. All rights reserved.
//

import XCTest

class LTMorphingLabelDemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStringDiff1() {
        let diffResults = "he" >> "hello"
        XCTAssert(diffResults[0].diffType == LTCharacterDiffType.Same, "First character isn't changed.")
        XCTAssert(diffResults[2].diffType == .Add, "Third character is added.")
    }
    
    func testStringDiff2() {
        let diffResults = "news" >> "westen"
        XCTAssert(diffResults[0].diffType == .MoveAndAdd, "n is moved.")
        XCTAssert(diffResults[0].moveOffset == 5, "n is moved right for 5 steps, not \(diffResults[0].moveOffset).")
        XCTAssert(diffResults[2].diffType == .MoveAndAdd, "w is moved.")
        XCTAssert(diffResults[2].moveOffset == -2, "w is moved left for 2 steps, not \(diffResults[2].moveOffset).")
        XCTAssert(diffResults[4].diffType == .Add, "2nd e is added.")
        XCTAssert(diffResults[5].skip, "The last n was moved in.")
    }
    
    func testStringDiff3() {
        let diffResults = "Enchanté" >> "Swifter"
        
        XCTAssert(diffResults[4].diffType == .Replace, "a is deleted.")
    }
    
    func testStringDiff4() {
        let diffResults = "wo" >> "ox"
        XCTAssert(diffResults[0].diffType == .Replace, "w is replaced.")
        XCTAssert(diffResults[1].diffType == .MoveAndAdd, "o is moved and add a new character.")
    }
    
    func testStringDiff5() {
        let diffResults = "Objective-C" >> "iPhone"
        XCTAssert(diffResults[0].diffType == .Replace, "w is replaced.")
        XCTAssert(diffResults[3].diffType == .MoveAndAdd, "e is moved and add a new character.")
        XCTAssert(diffResults[8].diffType == .Delete, "2nd e is deleted.")
    }
    
    func testStringDiff6() {
        let diffResults = "wow" >> "newwow"
        XCTAssert(diffResults[2].diffType == .MoveAndAdd, "2nd. w is moved.")
    }
    
    func testLongDiffPerformance() {
        self.measureBlock() {
            let lhs = "Design is not just what it looks like and feels like. Design is how it works."
            let rhs = "Innovation distinguishes between a leader and a follower."
            let diffResults = lhs >> rhs
        }
    }
    
}
