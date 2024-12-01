//
//  HKPermissionPrimer.swift
//  Aware
//
//  Created by christian on 10/26/24.
//

import SwiftUI
import HealthKitUI

struct HKPermissionPrimerView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(AppState.self) var appState
    @Environment(HealthKitService.self) var hkService
    @State private var requestingPermission: Bool = false
    
    var body: some View {
        ZStack {
            MindfulMeshGradient()                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Image("appleHealth")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .shadow(color: .gray.opacity(0.3), radius: 16)
                    .padding(.bottom)
                
                Text("Apple Health Integration")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(hkService.permissionPrimer)
                    .foregroundStyle(.secondary)
                
                Button("Connect to Apple Health") {
                    requestingPermission = true
                }
                .buttonStyle(.borderedProminent)
                .tint(appState.theme.accentColor)
                .frame(maxWidth: .infinity)
                .padding(.top, 160)
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .interactiveDismissDisabled()
        .healthDataAccessRequest(
            store: hkService.store,
            shareTypes: hkService.types,
            readTypes: hkService.types,
            trigger: requestingPermission) { result in
                switch result {
                case .success/*(let success)*/:
                    Task { @MainActor in
                        dismiss()
                    }
                case .failure/*(let failure)*/:
                    // handle error
                    
                    Task { @MainActor in
                        dismiss()
                    }
                }
            }
    }
}

#Preview {
    HKPermissionPrimerView()
        .environment(HealthKitService())
}
