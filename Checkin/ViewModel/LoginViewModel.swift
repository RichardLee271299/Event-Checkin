//
//  LoginViewModel.swift
//  Checkin
//
//  Created by VNDC on 21/06/2023.
//

import Foundation

extension LoginView
{
    func doLogin()
    {
        
        if phone.isEmpty
        {
            message = "Số điện thoại bắt buộc nhập"
            return
        }
        if password.isEmpty
        {
            message = "Mật khẩu bắt buộc nhập"
            return
        }
        
        if isLoading { return }
        isLoading = true
        
        //Url request
        let urlStr = URL_API().url + "Login"
        guard let url = URL(string: urlStr) else
        {
            message = "URL Login không hợp lệ"
            isLoading = false
            return
        }
        
        let request = HttpPostMultipart(url: url)
        request.addText(name: "phone", value: phone)
        request.addText(name: "pwd", value: password)
        
        URLSession.shared.dataTask(with: request.asURLRequest()) { (data, rs, err) in
            
            //Kiểm tra có data không
            guard let data = data, err == nil else
            {
                DispatchQueue.main.async {
                    message = "Mạng chậm hoặc không có kết nối. Vui lòng kiểm tra kết nối mạng của bạn"
                    isLoading = false
                }
                return
            }
            //Kiểm tra status response
            if let hrs = rs as? HTTPURLResponse
            {
                if hrs.statusCode != 200
                {
                    DispatchQueue.main.async {
                        message = "[\(hrs.statusCode)] Không thể lấy dữ liệu từ máy chủ"
                        isLoading = false
                        return
                    }
                }
            }
            //Decode data
            let loginResponse = try! JSONDecoder().decode(LoginResponse.self, from: data)
            let status = loginResponse.status
            
            if status == "OK"
            {
                DispatchQueue.main.async {
                    vc.personal = loginResponse.data
                    vc.token = loginResponse.token ?? ""
                    vc.currentView = .home
                }
            }
            else
            {
                message = loginResponse.message ?? "Không có nội dung"
                isLoading = false
                return
            }
        }
        .resume()
    }
}
