//
//  AddCustomer.swift
//  Checkin
//
//  Created by VNDC on 20/06/2023.
//

import SwiftUI

struct AddParticipant: View {
    enum gender_state
    {
        case men
        case women
        case other
    }
    @StateObject var vc: AppState = AppState.share
    
    @State var isAppear: Bool = false
    @State var name: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var gender: gender_state = .other
    
    @State var levels: [ID_Name_Model] = []
    @State var selectedLevels: ID_Name_Model? = nil
    
    @State var isLoading: Bool = false
    @State var alertIsShow: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var alertButtonText: String = "OK"
    
    var body: some View {
        
        GeometryReader { geo in
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
                .padding(.top, 10)
                ScrollView(showsIndicators: false)
                {
                    VStack(alignment: .leading, spacing: 20)
                    {
                        Text("Thêm khách mời")
                            .font(.system(size: 24).weight(.medium))
                            .padding(.vertical)
                        VStack(alignment: .leading,spacing: 0)
                        {
                            Text("HỌ TÊN")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundColor(Color(rgb: "#808080"))
                                .tracking(1.5)
                            TextField("", text: $name)
                                .placeholder(when: name.isEmpty) {
                                    Text("Nhập họ tên").foregroundColor(.black).font(.system(size: 16).weight(.medium))
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
                        
                        VStack(alignment: .leading)
                        {
                            Text("GIỚI TÍNH")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundColor(Color(rgb: "#808080"))
                                .tracking(1.5)
                            
                            HStack(spacing: 20)
                            {
                                Button  {
                                    gender = .men
                                } label: {
                                    HStack
                                    {
                                        ZStack
                                        {
                                            Circle()
                                                .stroke(Color.black,lineWidth: 2)
                                                .frame(width: 20, height: 20)
                                            if gender == .men
                                            {
                                                Circle()
                                                    .frame(width: 10, height: 10)
                                            }
                                        }
                                        Text("Nam")
                                            .font(.system(size: 16).weight(.medium))
                                    }
                                    .foregroundColor(Color(rgb: "#333333"))
                                }
                                
                                Button  {
                                    gender = .women
                                } label: {
                                    HStack
                                    {
                                        ZStack
                                        {
                                            Circle()
                                                .stroke(Color.black,lineWidth: 2)
                                                .frame(width: 20, height: 20)
                                            if gender == .women
                                            {
                                                Circle()
                                                    .frame(width: 10, height: 10)
                                            }
                                        }
                                        Text("Nữ")
                                            .font(.system(size: 16).weight(.medium))
                                    }
                                    .foregroundColor(Color(rgb: "#333333"))
                                }
                                
                                
                                Button  {
                                    gender = .other
                                } label: {
                                    HStack
                                    {
                                        ZStack
                                        {
                                            Circle()
                                                .stroke(Color.black,lineWidth: 2)
                                                .frame(width: 20, height: 20)
                                            if gender == .other
                                            {
                                                Circle()
                                                    .frame(width: 10, height: 10)
                                            }
                                        }
                                        Text("Khác")
                                            .font(.system(size: 16).weight(.medium))
                                    }
                                    .foregroundColor(Color(rgb: "#333333"))
                                }
                                
                            }
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .padding(.vertical,16)
                            .padding(.horizontal,4)
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
                        
                        VStack(alignment: .leading,spacing: 0)
                        {
                            Text("EMAIL")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundColor(Color(rgb: "#808080"))
                                .tracking(1.5)
                            TextField("", text: $email)
                                .placeholder(when: email.isEmpty) {
                                    Text("Nhập email").foregroundColor(.black).font(.system(size: 16).weight(.medium))
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
                        
                        VStack(alignment: .leading,spacing: 0)
                        {
                            Text("CẤP ĐỘ KHÁCH MỜI")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundColor(Color(rgb: "#808080"))
                                .tracking(1.5)
                            Menu(content: {
                                ForEach(levels, id: \.id) {level in
                                    Button {
                                        selectedLevels = level
                                    } label: {
                                        Text(level.name)
                                            .foregroundColor(Color(rgb: "#333333"))
                                    }
                                }
                            }, label: {
                                HStack
                                {
                                    Text(selectedLevels == nil ? "Chọn cấp độ khách mời" : selectedLevels?.name ?? "")
                                        .layoutPriority(1)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                                .padding(.vertical,12)
                                .foregroundColor(Color(rgb: "#333333"))
                                .background(Color(rgb: "#f1f1f1"))
                                .font(.system(size: 16).weight(.medium))
                                .cornerRadius(8)
                            })
                            .padding(.vertical,16)
                            .frame(maxWidth: .infinity)
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
                        
                        
                        Button {
                            addParticipant()
                        } label: {
                            HStack
                            {
                                Text("Thêm")
                                    .fontWeight(.medium)
                                Image("arrow_right")
                            }
                            .foregroundColor(.white)
                            .frame(height: 48)
                            .frame(maxWidth: .infinity)
                            .background(Color("button_background"))
                            .cornerRadius(8)
                        }
                        .padding(.vertical,10)
                        
                        VStack(spacing: 18)
                        {
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
                           
                            VStack(spacing: 8)
                            {
                                Text("Sự kiện")
                                    .foregroundColor(Color(rgb: "#646464"))
                                Text("\(vc.personal?.event_detail.name ?? "")")
                                    .foregroundColor(Color(rgb: "#020202"))
                                    .font(.system(size: 20).bold())
                                    .multilineTextAlignment(.center)
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.7)
                            
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .offset(x: isAppear ? 0 : geo.size.width + 50)
            .onAppear
            {
                getLevels()
                withAnimation(.easeInOut(duration: 0.5))
                {
                    isAppear = true
                }
            }
            .alert(isPresented: $alertIsShow) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text(alertButtonText))
                ) // End of Alert
            } // End of alert

        }
    }
}

struct AddParticipant_Previews: PreviewProvider {
    static var previews: some View {
        AddParticipant()
    }
}
