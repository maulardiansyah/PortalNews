//
//  User.swift
//  News
//
//  Created by Maul on 17/02/22.
//

struct User: Codable {
    let id: Int?
    let name, username, email, phone: String?
    let address: UserAddress?
    let company: UserCompany?
}

struct UserAddress: Codable {
    let street, city: String?
}

struct UserCompany: Codable {
    let name: String?
}
