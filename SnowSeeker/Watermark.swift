//
//  Watermark.swift
//  SnowSeeker
//
//  Created by Yuri Gerasimchuk on 30.07.2022.
//

import SwiftUI

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text("Photo by \(text)")
                .font(.footnote)
                .fontWeight(.black)
                .padding(8)
                .foregroundColor(.white)
                .background(.black.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 2))
                .padding(5)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}
