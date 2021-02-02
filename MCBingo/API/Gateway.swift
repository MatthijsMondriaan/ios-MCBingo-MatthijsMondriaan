//
//  Gateway.swift
//  MCBingo
//
//  Created by Matthijs van der Linden on 02/02/2021.
//

import UIKit

class Gateway: NSObject {
    
    // MARK: - Constants
    
    static let shared = Gateway()
    
    // Do API stuff
    
    func getData() {
        // Create URL
        let url = URL(string: "https://rocbingo.mncr.nl/api/getPlayer/matthijs/12345")
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                
                
            }
            
            
        }
        task.resume()
    }

}
