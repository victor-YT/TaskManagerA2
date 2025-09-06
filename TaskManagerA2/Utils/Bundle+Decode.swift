import Foundation

extension Bundle {
    /// Decode JSON from the main bundle (common classroom pattern)
    func decode<T: Decodable>(_ file: String,
                              dateDecoding: JSONDecoder.DateDecodingStrategy = .iso8601) -> T {
        guard let url = url(forResource: file, withExtension: nil) else {
            fatalError("Resource not found: \(file)")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load data: \(file)")
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecoding
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode: \(file)")
        }
        return loaded
    }
}
