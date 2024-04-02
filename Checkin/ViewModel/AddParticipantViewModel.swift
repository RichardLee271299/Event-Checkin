//
//  AddParticipantViewModel.swift
//  Checkin
//
//  Created by VNDC on 21/06/2023.
//

import Foundation

extension AddParticipant
{
    func addParticipant()
    {
        if name.isEmpty
        {
            alertTitle = "Thông báo"
            alertMessage = "Họ tên bắt buộc nhập"
            alertIsShow.toggle()
            return
        }
        
        if phone.isEmpty
        {
            alertTitle = "Thông báo"
            alertMessage = "Số điện thoại bắt buộc nhập"
            alertIsShow.toggle()
            return
        }
        
        if !CheckPhone(for: phone)
        {
            alertTitle = "Thông báo"
            alertMessage = "Số điện thoại không đúng định dạng"
            alertIsShow.toggle()
            return
        }
        
        if !email.isEmpty && !CheckEmail(for: email)
        {
            alertTitle = "Thông báo"
            alertMessage = "Email không đúng định dạng"
            alertIsShow.toggle()
            return
        }
        
        
        
        if isLoading { return }
        isLoading = true
        
        //Url request
        let urlStr = URL_API().url + "AddParticipant"
        guard let url = URL(string: urlStr) else
        {
            alertTitle = "Lỗi kết nối"
            alertMessage = "URL AddParticipant không hợp lệ"
            alertIsShow.toggle()
            isLoading = false
            return
        }
        let request = HttpPostMultipart(url: url)
        request.addText(name: "token", value: vc.token)
        request.addText(name: "event_id", value: vc.personal?.event_detail.id ?? "")
        request.addText(name: "sku", value: vc.SKU_Participant)
        request.addText(name: "name", value: name)
        request.addText(name: "gender", value: gender == .men ? "0" : gender == .women ? "1" : "2")
        request.addText(name: "phone", value: phone)
        request.addText(name: "email", value: email)
        request.addText(name: "level", value: selectedLevels?.name ?? "")
        
        
        URLSession.shared.dataTask(with: request.asURLRequest()) { (data, rs, err) in
            
            //Kiểm tra có data không
            guard let data = data, err == nil else
            {
                DispatchQueue.main.async {
                    
                    alertTitle = "Không có kết nối Internet"
                    alertMessage = "Mạng chậm hoặc không có kết nối. Vui lòng kiểm tra kết nối mạng của bạn"
                    alertIsShow.toggle()
                    isLoading = false
                    return
                }
                return
            }
            //Kiểm tra status response
            if let hrs = rs as? HTTPURLResponse
            {
                if hrs.statusCode != 200
                {
                    DispatchQueue.main.async {
                        alertTitle = "Lỗi kết nối"
                        alertMessage = "[\(hrs.statusCode)] Không thể lấy dữ liệu từ máy chủ"
                        alertIsShow.toggle()
                        isLoading = false
                        return
                    }
                }
            }
            //Decode data
            let participantData = try! JSONDecoder().decode(ParticipantResponse.self, from: data)
            let status = participantData.status
            if status == "OK"
            {
                DispatchQueue.main.async {
                    vc.setData("participantData", value: participantData.data)
                    vc.SKU_Participant = participantData.data?.sku ?? ""
                    vc.currentView = .paticipantDetail
                    isLoading = false
                }
            }
            else
            {
                alertTitle = "Lỗi kết nối"
                alertMessage = participantData.message ?? "Không có nội dung"
                alertIsShow.toggle()
                isLoading = false
            }
        }
        .resume()
    }
    
    func getLevels()
    {
        if isLoading { return }
        isLoading = true
        
        //Url request
        let urlStr = URL_API().url + "GetLevels"
        guard let url = URL(string: urlStr) else
        {
            alertTitle = "Lỗi kết nối"
            alertMessage = "URL GetLevels không hợp lệ"
            alertIsShow.toggle()
            isLoading = false
            return
        }
        let request = HttpPostMultipart(url: url)
        request.addText(name: "token", value: vc.token)
        
        URLSession.shared.dataTask(with: request.asURLRequest()) { (data, rs, err) in
            
            //Kiểm tra có data không
            guard let data = data, err == nil else
            {
                DispatchQueue.main.async {
                    
                    alertTitle = "Không có kết nối Internet"
                    alertMessage = "Mạng chậm hoặc không có kết nối. Vui lòng kiểm tra kết nối mạng của bạn"
                    alertIsShow.toggle()
                    isLoading = false
                    return
                }
                return
            }
            //Kiểm tra status response
            if let hrs = rs as? HTTPURLResponse
            {
                if hrs.statusCode != 200
                {
                    DispatchQueue.main.async {
                        alertTitle = "Lỗi kết nối"
                        alertMessage = "[\(hrs.statusCode)] Không thể lấy dữ liệu từ máy chủ"
                        alertIsShow.toggle()
                        isLoading = false
                        return
                    }
                }
            }
            //Decode data
            let levelResponse = try! JSONDecoder().decode(GetLevelsResponse.self, from: data)
            let status = levelResponse.status
            if status == "OK"
            {
                DispatchQueue.main.async {
                    
                    levels = levelResponse.list ?? []
                    if !levels.isEmpty
                    {
                        selectedLevels = levels.first
                    }
                    isLoading = false
                }
            }
            else
            {
                alertTitle = "Lỗi kết nối"
                alertMessage = levelResponse.message ?? "Không có nội dung"
                alertIsShow.toggle()
                isLoading = false
            }
        }
        .resume()
    }
    
    //Kiểm tra định dạng email
    func CheckEmail(for email: String) -> Bool
    {
        let email_no_whitespace: String = email.replacingOccurrences(of: " ", with: "")
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" // short format
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email_no_whitespace)
    }
    
    
    // Kiểm tra định dạng số điện thoại
    func CheckPhone(for phone:String) -> Bool {
        
        let phone_no_whitespace = phone.replacingOccurrences(of: " ", with: "")
        
        print(phone_no_whitespace)
        if !phone_no_whitespace.isNumber
        {
            return false
        }
        
        if (phone_no_whitespace.count != 10) {
            return false;
        } else {
            let first = phone_no_whitespace.prefix(3);
            if ( ["096","097","098","090","093","091","094","092","099",
                  "089","081","082","083","084","085","088","086",
                  "070","076","077","078","079",
                  "056","059","058",
                  "032","033","034","035","036","037","038","039"].contains(first)
            ) {
                return true;
            } else {
                return false;
            }
        }
    }

}
