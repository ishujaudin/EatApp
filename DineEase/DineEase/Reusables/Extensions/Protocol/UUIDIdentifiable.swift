//
//  UUIDIdentifiable.swift
//  DineEase
//
//  Created by Shuja on 19/08/2025.
//

import Foundation

protocol UUIDIdentifiable: Identifiable {

    var id: UUID { get }
}
