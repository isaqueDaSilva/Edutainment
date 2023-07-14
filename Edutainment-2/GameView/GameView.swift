//
//  GameView.swift
//  Edutainment-2
//
//  Created by Isaque da Silva on 14/07/23.
//

import SwiftUI

struct GameView: View {
    @State private var gameIsOn = true
    
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
                    .frame(maxWidth: gameIsOn ? 360 : 0, maxHeight: gameIsOn ? 550 : 0)
                    .foregroundColor(Color("MidnightBlue"))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                
                VStack {
                    Spacer()
                    
                    Rectangle()
                        .frame(maxWidth: gameIsOn ? 320 : 0, maxHeight: gameIsOn ? 100 : 0)
                        .foregroundColor(Color("DevoeJadeGreen"))
                        .cornerRadius(10)
                    
                    ForEach(buttons, id: \.self) { row in
                        HStack {
                            ForEach(row, id: \.self) { colum in
                                Button(action: {
                                    
                                }, label: {
                                    if colum != .delete {
                                        Text(colum.rawValue)
                                            .frame(maxWidth: gameIsOn ? 100 : 0, maxHeight: gameIsOn ? 80 : 0)
                                            .font(.title2.bold())
                                            .foregroundColor(.white)
                                            .background(Rectangle())
                                            .cornerRadius(5)
                                    } else {
                                        Image(systemName: "delete.left")
                                            .frame(maxWidth: gameIsOn ? 100 : 0, maxHeight: gameIsOn ? 80 : 0)
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
            Spacer()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
