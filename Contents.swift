import UIKit
import CryptoKit

func getData(urlRequest: String) {
    let urlRequest = URL(string: urlRequest)
    guard let url = urlRequest else { return }
    URLSession.shared.dataTask(with: url) { data, responce, error in
        if error != nil {
            print(error as Any)
        } else if let responce = responce as? HTTPURLResponse, responce.statusCode == 200 {
            guard let data = data else { return }
            let dataAsString = String(data: data, encoding: .utf8)
            print(dataAsString as Any)
        }
    }.resume()
}

func md5Hash(_ source: String) -> String {
    return Insecure.MD5.hash(data: source.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
}

let mdString = "1"
let marvelUrl = "https://gateway.marvel.com:443/v1/public/"
let privateKey = "4978f56b6a9a65904b65e24b3c227becdd6a6edd"
let publicKey = "7e764530496095635d5fdf9a842c189c"

let md5HachString = "\(mdString)\(privateKey)\(publicKey)"
let requestMarvel = "\(marvelUrl)\(publicKey)&hash=\(md5Hash(md5HachString))"

let data = "\(marvelUrl)comics?ts=\(mdString)&apikey=\(publicKey)&hash=\(md5Hash(md5HachString)))"

getData(urlRequest: data)

