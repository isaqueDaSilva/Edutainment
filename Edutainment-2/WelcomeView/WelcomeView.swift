//
//  WelcomeView.swift
//  Edutainment-2
//
//  Created by Isaque da Silva on 14/07/23.
//

import SwiftUI

struct WelcomeView: View {
    @State private var welcomeView = true
    @State private var showingSteps = false
    @State private var step = 1
    @State private var difficultyLevel: DifficultyLevel = .easy
    @State private var numberOfQuestionsSelected = 5
    
    let numberOfQuestions = [5, 10, 20]
    
    var body: some View {
        VStack {
            if welcomeView == true {
                Text("Welcome to Edutainment 🤓")
                    .font(.title.bold())
                if showingSteps == false {
                    Text("The perfect space for fun and learning at the same time😉")
                        .font(.headline.bold())
                        .multilineTextAlignment(.center)
                    
                    Button("Play", action: {
                        withAnimation {
                            showingSteps = true
                        }
                    })
                    .buttonStyle(.borderedProminent)
                }
                
                VStack {
                    Spacer()
                    Text("Before starting the game:")
                        .font(.title3.bold())
                    Spacer()
                    if step == 1 {
                        Text("What difficulty level would you like to tackle?")
                            .font(.headline.bold())
                            .multilineTextAlignment(.center)
                        
                        Picker("Difficulty Level", selection: $difficultyLevel) {
                            ForEach(DifficultyLevel.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()
                    }
                    
                    if step == 2 {
                        Text("How many questions would you like to answer?")
                            .font(.headline.bold())
                            .multilineTextAlignment(.center)
                        
                        Picker("Number of Question", selection: $numberOfQuestionsSelected) {
                            ForEach(numberOfQuestions, id: \.self) {
                                Text(String($0))
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()
                    }
                    Spacer()
                    Button(step == 1 ? "Next" : "Start Game", action: {
                        if step == 1 {
                            step += 1
                        } else {
                            showingSteps = false
                            welcomeView = false
                        }
                    })
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
                .frame(maxWidth: 350, maxHeight: showingSteps ? 250 : 0)
                .background(.thinMaterial)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
