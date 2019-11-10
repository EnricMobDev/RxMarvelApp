//
//  String.swift
//  RxMarvel
//
//  Created by Enric Pou Villanueva on 05/11/2019.
//  Copyright © 2019 Enric Pou Villanueva. All rights reserved.
//

import Foundation
import CommonCrypto
 
extension String {
    func md5Hash (parameters: String) -> String {
        guard let dataParameters = parameters.data(using: String.Encoding.utf8) else { return "" }
        
        var digest = [UInt8](repeating: 0, count:Int(CC_MD5_DIGEST_LENGTH))
        var md5String = ""

        //The Marvel Api requires MD5 Decryption
        dataParameters.withUnsafeBytes {
            CC_MD5($0.baseAddress, UInt32(dataParameters.count), &digest)
        }
        
        for byte in digest {
            md5String += String(format:"%02x", UInt8(byte))
        }
        return md5String
    }
}
