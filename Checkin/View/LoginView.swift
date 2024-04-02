//
//  LoginView.swift
//  Checkin
//
//  Created by VNDC on 20/06/2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject var vc: AppState = AppState.share
    @State var phone: String = ""
    @State var password: String = ""
    @State var isAppear: Bool = false
    @State var message: String = ""
    @State var isLoading: Bool = false
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack
            {
                VStack(alignment: .leading, spacing:  30)
                {
                    Button {
                        vc.currentView = .loginSplash
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .padding(.horizontal,20)
                            .padding(.vertical,10)
                            .background(Color(rgb: "#0D1634").opacity(0.05))
                            .cornerRadius(16)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.top, 10)
                    VStack(alignment: .leading, spacing: 20)
                    {
                        Text("Đăng nhập")
                            .font(.system(size: 40))
                            .fontWeight(.medium)
                            .padding(.vertical,10)
                        
                        VStack(alignment: .leading,spacing: 0)
                        {
                            Text("SỐ ĐIỆN THOẠI")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundColor(Color(rgb: "#808080"))
                                .tracking(1.5)
                            TextField("", text: $phone)
                                .placeholder(when: phone.isEmpty) {
                                    Text("Nhập số điện thoại").foregroundColor(.black).font(.system(size: 16).weight(.medium))
                                }
                                .keyboardType(.numberPad)
                                .font(.system(size: 16).weight(.medium))
                                .padding(.vertical,16)
                                .background(
                                   VStack
                                   {
                                       Rectangle()
                                           .fill(Color(rgb: "#0D1634").opacity(0.05))
                                           .frame(height: 1)
                                   }
                                    .frame(maxHeight: .infinity, alignment: .bottom)
                                    
                                )
                        }
                        .padding(.vertical,20)
                        VStack(alignment: .leading,spacing: 0)
                        {
                            Text("MẬT KHẨU")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundColor(Color(rgb: "#808080"))
                                .tracking(1.5)
                            SecureField("", text: $password)
                                .placeholder(when: password.isEmpty) {
                                    Text("Nhập mật khẩu").foregroundColor(.black).font(.system(size: 16).weight(.medium))
                                }
                                .font(.system(size: 16).weight(.medium))
                                .padding(.vertical,16)
                                .background(
                                   VStack
                                   {
                                       Rectangle()
                                           .fill(Color(rgb: "#0D1634").opacity(0.05))
                                           .frame(height: 1)
                                   }
                                    .frame(maxHeight: .infinity, alignment: .bottom)
                                    
                                )
                        }
                        if !message.isEmpty
                        {
                            Text("\(message)")
                                .font(.system(size: 14).weight(.medium))
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                        }
                        Button {
                            doLogin()
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        } label: {
                            HStack
                            {
                                Text("Đăng nhập")
                                    .fontWeight(.medium)
                                Image("arrow_right")
                            }
                            .foregroundColor(.white)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(Color("button_background"))
                            .cornerRadius(8)
                        }
                        .padding(.vertical,10)
                        
                        Button {
                            
                        } label: {
                            Text("Quên mật khẩu")
                                .font(.system(size: 14).weight(.medium))
                                .foregroundColor(Color(rgb: "#35A1DA"))
                        }
                        .frame(maxWidth: .infinity)

                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
                if isLoading
                {
                    VStack
                    {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.white.opacity(0.7))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .offset(x: isAppear ? 0 : geo.size.width + 50)
            .onAppear
            {
                withAnimation(.easeInOut(duration: 0.5))
                {
                    isAppear = true
                }
            }

        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
