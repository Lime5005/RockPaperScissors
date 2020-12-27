//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Liping Mechling on 27/12/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var moves =  ["Rock", "Paper", "Scissors"]
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var totalTried = 0
    @State private var gameOver = false
    @State private var alertTitle = ""
    
    var body: some View {
        NavigationView {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .green]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Text("App's choice: \(moves[appChoice])")
                    Text("You should \(shouldWin ? "win" : "lose")")
                    HStack {
                        Text("Choose:")
                        ForEach(0 ..< 3) { number in
                            Button(action: {
                                self.btnTapped(number)
                            }) {
                                Text("\(self.moves[number])")
                            }
                        }
                    }

                    Section {
                        Text("Your score is \(score)/\(totalTried)")
                    }
                    Spacer()
                }
            }.navigationBarTitle("Rock Paper Scissors")
            .alert(isPresented: $gameOver) {
                Alert(title: Text(alertTitle), message: Text("Your score is \(score)/\(totalTried)"), dismissButton: .default(Text("Continue")) {
                    self.gameOver = false
                    score = 0
                    totalTried = 0
                })
            }
        }
    }
    
    func btnTapped(_ number: Int) {
        if number > appChoice && shouldWin == true {
            score += 1
        } else if number == appChoice {
            score += 0
        } else if (number == 0 && appChoice == 2) && shouldWin == true {
            score += 1
        } else if !shouldWin && number < appChoice {
            score += 1
        } else if (appChoice == 0 && number == 2) && !shouldWin {
            score += 1
        } else {
            alertTitle = "Game Over!"
            score -= 1
        }
        
        totalTried += 1
        
        if totalTried >= 10 {
            gameOver = true
            if score == 10 {
                alertTitle = "Congratulations! You win all!"
            }
        }
        
        appChoice = Int.random(in: 0 ... 2)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
