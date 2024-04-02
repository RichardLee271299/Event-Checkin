//
//  CustomerDetailView.swift
//  Checkin
//
//  Created by VNDC on 20/06/2023.
//

import SwiftUI

struct ParticipantDetailView: View {
    
    @StateObject var vc: AppState = AppState.share
    @State var data: ParticipantData? = nil
    @State var showPicker: Bool = false
    @State var avatar: UIImage? = nil
    @State var isAppear: Bool = false
    @State var isLoading: Bool = false
    @State var alertIsShow: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var alertButtonText: String = "OK"
       
    var body: some View {
        GeometryReader { geo in
            ZStack
            {
                VStack
                {
                    Button {
                        vc.previousView = true
                        vc.currentView = .home
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
                    .padding(.vertical, 10)
                    ScrollView(showsIndicators: false)
                    {
                        VStack(spacing: 16)
                        {
                            ZStack
                            {
                                VStack
                                {
                                    VStack(spacing: 20)
                                    {
                                        VStack(spacing: 5)
                                        {
                                            Text("\(data?.name ?? "")")
                                                .font(.system(size: 24).bold())
                                                .frame(maxWidth:.infinity)
                                                .multilineTextAlignment(.center)
                                            HStack
                                            {
                                                Image("diamond")
                                                Text("\(data?.level ?? "")")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color("primary"))
                                            }
                                        }
                                        .frame(maxWidth:.infinity)
                                        VStack(spacing: 4)
                                        {
                                            Text("Tham dự sự kiện")
                                                .foregroundColor(Color(rgb: "#646464"))
                                            Text("\(data?.event_detail.name ?? "")")
                                                .font(.system(size: 20).bold())
                                                .foregroundColor(Color(rgb: "#020202"))
                                                .multilineTextAlignment(.center)
                                                .frame(maxWidth:.infinity)
                                                .padding(.horizontal)
                                        }
                                        .frame(maxWidth:.infinity)
                                        VStack(spacing: 4)
                                        {
                                            Text("Thời gian bắt đầu")
                                                .foregroundColor(Color(rgb: "#646464"))
                                            Text("\(data?.event_detail.time ?? "") | \(data?.event_detail.date ?? "")")
                                                .font(.system(size: 20).bold())
                                                .foregroundColor(Color(rgb: "#020202"))
                                                .multilineTextAlignment(.center)
                                                .frame(maxWidth:.infinity)
                                                .padding(.horizontal)
                                        }
                                        .frame(maxWidth:.infinity)
                                        Rectangle()
                                            .fill(Color(rgb: "#646464"))
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 1)
                                        
                                        VStack(spacing: 4)
                                        {
                                            Text("Mã số dự thưởng")
                                                .foregroundColor(Color(rgb: "#646464"))
                                            Text("\(data?.sku ?? "")")
                                                .font(.system(size: 32).bold())
                                                .foregroundColor(Color(rgb: "#020202"))
                                                .multilineTextAlignment(.center)
                                                .frame(maxWidth:.infinity)
                                                .padding(.horizontal)
                                        }
                                        .frame(maxWidth:.infinity)
                                    }
                                }
                                .padding(.top, 80)
                                .padding(.bottom, 40)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity)
                                .background(Color(rgb: "#E3E3E3"))
                                .cornerRadius(24)
                                
                                
                                
                                VStack
                                {
                                    if avatar == nil
                                    {
                                        ZStack
                                        {
                                            Circle()
                                                .fill(.white)
                                                .overlay
                                                {
                                                    Circle()
                                                        .stroke(Color(rgb: "#D9D9D9"),lineWidth: 8)
                                                }
                                                .frame(width: 120, height: 120)
                                            
                                            Button {
                                                showPicker.toggle()
                                            } label: {
                                                VStack
                                                {
                                                    Image("addphoto")
                                                        .background
                                                        {
                                                            Circle()
                                                                .fill(Color(rgb: "#d9d9d9"))
                                                                .frame(width:40, height: 40)
                                                        }
                                                }
                                                .offset(x: -10, y: -5)
                                            }
                                            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottomTrailing)

                                        }
                                        .frame(width: 120,height: 120)
                                    }
                                    else
                                    {
                                        ZStack
                                        {
                                            Circle()
                                                .fill(.white)
                                                .overlay
                                                {
                                                    Circle()
                                                        .stroke(Color(rgb: "#D9D9D9"),lineWidth: 8)
                                                }
                                                .frame(width: 120, height: 120)
                                            Image(uiImage: avatar!)
                                                .resizable()
                                                .frame(width: 120, height: 120)
                                                .scaledToFit()
                                                .clipShape(Circle())
                                            Button {
                                                showPicker.toggle()
                                            } label: {
                                                VStack
                                                {
                                                    Image("addphoto")
                                                        .background
                                                        {
                                                            Circle()
                                                                .fill(Color(rgb: "#d9d9d9"))
                                                                .frame(width:40, height: 40)
                                                        }
                                                }
                                                .offset(x: -10, y: -5)
                                            }
                                            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottomTrailing)

                                        }
                                        .frame(width: 120,height: 120)
                                    }
                                }
                                .frame(maxHeight: .infinity, alignment: .top)
                                .offset(y: -60)
                                .padding(.top)
                                
                            }
                            .padding(.top, 60)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            Button {
                                
                            } label: {
                                Button {
                                    showPicker.toggle()
                                } label: {
                                    HStack
                                    {
                                        Image("addphoto")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundColor(.white)
                                            .frame(width: 24, height: 24)
                                        Text("Chụp ảnh")
                                            .fontWeight(.bold)
                                        
                                    }
                                    .foregroundColor(.white)
                                    .frame(height: 52)
                                    .frame(maxWidth: .infinity)
                                    .background(Color("button_background"))
                                    .cornerRadius(65)
                                }
                            }

                            Button {
                                checkin()
                            } label: {
                                HStack
                                {
                                    Image("location")
                                        .renderingMode(.template)
                                        .foregroundColor(.white)
                                    Text("Check in")
                                        .fontWeight(.bold)
                                    
                                }
                                .foregroundColor(.white)
                                .frame(height: 52)
                                .frame(maxWidth: .infinity)
                                .background(Color("button_background"))
                                .cornerRadius(65)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
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
            .offset(x: isAppear ? 0 : geo.size.width + 50)
            .onAppear
            {
                data = vc.getData("participantData",andRemove: true) as? ParticipantData
                withAnimation(.easeInOut(duration: 0.5))
                {
                    isAppear = true
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
            .fullScreenCover(isPresented: $showPicker) {
                SinglePhotoPickerView(sourceType: .camera, onImagePicked: {
                    img in
                        avatar = img
                }, onCancel: {
                    showPicker = false
                })
            }

        }
    }
}

struct ParticipantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantDetailView()
    }
}
