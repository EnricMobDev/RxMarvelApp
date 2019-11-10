//
//  KeychainWrapper.swift
//  RxMarvel
//
//  Created by Enric Pou Villanueva on 05/11/2019.
//  Copyright © 2019 Enric Pou Villanueva. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

final class KeychainManager {
    private var key = ""

    init(key: String) {
        self.key = key
    }

    func storeString(value: String) {
        KeychainWrapper.standard.set(value, forKey: key, withAccessibility: .whenPasscodeSetThisDeviceOnly)
    }

    func readStringValue() -> String {
        guard let storedInformation = KeychainWrapper.standard.string(forKey: key) else { return "" }
        return storedInformation
    }

    func remove() {
        KeychainWrapper.standard.removeObject(forKey: key)
    }
}
