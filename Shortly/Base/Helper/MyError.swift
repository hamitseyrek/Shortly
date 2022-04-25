//
//  MyError.swift
//  Shortly
//
//  Created by Hamit Seyrek on 25.04.2022.
//

import Foundation

struct MyError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}
