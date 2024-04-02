//
//  ViewController.swift
//  Checkin
//
//  Created by VNDC on 17/06/2023.
//

import SwiftUI

struct ViewController: View {
    @StateObject var state = AppState.share
    var body: some View {
        switch state.currentView
        {
            case .loginSplash, .home, .empty:
                MainView()
            case .login, .scan, .paticipantDetail, .addPaticipant:
                DetailView()
        }
    }
}

class AppState: ObservableObject
{
    
    enum viewcase
    {
        case empty
        case loginSplash
        case login
        case home
        case scan
        case paticipantDetail
        case addPaticipant
        
    }
    
    static var share = AppState()
    
    ///Biến đánh dấu lần đầu mở app để hiện loadding
    var firstTimeLoading: Bool = true
    
    ///Hiển thị loadding
    @Published var isShowLoading: Bool = false
    
    ///Điều hướng view
    @Published var currentView: viewcase = .empty
    
    ///Đánh dấu trở về view trước
    @Published var previousView: Bool = false
    
    //Thông tin cá nhân
    @Published var personal: Personal? = nil
    
    //Token cá nhân
    @Published var token: String = ""
    
    //SKU của khách mời
    @Published var SKU_Participant: String = ""
    
    
    /// Dữ liệu trung chuyển (nếu có)
     var data: [String:Any] = [:]
    
     /// Lấy dữ liệu trung chuyển
     func getData(_ key: String, andRemove: Bool = false) -> Any? {
         let temp: Any? = data[key]
         if andRemove {
             data[key] = nil
         }
         return temp
     }
     
     /// Đặt dữ liệu trung chuyển
     func setData(_ key: String, value: Any? = nil) {
         data[key] = value
     }
}
