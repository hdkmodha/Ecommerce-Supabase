struct Seller: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var imageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, name
        case imageUrl = "image_url"
    }
}