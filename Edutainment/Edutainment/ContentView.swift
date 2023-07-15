//
//  ContentView.swift
//  Edutainment
//
//  Created by Isaque da Silva on 10/07/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSteps = false
    @State private var gameIsOn = false
    @State private var step = 0
    
    //choices view
    @ViewBuilder var choices: some View {
        VStack{
            Text(showingSteps ? "Before starting the game:" : "")
                .font(.title2.bold())
            
            if step == 1 {
                TextModifier(text: "What difficulty level would you like to tackle?")
            }
            
            if step == 2 {
                TextModifier(text: "How many questions would you like to answer?")
            }
            
            Button(step == 1 ? "Next" : "Start Game", action: {
                if step == 1 {
                    step += 1
                } else {
                    showingSteps = false
                    gameIsOn = true
                }
            })
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: 350, maxHeight: showingSteps ? 250 : 0)
        .background(.thinMaterial)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack {
                Text(gameIsOn == false ? "Welcome to Edutainment" : "")
                    .font(.title.bold())
                
                if showingSteps == false && gameIsOn == false {
                    TextModifier(text: "The perfect space for fun and learning at the same time 😉")
                    
                    Button("Play", action: {
                        withAnimation {
                            showingSteps = true
                            step = 1
                        }
                    })
                    .buttonStyle(.borderedProminent)
                }
                
                choices
                    .frame(maxWidth: 350, maxHeight: showingSteps ? 250 : 0)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
