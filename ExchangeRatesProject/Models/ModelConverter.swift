struct ModelConverter {
    static let instance = ModelConverter()
    
    func convert(_ serverModel: CoinServerModel) -> CoinClientModel {
        let assetId = Int(serverModel.asset_id ?? "none") ?? 0
        let priceUsd = Double(serverModel.price_usd ?? 0)
        let clientModel = CoinClientModel(
            assetId: assetId,
            name: serverModel.name,
            priceUsd: priceUsd
        )
        return clientModel
    }
}
