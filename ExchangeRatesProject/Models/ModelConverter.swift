import Foundation
struct ModelConverter {
    static let instance = ModelConverter()
    
    func convert(_ serverModel: CoinServerModel) -> CoinClientModel {
        let clientModel = CoinClientModel(
            assetId: serverModel.asset_id,
            name: serverModel.name,
            priceUsd: serverModel.price_usd
        )
        return clientModel
    }
    private init() {}
}

