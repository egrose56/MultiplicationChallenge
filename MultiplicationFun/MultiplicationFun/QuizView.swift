//
//  QuizView.swift
//  MultiplicationFun
//
//  Created by Elizabeth Rose on 6/29/22.
//

import SwiftUI

struct QuizView: View {
    
    @ObservedObject var user = User()
    @FocusState private var showKeyboard: Bool
    
    @State private var answer = 0
    @State private var randomElement = 0
    @State private var showTheAlert = false
    @State private var alertTitle = ""
        
    var body: some View {
        
        VStack (spacing: 30) {
            Form {
                Section {
                    VStack (alignment: .leading, spacing: 10, content: {
                        Text("You chose the \(user.timesTableSelected) times table and \(user.numberOfQuestions) questions.")
                    })

                    VStack (alignment: .leading, spacing: 10, content: {
                        Text("\(user.timesTableSelected) * \(randomElement) = ")
                        TextField("", value: $answer, format: .number)
                            .background(.blue)
                            .foregroundColor(.white)
                            .keyboardType(.numberPad)
                            .focused($showKeyboard)
                            .onSubmit {
                                
                            }
                        Button ("OK") {
                            checkTheAnswer()
                        }
                    })
                } header: {
                    Text("Multiplication Quiz")
                }
            }
            Image("giraffe")
                .position()
        .onAppear(perform: setUpQuestion)
        }
        .alert(alertTitle, isPresented: $showTheAlert) {
            Button ("Continue", action: setUpQuestion)
        }
    }
    func checkForLastTurn() {
        if user.answerCount == (user.numberOfQuestions - 1) {
            alertTitle = "Quiz over! Your score was \(user.scoreRight) right answers and \(user.scoreWrong) wrong answer(s). Go back to play again."
            showTheAlert = true
            resetVariables()
        }
    }
    
    func checkTheAnswer() {
        
       if answer == (user.timesTableSelected * randomElement){
            alertTitle = "Correct!"
            user.scoreRight += 1
            showTheAlert = true
            checkForLastTurn()
            answer = 0
        } else {
            alertTitle = "Wrong, the correct answer is \(user.timesTableSelected * randomElement)"
            user.scoreWrong += 1
            showTheAlert = true
            checkForLastTurn()
            answer = 0
        }
        user.answerCount += 1
    }
    
    func resetVariables() {
        answer = 0
        user.answerCount = 0
        randomElement = 0
    }

    func setUpQuestion() {
        randomElement = user.timesTableRange.randomElement()!
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}

