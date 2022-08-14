//
//  Owner.swift
//  GithubAPI
//
//  Created by Subodh Mahajan on 13/08/22.
//

import Foundation

struct Owner: Codable {
    let title: String?
    let createdAt: String?
    let closedAt: String?
    let user: User?
    
    enum CodingKeys: String, CodingKey {
        case title
        case createdAt = "created_at"
        case closedAt = "closed_at"
        case user
    }
}

struct User: Codable {
    let login: String?
    let avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}
