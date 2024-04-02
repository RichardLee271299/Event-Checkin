//
//  ScanQRView.swift
//  Checkin
//
//  Created by VNDC on 20/06/2023.
//
import SwiftUI
import CodeScanner
struct ScanQRView: View {
    @StateObject var vc: AppState = AppState.share
    
    @State var scannerRefresh: String = UUID().uuidString
    
    @State var isAppear: Bool = false
    @State var isLoading: Bool = false
    @State var alertIsShow: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var alertButtonText: String = "OK"
    
    var body: some View {
        GeometryReader {geo in
            ZStack
            {
                VStack(alignment: .leading) {
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
                    VStack
                    {
                        Text("SCAN")
                            .font(.system(size: 32).bold())
                        Text("Đưa QR CODE vào vùng scan")
                            .foregroundColor(Color(rgb: "#646464"))
                            .tracking(1.2)
                    }
                    .frame(maxWidth: .infinity)
                    ZStack
                    {
                        CodeScannerView(codeTypes: [.qr],completion: handleScan)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .cornerRadius(24)
                            .id(scannerRefresh)
                        Image("scanQR_frame")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .frame(width: 205, height: 205)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: geo.size.height * 0.6)
                    .background
                    {
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color(rgb: "#d4d4d4"))
                    }
                    VStack
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
                       
                        VStack
                        {
                            Text("Sự kiện")
                                .foregroundColor(Color(rgb: "#646464"))
                            Text(vc.personal?.event_detail.name ?? "")
                                .foregroundColor(Color(rgb: "#020202"))
                                .font(.system(size: 20).bold())
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.7)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)

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
            .alert(isPresented: $alertIsShow) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text(alertButtonText))
                    {
                        scannerRefresh = UUID().uuidString
                    }
                ) // End of Alert
            } // End of alert
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

struct ScanQRView_Previews: PreviewProvider {
    static var previews: some View {
        ScanQRView()
    }
}
