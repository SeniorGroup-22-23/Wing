//
//  Utils.swift
//  Wing
//
//  Created by Bryn Haines on 2023-11-22.
//

import Foundation
import CryptoKit

func encryptString(message: String, key: SymmetricKey) throws -> Data {
    guard let messageData = message.data(using: .utf8) else {
        throw EncryptionError.invalidMessage
    }
    
    let sealedBox = try AES.GCM.seal(messageData, using: key)
    return sealedBox.combined!
}

func decryptData(encryptedData: Data, key: SymmetricKey) throws -> String {
    let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
    let decryptedData = try AES.GCM.open(sealedBox, using: key)
    
    guard let decryptedString = String(data: decryptedData, encoding: .utf8) else {
        throw DecryptionError.invalidDecryptedData
    }
    
    return decryptedString
}

func generateSymmetricKey() -> SymmetricKey {
    return SymmetricKey(size: .bits256)
}

enum EncryptionError: Error {
    case invalidMessage
}

enum DecryptionError: Error {
    case invalidDecryptedData
}
