//
//  jwtModel.swift
//  
//
//  Created by Allie Griffin on 2023-02-20.
//  Resource: https://docs.vapor.codes/security/jwt

import JWT

struct WingJWTPayload: JWTPayload {
    // Maps the longer Swift property to keys
    enum CodingKeys: String, CodingKey {
        case expiration = "exp"
    }

    // The expiration time claim identifies the expiration time on
    // or after which the JWT MUST NOT be accepted for processing.
    var expiration: ExpirationClaim


    func verify(using signer: JWTSigner) throws {
        try self.expiration.verifyNotExpired()
    }
}
