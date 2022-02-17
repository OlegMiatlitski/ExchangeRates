import Alamofire
struct APIManager {
    static let instance = APIManager()
    
    enum BaseConstant {
        static let baseURL = "https://rest.coinapi.io/v1"
    }
    
    enum EndPoints {
        static let exchanges = "/exchanges"
        static let assets = "/assets"
    }
    
   private let header: HTTPHeaders = [
        "X-CoinAPI-Key": "B7157CCD-7D88-49BB-9BC1-8358A24ECD26",
        "Accept": "application/json"
    ]
    
    func getJSON() {
        AF.request(BaseConstant.baseURL + EndPoints.assets, headers: header).responseJSON { response in
            print(response)
        }
    }
    
    func getAllExchanges(completion: @escaping(([CoinClientModel]) -> Void)) {
        AF.request(
            BaseConstant.baseURL + EndPoints.assets,
            method: .get,
            parameters: [:],
            headers: header
        ).responseDecodable(of: [CoinServerModel].self) { response in
            switch response.result {
            case .success(let data):
                let converteredModels = data.map(ModelConverter.instance.convert)
                completion(converteredModels)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    private init() { }
}

