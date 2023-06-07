//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Eastwood on 28.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var gameIsFinish = false
    @State private var scoreTitle = ""
    @State private var gameRound = 0
    @State private var gameScore = 0

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, Color(red: 0.8627, green: 0.3392, blue: 0.4)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                Spacer()
                Text("Score: \(gameScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                VStack(spacing: 15) {
                    VStack {
                            Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.secondary)
                        }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(RoundedRectangle(cornerSize: .init(width: 10, height: 0)))
                                .shadow(radius: 5)
                        }
                    }
                }
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(gameScore)")
        }
        .alert("Finish", isPresented: $gameIsFinish) {
            Button("Restart", action: restart)
        } message: {
            Text("Your score is \(gameScore)")
        }
    }

    func game() {
        if gameRound == 8 {
            gameIsFinish = true
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
                scoreTitle = "Correct"
                gameScore += 1
            } else {
                scoreTitle = "Wrong, That’s the flag of \(countries[number])"
            }
        if gameRound < 7 {
            showingScore = true
        } else {
            gameIsFinish = true
        }
        gameRound += 1
    }

    func restart() {
        gameScore = 0
        gameRound = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
