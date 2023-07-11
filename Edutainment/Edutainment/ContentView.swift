//
//  ContentView.swift
//  Edutainment
//
//  Created by Isaque da Silva on 10/07/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSteps = false
    @State private var step = 1
    
    @State private var startGame = false
    
    @State private var tableSelect = "1"
    
    let tables = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    @ViewBuilder var stepButton: some View {
        VStack {
            Button("Next", action: {
                step += 1
            })
            .buttonStyle(.borderedProminent)
        }
    }
    
    @ViewBuilder var choices: some View {
        VStack {
            Spacer()
            Text("Before starting the game:")
                .font(.title3.bold())
            
            Spacer()
            
            if step == 1 {
                Text("Select which multiplication table do you want to practice?")
                    .font(.headline.bold())
                    .multilineTextAlignment(.center)
                
                Picker("Table", selection: $tableSelect) {
                    ForEach(tables, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
            }
            
            Spacer()
            
            stepButton
            Spacer()
        }
        .frame(maxWidth: 350, maxHeight: 250)
        .padding(.vertical, 20)
        .background(.thinMaterial)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
    
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
                    
                    choices
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
