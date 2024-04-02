//
//  Login.swift
//  Checkin
//
//  Created by VNDC on 17/06/2023.
//

import SwiftUI

struct LoginSplash: View {
    @StateObject var vc: AppState = AppState.share
    @State var isShowLoginBlock: Bool = false
    @State var isShowSlogan: Bool = false
    var body: some View {
        GeometryReader { geo in
            ZStack
            {
                Image("bg")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack
                {
                    
                    VStack(alignment: .leading, spacing:4)
                    {
                        Text("Giải pháp")
                            .font(.system(size: 20))
                        Text("Checkin")
                            .font(.system(size: 36))
                            .fontWeight(.bold)
                        Text("& Trình chiếu")
                            .font(.system(size: 36))
                            .fontWeight(.bold)
                        Text("Cho sự kiện của bạn")
                            .font(.system(size: 20))
                        
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal,20)
                    .padding(.bottom,80)
                    .offset(x: isShowSlogan ? 0 : -geo.size.width)
                    .onAppear
                    {
                        withAnimation(.easeInOut(duration: 0.8))
                        {
                            isShowSlogan.toggle()
                        }
                    }
                    VStack(spacing: 0)
                    {
                        Rectangle()
                            .fill(Color(rgb: "#2DC3C6"))
                            .frame(height: 8)
                            .frame(maxWidth: .infinity)
                            
                        VStack
                        {
                            Button {
                                vc.currentView = .login
                                
                            } label: {
                                HStack
                                {
                                    Text("Đăng nhập")
                                        .fontWeight(.medium)
                                    Image("arrow_right")
                                }
                                .foregroundColor(.white)
                                .frame(width: geo.size.width * 0.8, height: 48)
                                .background(Color("button_background"))
                                .cornerRadius(8)
                               
                                
                            }

                        }
                        .frame(width: geo.size.width, height: geo.size.height / 5)
                        .background(.white)

                    }
                    .offset(y: isShowLoginBlock ? 0 : geo.size.height / 5 + 20)
                    .onAppear
                    {
                        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false, block: { timer in
                            withAnimation(.easeInOut(duration: 0.5))
                            {
                                isShowLoginBlock.toggle()
                            }
                            // Huỷ bộ đếm thời gian
                            timer.invalidate()
                        })
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
            .background(.white)
            .ignoresSafeArea()
        }
    }
}

struct LoginSplash_Previews: PreviewProvider {
    static var previews: some View {
        LoginSplash()
    }
}
