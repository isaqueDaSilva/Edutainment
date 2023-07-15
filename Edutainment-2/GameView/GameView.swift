//
//  GameView.swift
//  Edutainment-2
//
//  Created by Isaque da Silva on 14/07/23.
//

import SwiftUI

struct GameView: View {
    @State private var round = 1
    @State private var score = 0
    @State private var question = "How Much is 2 x 2"
    @State private var answer = "4"
    
    let buttons: [[ButtonNumbers]] = [
        [.one, .two, .three],
        [.four, .five, .six],
        [.seven, .eight, .nine],
        [.delete, .zero, .ok]
    ]
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Rectangle()
                    .frame(maxWidth: 400, maxHeight: 550)
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
                            
                            Text(question)
                                .font(.title3.bold())
                            HStack {
                                Text("Your answer:")
                                    .font(.headline.bold())
                                Spacer()
                                Text(answer)
                            }
                            .frame(maxWidth: 300, maxHeight: 100)
                            
                            Spacer()
                        }
                    }
                    .frame(maxWidth: 320, maxHeight: 100)
                    
                    Spacer()
                    
                    ForEach(buttons, id: \.self) { row in
                        HStack {
                            ForEach(row, id: \.self) { colum in
                                Button(action: {
                                    
                                }, label: {
                                    if colum != .delete {
                                        Text(colum.rawValue)
                                            .frame(maxWidth: 100, maxHeight: 80)
                                            .font(.title2.bold())
                                            .foregroundColor(.white)
                                            .background(Rectangle())
                                            .cornerRadius(5)
                                    } else {
                                        Image(systemName: "delete.left")
                                            .frame(maxWidth: 100, maxHeight: 80)
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
                .frame(maxWidth: 400, maxHeight: 550)
            }
            
            Spacer()
            
            HStack {
                Text("Round: \(round)")
                    .font(.title2.bold())
                
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title2.bold())
            }
            
            Spacer()
        }
        .padding()
    }
}




struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
