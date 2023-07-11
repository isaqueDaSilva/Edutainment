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
    
    @State private var tableSelect1 = 1
    @State private var tableSelect2 = 2
    @State private var tableSelect3 = 3
    
    @ViewBuilder var stepButton: some View {
        VStack {
            Button("Next", action: {
                step += 1
            })
            .buttonStyle(.borderedProminent)
        }
    }
    
    let tables = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
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
                        Text("Before starting the game:")
                            .font(.title2.bold())
                        
                        if step == 1 {
                            Picker("Select which multiplication tables you want to practice?", selection: $tableSelect1) {
                                ForEach(tables, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                        }
                        
                        stepButton
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                    .shadow(radius: 10)
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
