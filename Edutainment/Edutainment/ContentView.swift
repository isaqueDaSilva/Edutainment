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
    
    @State private var gameIsOn = false
    
    @State private var tableSelect = 1
    let tables = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    @State private var numbersOfQuestionsSelected = 5
    let numbersOfQuestions = [5, 10, 20]
    
    @State private var difficultyLevelSelected = "Easy"
    let difficultyLevel = ["Easy", "Medium", "Hard"]
    
    @State private var round = 1
    @State private var points = 0
    
    @ViewBuilder var playButton: some View {
        Button("Play", action: {
            withAnimation {
                showingSteps = true
            }
        })
        .buttonStyle(.borderedProminent)
    }
    
    @ViewBuilder var stepButton: some View {
        VStack {
            Button("Next", action: {
                step += 1
            })
            .buttonStyle(.borderedProminent)
        }
    }
    
    @ViewBuilder var startButton: some View {
        VStack {
            Button("Start Game", action: {
                withAnimation {
                    showingSteps = false
                    gameIsOn = true
                }
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
                        Text(String($0))
                    }
                }
                .pickerStyle(.segmented)
                .padding()
            } else if step == 2 {
                Text("How many questions would you like to answer?")
                    .font(.headline.bold())
                    .multilineTextAlignment(.center)
                
                Picker("Number of Question", selection: $numbersOfQuestionsSelected) {
                    ForEach(numbersOfQuestions, id: \.self) {
                        Text(String($0))
                    }
                }
                .pickerStyle(.segmented)
                .padding()
            } else if step == 3 {
                Text("What difficulty level would you like to tackle?")
                    .font(.headline.bold())
                    .multilineTextAlignment(.center)
                
                Picker("Difficulty Level", selection: $difficultyLevelSelected) {
                    ForEach(difficultyLevel, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
            }
            
            Spacer()
            
            if step < 3 {
                stepButton
            } else {
                startButton
            }
            Spacer()
        }
    }
    
    @ViewBuilder var gameView: some View {
        VStack {
            Spacer()
            
            Text(gameIsOn ? "Whats" : "")
            
            Spacer()
            
            ZStack {
                Rectangle()
                    .frame(maxWidth: 400, maxHeight: gameIsOn ? 550 : 0)
                    .cornerRadius(20)
                    .shadow(radius: 10)
            }
            
            Spacer()
            
            HStack {
                Text(gameIsOn ? "Round: \(round)" : "")
                    .font(.title2.bold())
                
                Spacer()
                
                Text(gameIsOn ? "" : "")
                    .font(.title2.bold())
            }
            
            Spacer()
        }
        .padding()
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack {
                if gameIsOn == false {
                    Text("Welcome to Edutainment")
                        .font(.title.bold())
                    
                    if showingSteps == false {
                        Text("The perfect space for fun and learning 😉")
                            .frame(width: 300)
                            .font(.headline.bold())
                            .multilineTextAlignment(.center)
                        playButton
                    }
                    
                    choices
                        .frame(maxWidth: 350, maxHeight: showingSteps ? 250 : 0)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                }
                gameView
                    .frame(maxWidth: .infinity, maxHeight: gameIsOn ? .infinity : 0)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
