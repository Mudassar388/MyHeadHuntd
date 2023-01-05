

import Foundation
import Alamofire

class APIHandler {
    
    var statusCode = Int.zero
    
    func handleResponse<T: Codable>(_ response: DataResponse<T, AFError>) -> Any? {
        switch response.result {
        case .success:
            return response.value
        case .failure:
            return nil
            
        }
    }
}
