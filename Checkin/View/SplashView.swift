//
//  SplashView.swift
//  Checkin
//
//  Created by VNDC on 17/06/2023.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        GeometryReader {geo in
            ZStack  
            {
                Image("bg")
                    .resizable()
                    .frame(maxWidth: . infinity, maxHeight: .infinity)
                VStack
                {
                    Image("logo")
                    ProgressView()
                        .scaleEffect(1.5)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        .padding(.top, 40)
                }
                .padding(.bottom, geo.size.height * 0.1)
                VStack
                {
                    Image("logoVNDC")
                        .padding(.bottom)
                }
                .frame(height: geo.size.height , alignment: .bottom)
            }
            .ignoresSafeArea()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
