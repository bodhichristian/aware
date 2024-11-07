//
//  SessionView.swift
//  Aware
//
//  Created by christian on 11/6/24.
//

import SwiftUI

struct SessionView: View {
    @Binding var inSession: Bool
    
    var body: some View {
        ZStack  {
            VStack {
                Text("Bring attention to the moment.")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .transition(.blurReplace)
                
               Text("Tap anywhere to end the session.")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                
            }
            
            SessionTimer(inSession: $inSession)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding()
        }
    }
}

#Preview {
    SessionView(inSession: .constant(true))
}