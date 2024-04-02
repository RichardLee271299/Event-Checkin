//
//  HomeView.swift
//  Checkin
//
//  Created by VNDC on 20/06/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vc: AppState = AppState.share
    @State var search: String = ""
    @State var isShowPopup: Bool = true
    @State var popupAppear: Bool = false
    
    @State var isLoading: Bool = false
    @State var alertIsShow: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var alertButtonText: String = "OK"
    
    var body: some View {
        ZStack
        {
            ScrollView(showsIndicators: false)
            {
                VStack (spacing: 20)
                {
                    VStack(alignment: .leading)
                    {
                        Text("Xin chào,")
                            .font(.system(size: 16).weight(.medium))
                        Text("\(vc.personal?.name ?? "")")
                            .font(.system(size: 24).weight(.medium))
                            .tracking(1.3)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 16)
                    VStack(spacing: 16)
                    {
                        Button {
                            vc.currentView = .scan
                        } label: {
                            VStack (spacing: 12)
                            {
                                Image("QR_icon")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .aspectRatio(contentMode: .fit)
                                Text("SCAN QR")
                                    .font(.system(size: 18).weight(.semibold))
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 140)
                            .background(Color("primary"))
                            .cornerRadius(8)
                        }
                        
                        VStack (spacing: 12)
                        {
                            VStack
                            {
                                TextField("Nhập mã khách mời", text: $search)
                                    .keyboardType(.numberPad)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical,10)
                                    .padding(.leading, 16)
                            }
                            .background
                            {
                                Capsule()
                                    .fill(.white)
                            }
                            .overlay
                            {
                                Button {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    if search.isEmpty
                                    {
                                        alertTitle = "Thông báo"
                                        alertMessage = "Vui lòng nhập mã khách mời"
                                        alertIsShow.toggle()
                                    }
                                    else
                                    {
                                        searchParticipant()
                                    }
                                } label: {
                                    VStack
                                    {
                                        Image(systemName: "magnifyingglass")
                                            .font(.system(size: 16).weight(.bold))
                                            .foregroundColor(.white)
                                            .padding(8)
                                            .background(Color("primary"))
                                            .cornerRadius(50)
                                        
                                    }
                                    .padding(.horizontal,4)
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.horizontal,20)
                            
                            Text("TÌM KIẾM")
                                .font(.system(size: 18).weight(.semibold))
                                .foregroundColor(.white)
                                .padding(.top,8)
                        }
                        .frame(height: 140)
                        .frame(maxWidth: .infinity)
                        .background(Color("primary"))
                        .cornerRadius(8)
                        
                        Button {
                            vc.currentView = .addPaticipant
                        } label: {
                            VStack (spacing: 12)
                            {
                                Image("adduser_icon")
                                    .resizable()
                                    .frame(width:54, height: 41)
                                    .aspectRatio(contentMode: .fit)
                                Text("TẠO MỚI")
                                    .font(.system(size: 18).weight(.semibold))
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 140)
                            .background(Color("primary"))
                            .cornerRadius(8)
                        }
                    }
                    
                    VStack{}
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .background
                    {
                        Rectangle()
                            .fill(Color(rgb: "#646464"))
                    }
                    .padding(.horizontal,20)
                    .padding(.top)
                    
                    VStack
                    {
                        Text("Sự kiện")
                            .foregroundColor(Color(rgb: "#646464"))
                        Text(vc.personal?.event_detail.name ?? "")
                            .foregroundColor(Color(rgb: "#020202"))
                            .font(.system(size: 20).bold())
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.7)
                    
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding()
                
            }
            
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .alert(isPresented: $alertIsShow) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text(alertButtonText))
            ) // End of Alert
        } // End of alert
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
