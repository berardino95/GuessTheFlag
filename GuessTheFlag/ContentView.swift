//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by CHIARELLO Berardino - ADECCO on 22/04/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingFinalAlert = false
    @State private var scoreTitle = ""
    @State private var answerMessage = ""
    @State private var score : Int = 0
    @State private var questionNumber = 1
    @State private var maxQuestionNumber = 8
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var selectedFlag = -1
    
    
    
    var finalAlertText : String {
        "Correct answer \(score) / \(questionNumber)"
    }
    
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient (colors: [Color(.systemBlue), Color(.systemMint)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack{
                    
                    Spacer()
                    
                    Text("Guess the flag")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    VStack (spacing: 0){
                        
                        Text("Tap the flag of")
                            .foregroundColor(.primary)
                            .font(.title)
                        
                        Text (countries[correctAnswer])
                            .foregroundColor(.primary)
                            .font(.largeTitle.weight(.semibold))
                        
                        VStack(spacing: 20){
                            ForEach(0..<3){ number in
                                Button {
                                    flagTapped(number)
                                } label: {
                                    FlagImage(imageName: countries[number])
                                        .rotation3DEffect(.degrees(selectedFlag == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                        .opacity(selectedFlag == -1 || selectedFlag == number ? 1 : 0.3)
                                        .animation(selectedFlag != -1 ? .easeOut : nil, value: selectedFlag)
                                        .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1 : 0.8)
                                        .animation(.easeOut, value: selectedFlag)
                                }
                            }
                        }
                        .padding(.top, 20)
                        .padding(.vertical, 10)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 30)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    Text("Score \(score)")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.bottom, 1)
                    Text("Question \(questionNumber) / \(maxQuestionNumber)")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
            }
            
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", role: .cancel, action: askQuestion)
            } message: {
                Text(answerMessage)
                
            }
            
            .alert(finalAlertText, isPresented: $showingFinalAlert) {
                Button("Restart", role: .cancel, action: reset)
            }
        }
    }
    
    func flagTapped (_ number: Int) {
        //passing the number of the selected flag
        selectedFlag = number
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your function
            if number == correctAnswer{
                scoreTitle = "Correct"
                score += 1
                answerMessage = "Your score is \(score)"
            } else {
                scoreTitle = "Wrong"
                answerMessage = "This is the flag of \(countries[number]) \n Your score is \(score)"
            }
            if questionNumber == maxQuestionNumber {
                showingFinalAlert = true
            } else {
                showingScore = true }
        }
    }
    
    func askQuestion(){
        correctAnswer = Int.random(in: 0...2)
        countries.shuffle()
        questionNumber += 1
        selectedFlag = -1
    }
    
    func reset(){
        correctAnswer = Int.random(in: 0...2)
        countries.shuffle()
        score = 0
        questionNumber = 0
        selectedFlag = -1
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
