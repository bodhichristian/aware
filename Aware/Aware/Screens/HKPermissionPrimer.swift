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
            
            VStack(alignment: .leading, spacing: 10) {
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
                
                Button {
                    requestingPermission = true
                } label: {
                    Text("Connect to Apple Health")
                        .background {
                            Capsule()
                                .foregroundStyle(appState.theme.accentColor)
                                .frame(width: 220, height: 44)
                                .shadow(radius: 4, y: 4)
                        }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 160)
                .buttonStyle(.plain)
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
