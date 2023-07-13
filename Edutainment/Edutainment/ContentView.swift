//
//  ContentView.swift
//  Edutainment
//
//  Created by Isaque da Silva on 10/07/23.
//

import SwiftUI

enum ButtonNumbers: String, CaseIterable {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case ok = "OK"
    case delete
}

enum DifficultyLevel: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

struct ContentView: View {
    @State private var showingSteps = false
    @State private var step = 1
    
    @State private var gameIsOn = false
    
    @State private var numbersOfQuestionsSelected = 5
    let numbersOfQuestions = [5, 10, 20]
    
    @State private var difficultyLevelSelected: DifficultyLevel = .easy
    
    let multiplier = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20].shuffled()
    var multiplying: [Int] {
        var question = [Int]()
        
        if difficultyLevelSelected == .easy {
            question = [1, 2, 5, 10]
        } else if difficultyLevelSelected == .medium {
            question = [3, 4, 6]
        } else if difficultyLevelSelected == .hard {
            question = [7, 8, 9]
        }
        
        return question.shuffled()
    }
    
    
    let buttons: [[ButtonNumbers]] = [
        [.one, .two, .three],
        [.four, .five, .six],
        [.seven, .eight, .nine],
        [.delete, .zero, .ok]
    ]
    
    @State private var round = 1
    @State private var score = 0
    @State private var answer = "0"
    @State private var showingResult = false
    
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
                Text("What difficulty level would you like to tackle?")
                    .font(.headline.bold())
                    .multilineTextAlignment(.center)
                
                Picker("Difficulty Level", selection: $difficultyLevelSelected) {
                    ForEach(DifficultyLevel.allCases, id: \.self) {
                        Text($0.rawValue)
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
            }
            
            Spacer()
            
            if step < 2 {
                stepButton
            } else {
                startButton
            }
            Spacer()
        }
    }
    
    @ViewBuilder var numberKeyboard: some View {
        ForEach(buttons, id: \.self) { row in
            HStack {
                ForEach(row, id: \.self) { colum in
                    Button(action: {
                        didTap(button: colum)
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
    
    @ViewBuilder var gameView: some View {
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
                            .foregroundColor(Color("DevoeJadeGreen"))
                            .cornerRadius(5)
                        VStack {
                            Spacer()
                            
                            Text(gameIsOn ? "How much is ?" : "")
                                .font(.title3.bold())
                            
                            HStack {
                                Text("Your answer")
                                    .font(.headline.bold())
                                Spacer()
                                Text(answer)
                            }
                            .frame(maxWidth: gameIsOn ? 300 : 0, maxHeight: gameIsOn ? 100 : 0)
                            
                            Spacer()
                        }
                    }
                    .frame(maxWidth: gameIsOn ? 320 : 0, maxHeight: gameIsOn ? 100 : 0)
                    
                    Spacer()
                    
                    numberKeyboard
                    
                    Spacer()
                }
                .frame(maxWidth: 400, maxHeight: gameIsOn ? 550 : 0)
            }
            
            Spacer()
            
            HStack {
                Text(gameIsOn ? "Round: \(round)" : "")
                    .font(.title2.bold())
                
                Spacer()
                
                Text(gameIsOn ? "Score: \(score)/\(numbersOfQuestionsSelected)" : "")
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
                    Text("Welcome to Edutainment 🤓")
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
    
    func didTap(button: ButtonNumbers) {
        switch button {
        case .ok:
            showingResult = true
        case .delete:
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
