//
//  ContentView.swift
//  Edutainment
//
//  Created by Isaque da Silva on 10/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingSteps = false
    @State private var steps = 1
    
    @State private var startGame = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            if showingSteps == false {
                VStack {
                    Text("Welcome to Edutainment")
                        .font(.title.bold())
                    Text("The perfect space for fun and learning 😉")
                        .frame(width: 300)
                        .font(.headline.bold())
                        .multilineTextAlignment(.center)
                    
                    Button("Play", action: {
                        withAnimation {
                            showingSteps = true
                        }
                    })
                    .buttonStyle(.borderedProminent)
                    
                    VStack {
                        
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
