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
    @State private var difficultyLevel: DifficultyLevel = .easy
    @State private var numberOfQuestionsSelected = 5
    @State private var round = 1
    @State private var score = 0
    
    let numberOfQuestions = [5, 10, 20]
    
    let buttons: [[ButtonNumbers]] = [
        [.one, .two, .three],
        [.four, .five, .six],
        [.seven, .eight, .nine],
        [.delete, .zero, .ok]
    ]
    
    //choices view
    @ViewBuilder var choices: some View {
        VStack{
            Spacer()
            Text(showingSteps ? "Before starting the game:" : "")
                .font(.title2.bold())
            
            Spacer()
            if step == 1 {
                TextModifier(text: "What difficulty level would you like to tackle?")
                
                Picker("Difficulty Level", selection: $difficultyLevel) {
                    ForEach(DifficultyLevel.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
            }
            
            if step == 2 {
                TextModifier(text: "How many questions would you like to answer?")
                
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
                    withAnimation {
                        showingSteps = false
                        gameIsOn = true
                    }
                }
            })
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .frame(maxWidth: 400, maxHeight: showingSteps ? 300 : 0)
        .background(.thinMaterial)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
        
    }
    
    //Game view
    @ViewBuilder var gameView: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(maxWidth: 400, maxHeight: gameIsOn ? 550 : 0)
                    .foregroundColor(Color("MidnightBlue"))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                
                VStack {
                    ZStack {
                        Rectangle()
                            .frame(maxWidth: 330, maxHeight: gameIsOn ? 90 : 0)
                            .foregroundColor(Color("DevoeJadeGreen"))
                            .cornerRadius(10)
                        
                        VStack {
                            Spacer()
                            Text(gameIsOn ? "How Much is 2 x 2?" : "")
                                .font(.title3.bold())
                            Spacer()
                            Spacer()
                            HStack {
                                TextModifier(text: gameIsOn ? "Your Answer:" : "")
                                Spacer()
                                TextModifier(text: gameIsOn ? "4" : "")
                            }
                            Spacer()
                        }
                        .padding()
                    }
                    .frame(maxWidth: 320, maxHeight: gameIsOn ? 100 : 0)
                    
                    ForEach(buttons, id: \.self) { row in
                        HStack {
                            ForEach(row, id: \.self) { colum in
                                Button(action: {
                                    
                                }, label: {
                                    if colum != .delete {
                                        Text(colum.rawValue)
                                            .frame(maxWidth: 100, maxHeight: gameIsOn ? 80 : 0)
                                            .font(.title2.bold())
                                            .foregroundColor(.white)
                                            .background(Rectangle())
                                            .cornerRadius(5)
                                    } else {
                                        Image(systemName: "delete.left")
                                            .frame(maxWidth: 100, maxHeight: gameIsOn ? 80 : 0)
                                            .font(.title2.bold())
                                            .foregroundColor(.white)
                                            .background(Rectangle())
                                            .cornerRadius(5)
                                    }
                                })
                            }
                        }
                    }
                }
            }
            HStack {
                Text(gameIsOn ? "Round: \(round)" : "")
                    .font(.title2.bold())
                
                Spacer()
                
                Text(gameIsOn ? "Score: \(score)/\(numberOfQuestionsSelected)" : "")
                    .font(.title2.bold())
            }
            Spacer()
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack {
                if gameIsOn == false {
                    Text(gameIsOn == false ? "Welcome to Edutainment" : "")
                        .font(.title.bold())
                    
                    if showingSteps == false {
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
                        .frame(maxWidth: 400, maxHeight: showingSteps ? 300 : 0)
                }
                
                gameView
                    .frame(maxWidth: 400, maxHeight: gameIsOn ? 550 : 0)
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
