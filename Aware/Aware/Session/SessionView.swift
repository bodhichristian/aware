//
//  SessionView.swift
//  Aware
//
//  Created by christian on 11/6/24.
//

import SwiftUI

struct SessionView: View {
    @Environment(AppState.self) var appState
    
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
            .frame(maxHeight: .infinity, alignment: .center)
            
            SessionTimer()
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .onAppear {
//            user.inSession = true
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    SessionView()
}
