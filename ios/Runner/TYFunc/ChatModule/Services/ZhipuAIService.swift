import Foundation

class ZhipuAIService {
    static let shared = ZhipuAIService()
    private let apiKey = "af3b1eb7708e4695982c5de683da9053.1IEgM9INrDM7Jo28"
    private let baseURL = "https://open.bigmodel.cn/api/paas/v4/chat/completions"
    
    private init() {}
    
    func sendMessage(_ message: String, completion: @escaping (Result<String, Error>) -> Void) {
        var request = URLRequest(url: URL(string: baseURL)!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "model": "glm-4-flash",
            "messages": [
                ["role": "user", "content": message]
            ],
            "temperature": 0.7,
            "top_p": 0.7,
            "max_tokens": 1024
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let choices = json["choices"] as? [[String: Any]],
                  let firstChoice = choices.first,
                  let message = firstChoice["message"] as? [String: Any],
                  let content = message["content"] as? String else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "AI", code: -1, userInfo: [NSLocalizedDescriptionKey: "解析响应失败"])))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(content))
            }
        }.resume()
    }
} 
