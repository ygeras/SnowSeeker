//
//  Facitlity.swift
//  SnowSeeker
//
//  Created by Yuri Gerasimchuk on 29.07.2022.
//

import SwiftUI

struct Facility: Identifiable {
    let id = UUID()
    let name: String
    
    private let icons = [
        "Accommodation": "house",
        "Beginners": "1.circle",
        "Cross-country": "map",
        "Eco-friendly": "leaf.arrow.circlepath",
        "Family":  "person.3"
    ]
    
    private let descriptions = [
        "Accommodation": "This resort has a popular on-site accommodation.",
        "Beginners": "This resort has lots of ski schools.",
        "Cross-country": "This resort has many cross-country ski routes",
        "Eco-friendly": "This resort has woon an award for environmental friendliness.",
        "Family":  "This resort is popular with families"
    ]
    
    var icon: some View {
        if let iconName = icons[name] {
            return Image(systemName: iconName)
                .accessibilityLabel(name)
                .foregroundColor(.secondary)
        } else {
            fatalError("Unknown facility type \(name)")
        }
    }
    
    var description: String {
        if let message = descriptions[name] {
            return message
        } else {
            fatalError("Unknown facility type: \(name)")
        }
    }
}
