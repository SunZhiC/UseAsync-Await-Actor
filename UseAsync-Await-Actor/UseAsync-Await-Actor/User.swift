//
//  User.swift
//  TestGet
//
//  Created by SuniMac on 2022/6/12.
//

import Foundation

public struct User: Codable {
    public var id: Int
    public var login: String
    public var name: String?
    public var hireable: Bool?
    public var location: String?
    public var bio: String?
}
