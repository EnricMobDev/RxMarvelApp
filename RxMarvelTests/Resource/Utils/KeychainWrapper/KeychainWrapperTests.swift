//
//  KeychainWrapperTests.swift
//  RxMarvelTests
//
//  Created by Enric Pou Villanueva on 05/11/2019.
//  Copyright © 2019 Enric Pou Villanueva. All rights reserved.
//

import XCTest
@testable import RxMarvel

class KeychainManagerTests: XCTestCase {
    var keychain: KeychainManager!

    override func setUp() {
        self.keychain = KeychainManager(key: "Own password test")
    }

    func testAddStringValueInKeychain() {
        // given
        self.keychain.storeString(value: "Foo value")
        // when
        let keychainValue = self.keychain.readStringValue()
        //then
        XCTAssertTrue(keychainValue == "Foo value")
    }

    func testRemoveValueInKeychain() {
        // given
        self.keychain.storeString(value: "Foo value")
        // when
        self.keychain.remove()
        //then
        let keychainValue = self.keychain.readStringValue()
        XCTAssertTrue(keychainValue == "")
    }
}
