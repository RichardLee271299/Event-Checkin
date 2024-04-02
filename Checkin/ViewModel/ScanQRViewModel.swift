//
//  ScanQRViewModel.swift
//  Checkin
//
//  Created by VNDC on 21/06/2023.
//

import Foundation
import CodeScanner

extension ScanQRView
{
    
    //Xử lý khi scan xong
    func handleScan(result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            vc.SKU_Participant = details[0]
            getParticipantFromScan()
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
        
    }
    
    
    func getParticipantFromScan()
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
}
