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
    @State private var multiplier = 1
    @State private var multiplying = 2
    @State private var answer = "0"
    @State private var showingResults = false
    @State private var resultTitle = ""
    @State private var resultMessage = ""
    
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
                        answer = "0"
                        questionGenerator()
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
        GeometryReader { geo in
            VStack {
                Spacer()
                ZStack {
                    Rectangle()
                        .frame(maxWidth: 400, maxHeight: gameIsOn ? 550 : 0)
                        .foregroundColor(Color("MidnightBlue"))
                        .cornerRadius(20)
                        .shadow(radius: 10)
                    
                    VStack {
                        Spacer()
                        
                        ZStack {
                            Rectangle()
                                .frame(maxWidth: geo.size.width * 0.9, maxHeight: gameIsOn ? geo.size.height * 0.2 : 0)
                                .foregroundColor(Color("DevoeJadeGreen"))
                                .cornerRadius(10)
                            
                            VStack {
                                Text(gameIsOn ? "How Much is \(multiplier) x \(multiplying)?" : "")
                                    .font(.title3.bold())
                                    .padding(.bottom)
                                
                                Spacer()
                                
                                HStack {
                                    TextModifier(text: gameIsOn ? "Your Answer:" : "")
                                    Spacer()
                                    TextModifier(text: gameIsOn ? answer : "")
                                }
                                .padding(.horizontal)
                            }
                            .frame(maxWidth: geo.size.width * 0.9, maxHeight: gameIsOn ? geo.size.height * 0.2 : 0)
                            .padding()
                        }
                        Spacer()
                        ForEach(buttons, id: \.self) { row in
                            HStack {
                                ForEach(row, id: \.self) { colum in
                                    Button(action: {
                                        didTap(button: colum)
                                    }, label: {
                                        if colum != .delete {
                                            Text(colum.rawValue)
                                                .frame(maxWidth: geo.size.width * 0.28, maxHeight: gameIsOn ? geo.size.height * 0.15 : 0)
                                                .font(.title2.bold())
                                                .foregroundColor(.white)
                                                .background(Rectangle())
                                                .cornerRadius(5)
                                        } else {
                                            Image(systemName: "delete.left")
                                                .frame(maxWidth: geo.size.width * 0.28, maxHeight: gameIsOn ? geo.size.height * 0.15 : 0)
                                                .font(.title2.bold())
                                                .foregroundColor(.white)
                                                .background(Rectangle())
                                                .cornerRadius(5)
                                        }
                                    })
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            VStack {
                if gameIsOn == false {
                    if showingSteps == false {
                        Text("Welcome to Edutainment")
                            .font(.title.bold())
                        
                        TextModifier(text: "The perfect space for fun and learning at the same time 😉")
                        
                        Button("Play", action: {
                            withAnimation {
                                showingSteps = true
                                step = 1
                            }
                        })
                        .buttonStyle(.borderedProminent)
                    }
                    
                    Text(showingSteps ? "Edutainment 🔢" : "")
                        .font(.title.bold())
                    
                    choices
                        .frame(maxWidth: 400, maxHeight: showingSteps ? 300 : 0)
                }
                
                gameView
                    .frame(maxWidth: 400, maxHeight: gameIsOn ? 550 : 0)
                    .padding(.bottom)
                
                HStack {
                    Text(gameIsOn ? "Round: \(round)" : "")
                        .font(.title2.bold())
                    
                    Spacer()
                    
                    Text(gameIsOn ? "Score: \(score)/\(numberOfQuestionsSelected)" : "")
                        .font(.title2.bold())
                }
            }
            .padding()
        }
        .alert(resultTitle, isPresented: $showingResults) {
            Button(round < numberOfQuestionsSelected ? "Next" : "New Game", action: {
                if round < numberOfQuestionsSelected {
                    round += 1
                    answer = "0"
                    questionGenerator()
                } else if round == numberOfQuestionsSelected {
                    withAnimation {
                        round = 1
                        score = 0
                        gameIsOn = false
                        showingSteps = true
                        step = 1
                    }
                }
            })
        } message: {
            Text(resultMessage)
        }
    }
    
    func questionGenerator() {
        if difficultyLevel == .easy {
            multiplier = Int.random(in: 1...10)
            multiplying = Int.random(in: 1...10)
        }
        if difficultyLevel == .medium {
            multiplier = Int.random(in: 11...20)
            multiplying = Int.random(in: 11...20)
        }
        if difficultyLevel == .hard {
            multiplier = Int.random(in: 21...100)
            multiplying = Int.random(in: 21...100)
        }
    }
    
    func questionChecker() {
        if round < numberOfQuestionsSelected {
            if answer == String(multiplier * multiplying) {
                resultTitle = "Good Jobs 😉"
                resultMessage = "You really are becoming the king of the tables 😎"
                score += 1
            } else {
                resultTitle = "Ohh no... 😔"
                resultMessage = "Your answer doesn't match the correct value which is \(multiplier * multiplying)!\nBut don't be discouraged, with more tries you'll get the hang of it 😉"
            }
        } else {
            if answer == String(multiplier * multiplying) {
                score += 1
            }
            resultTitle = "Game Over"
            resultMessage = "Final score: \(score) points\nKeep practicing, so you'll get better and better 😉"
        }
    }
    
    func didTap(button: ButtonNumbers) {
        switch button {
        case .ok :
            showingResults = true
            questionChecker()
        case .delete :
            answer.removeLast()
            
            if answer.count == 0 {
                answer = "0"
            }
            
        default :
            let number = button.rawValue
            
            if answer == "0" {
                answer = number
            } else {
                answer = "\(answer)\(number)"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
