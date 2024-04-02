//
//  DetailView.swift
//  Checkin
//
//  Created by VNDC on 17/06/2023.
//

import SwiftUI

struct DetailView: View {
    @StateObject var vc: AppState = AppState.share
    var body: some View {
        GeometryReader {geo in
            VStack
            {
                switch vc.currentView
                {
                    case .scan:
                        ScanQRView()
                    case .paticipantDetail:
                        ParticipantDetailView()
                    case .addPaticipant:
                        AddParticipant()
                    default:
                        LoginView()
                }
            }
            .padding()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
