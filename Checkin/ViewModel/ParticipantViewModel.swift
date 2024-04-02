//
//  CustomerDetailViewModel.swift
//  Checkin
//
//  Created by VNDC on 21/06/2023.
//

import Foundation

extension ParticipantDetailView
{
    func getParticipant()
    {
        if isLoading { return }
        isLoading = true
        
        //Url request
        let urlStr = URL_API().url + "GetParticipant"
        guard let url = URL(string: urlStr) else
        {
            alertTitle = "Lỗi kết nối"
            alertMessage = "URL GetParticipant không hợp lệ"
            alertIsShow.toggle()
            isLoading = false
            return
        }
        
        let request = HttpPostMultipart(url: url)
        request.addText(name: "token", value: vc.token)
        request.addText(name: "sku", value: vc.SKU_Participant)
        request.addText(name: "event_id", value: vc.personal?.event_detail.id ?? "")
        
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
                    self.data = participantData.data
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
    
    func checkin()
    {

        if isLoading { return }
        isLoading = true
        
        //Url request
        let urlStr = URL_API().url + "Checkin"
        guard let url = URL(string: urlStr) else
        {
            alertTitle = "Lỗi kết nối"
            alertMessage = "URL Checkin không hợp lệ"
            alertIsShow.toggle()
            isLoading = false
            return
        }
        
        let request = HttpPostMultipart(url: url)
        request.addText(name: "token", value: vc.token)
        request.addText(name: "sku", value: vc.SKU_Participant)
        request.addText(name: "event_id", value: vc.personal?.event_detail.id ?? "")
        if let gui = avatar
        {
            if gui.jpegData(compressionQuality: 1.0) != nil {
                request.addFile(name: "gui", filename: "gui.jpg", data: gui.jpegData(compressionQuality: 1.0)!, mimeType: "image/jpeg")
              } else {
                  if gui.pngData() != nil {
                      request.addFile(name: "gui", filename: "gui.png", data: gui.pngData()!, mimeType: "image/png")
                  }
              }
        }
        
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
                    vc.previousView = true
                    vc.currentView = .home
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
}
