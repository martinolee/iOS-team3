import Alamofire

let baseUrl = "http://15.164.49.32"
let endPoint = "/accounts/duplicates/"

struct DuplicateResponse: Decodable {
  let detail: String
  let status: Int
  let code: String
}

AF.request(
  baseUrl + endPoint,
  method: .post,
  parameters: ["username": "test21232"],
  encoder: JSONParameterEncoder.default,
  headers: ["Content-Type": "application/json"]
)
  .validate(statusCode: 200..<300)
  .responseData { response in
    switch response.result {
    case .success(let data):
      print("success")
      print(data)
      if let res = try? JSONSerialization.jsonObject(with: data) as? [String: String] {
        print(res)
      }
      
    case .failure(let error):
      guard let data = response.data,
        let decodedData = try? JSONDecoder().decode(DuplicateResponse.self, from: data)
        else { return }
      print(response.response?.statusCode)
      print(decodedData)
      print(error.localizedDescription)
}
