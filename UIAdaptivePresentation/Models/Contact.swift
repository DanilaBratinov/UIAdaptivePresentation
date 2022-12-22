struct Contact: Codable {
    let name: String
    let surname: String
    
    var fullName: String {
        "\(name) \(surname)"
    }
}
