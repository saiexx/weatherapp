//
//  NetworkService.swift
//  weatherapp
//
//  Created by Kasidid Wachirachai on 28/11/22.
//

import Foundation
import Alamofire
import SystemConfiguration

class NetworkService: NSObject {
    static let shared = NetworkService()
    
    private final let baseUrl = "https://api.openweathermap.org/data/2.5"
    private final let apiKey = "f1dfccb9d7146a737b6166587bbaadaf"
    
    func request<T: Decodable>(path: String,
                               body: [String:Any]?,
                               header: [String: Any]?,
                               param: String = "",
                               method: HTTPMethod = .post,
                               type: T.Type,
                               onSuccess: @escaping (_ result: T?) -> (),
                               onFailure: @escaping ((String) -> Void)) {
        var urlString = "\(baseUrl)\(path)"
        if param != "" {
            urlString = "\(urlString)?\(param)&appid=\(apiKey)"
        }
        
        if method == .get {
            urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.method = method
            
            print("=============== Start: Call Service ===============")
            print("URL :", url)
            print("Method : \(method.rawValue)")
            
            
            AF.request(request).validate(statusCode: 200...500).responseDecodable(of: type) { (response) in
                print(response.data.map {String(decoding: $0, as: UTF8.self)}!)
                switch response.result {
                case .success (let data):
                    if response.response!.statusCode < 300 {
                        onSuccess(data)
                    } else {
                        onFailure("something went wrong")
                    }
                    break
                case .failure(let error):
                    if let data = response.data {
                        do {
                            let responseJSON = try JSONSerialization.jsonObject(with: data) as? [String : Any]
                            if let message: String = responseJSON!["message"] as? String {
                                if !message.isEmpty {
                                    onFailure(message)
                                }
                            }
                        } catch {
                            onFailure("something went wrong")
                        }
                    } else {
                        onFailure(error.localizedDescription)
                        print(error)
                    }
                    break
                }
                print("=============== End: Call Service ===============")
            }
        } else {
            onFailure("Something went wrong")
        }
    }
}

