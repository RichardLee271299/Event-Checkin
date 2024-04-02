//
//  HttpPostMultipart.swift
//  Checkin
//
//  Created by VNDC on 21/06/2023.
//

import Foundation

/// Đối tượng dùng để xây dựng Multipart-Form Data và Request
struct HttpPostMultipart {
    private let boundary: String = "boundary-\(UUID().uuidString)"
    //private
    var httpBody = NSMutableData()
    
    let url: URL
    
    /// Khởi tạo với URL chỉ định tới vị trí cần trao đổi thông tin
    init(url: URL) {
        self.url = url
    }
    
    /// Thêm dữ liệu dạng Text vào Multipart-Form data
    func addText(name: String, value: String){
        var fieldString: String = "--\(boundary)\r\n"
        fieldString = "\(fieldString)Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString = "\(fieldString)Content-Type: text/plain; charset=ISO-8859-1\r\n"
        fieldString = "\(fieldString)Content-Transfer-Encoding: 8bit\r\n"
        fieldString = "\(fieldString)\r\n"
        fieldString = "\(fieldString)\(value)\r\n"
        httpBody.append(fieldString)
    }
    
    /// Thêm dữ liệu dạng tệp, bin,... vào Multipart-Form data
    func addFile(name: String, filename: String = "", data: Data, mimeType: String){
        var _fileName = filename
        if _fileName.isEmpty { _fileName = name }
        let fieldData = NSMutableData()
        fieldData.append("--\(boundary)\r\n")
        fieldData.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(_fileName)\"\r\n")
        fieldData.append("Content-Type: \(mimeType)\r\n")
        fieldData.append("Content-Transfer-Encoding: binary\r\n")
        fieldData.append("\r\n")
        fieldData.append(data)
        fieldData.append("\r\n")
        httpBody.append(fieldData as Data)
    }
    
    /// Hoàn thiện Multipart-Form data và chuyển đổi thành URLRequest
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        httpBody.append("--\(boundary)--")
        request.httpBody = httpBody as Data
        return request
    }
}

extension URLSession {
    func dataTask(with request: HttpPostMultipart,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    -> URLSessionDataTask {
        return dataTask(with: request.asURLRequest(), completionHandler: completionHandler)
    }
}

extension NSMutableData {
    func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
