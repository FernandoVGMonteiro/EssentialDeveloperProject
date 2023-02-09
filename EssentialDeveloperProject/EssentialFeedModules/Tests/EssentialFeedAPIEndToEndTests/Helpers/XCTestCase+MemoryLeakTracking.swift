//
//  XCTestCase+MemoryLeakTracking.swift
//
//
//  Created by Fernando Monteiro on 02/02/23.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been dealocated. Potential memory leak.", file: file, line: line)
        }
    }
}
