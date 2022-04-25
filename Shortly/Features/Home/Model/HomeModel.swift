//
//  ShortcodeLink.swift
//  Shortly
//
//  Created by Hamit Seyrek on 25.04.2022.
//

import Foundation

struct MainResult: Decodable {
    let ok: Bool
    let errorCode: Int?
    let error: String?
    let result: SingleResult?
    
    enum CodingKeys: String, CodingKey {
        case ok, error, result
        case errorCode = "error_code"
    }
}

struct SingleResult: Decodable {
    let code, fullShortLink2, originalLink: String
    
    enum CodingKeys: String, CodingKey {
        case code
        case fullShortLink2 = "full_short_link2"
        case originalLink = "original_link"
    }
}

/*
 {
 "ok": true,
 "result": {
     "code": "ZgTCDD",
     "full_short_link2": "https://9qr.de/ZgTCDD",
     "original_link": "http://example.org/very/long/link.html"
    }
 }
 */
