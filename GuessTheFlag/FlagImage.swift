//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by CHIARELLO Berardino - ADECCO on 25/04/23.
//

import SwiftUI

struct FlagImage: View {
    
    var imageName : String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .resizable()
            .scaledToFit()
            .frame(height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(radius: 2)
    }
}
