//
//  ContentView.swift
//  MultiplicationFun
//
//  Created by Elizabeth Rose on 6/27/22.
//

import SwiftUI

class User: ObservableObject {

    @Published var scoreRight = 0
    @Published var scoreWrong = 0
    @Published var answerCount = 0
    @Published var timesTableSelected = 0
    @Published var numberOfQuestions = 0
    @Published var timesTableRange: [Int] = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
}


struct ContentView: View {
    
    @State private var questionCount = [5, 10, 20]
    @State private var isShowingQuizView = false
    @State private var showAlert = false
    @State private var alertTitle = ""

    @FocusState private var showKeyboard: Bool
    
    @StateObject var user = User()
    
    var body: some View {
        NavigationView {
            VStack (spacing: 30) {
                Form {
                    Section {
                        TextField("Times table?", value: self.$user.timesTableSelected, format: .number)
                            .background(Color.green)
                            .keyboardType(.numberPad)
                            .focused($showKeyboard)
                        Text("Enter a value between 2 and 12")
                    } header: {
                        Text("Select your times table")
                    }
                    
                    Section {
                        Picker("", selection: self.$user.numberOfQuestions) {
                            ForEach(questionCount, id: \.self) {
                                Text($0, format: .number)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(5)
                        .background(.pink)
                        .font(.headline)
                    } header: {
                        Text("How many questions would you like?")
                    }

                    Button("Go To Quiz >>") {
                        if validateUserInput() {
                            self.isShowingQuizView = true
                        } else {
                            showAlert = true
                        }
                    }
                }
                NavigationLink(destination: QuizView(user: user), isActive: $isShowingQuizView) {QuizView()}
                    .hidden()
                .foregroundColor(.black)
                .navigationTitle("Multiplication Fun")
                .navigationBarTitleDisplayMode(.large)
                .foregroundColor(.black)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("Next") {
                            showKeyboard = false
                        }
                    }
                }
            }
            
        }
        .alert(alertTitle, isPresented: $showAlert) {
            Button ("Ok", action: resetIncorrectSelection)
        }
    }
    
    func resetIncorrectSelection() {
        user.timesTableSelected = 0
    }
    
    func resetVariables () {
        self.user.timesTableSelected = 0
        self.user.numberOfQuestions = 0
        alertTitle = ""
    }

    func validateUserInput() -> Bool {
        
        if self.user.timesTableRange.contains(self.user.timesTableSelected) &&
            questionCount.contains(self.user.numberOfQuestions) {
                return true
        } else {
            alertTitle = "Incorrect selection - try again."
            showAlert = true
            return false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
