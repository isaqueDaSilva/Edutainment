//
//  TextModifier.swift
//  Edutainment
//
//  Created by Isaque da Silva on 15/07/23.
//

import SwiftUI

struct TextModifier: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.headline.bold())
            .multilineTextAlignment(.center)
    }
}
