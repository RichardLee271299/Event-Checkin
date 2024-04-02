//
//  MainView.swift
//  Checkin
//
//  Created by VNDC on 17/06/2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var vc: AppState = AppState.share
    @State var isAppear: Bool = false
    var body: some View {
        GeometryReader { geo in
            ZStack
            {
                switch vc.currentView
                {
                    case.empty:
                        EmptyView()
                    case .home:
                        HomeView()
                    default:
                        LoginSplash()        
                }
                
                if vc.isShowLoading
                {
                    SplashView()
                }
            }
            .offset(x: vc.previousView ? ((vc.currentView != .home ? 0 : (isAppear ? 0 : -geo.size.width-50))) : (vc.currentView != .home ? 0 : (isAppear ? 0 : geo.size.width + 50)))
            .onAppear
            {
                if vc.currentView == .home
                {
                    withAnimation(.easeInOut(duration: 0.5))
                    {
                        isAppear = true
                        vc.previousView = false
                    }
                }
                
                if vc.firstTimeLoading
                {
                    vc.isShowLoading = true
                    // Cài đặt hiển thị trong 2.5 giây, không lặp lại.
                    Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false, block: { timer in
                        // Tắt hiển thị màn hình chờ
                        vc.firstTimeLoading = false
                        vc.isShowLoading = false
                        vc.currentView = .loginSplash
                        // Huỷ bộ đếm thời gian
                        timer.invalidate()
                    })
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
