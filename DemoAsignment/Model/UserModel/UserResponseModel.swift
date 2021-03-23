
import Foundation
import CoreData

struct UserResponse : Codable {

        let id : String?
        let age : Int?
        let email : String?
        let favoriteColor : String?
        let gender : String?
        let geoLocation : UserGeoLocation?
        let lastSeen : String?
        let name : String?
        let phone : String?
        let picture : String?

        enum CodingKeys: String, CodingKey {
                case id = "_id"
                case age = "age"
                case email = "email"
                case favoriteColor = "favoriteColor"
                case gender = "gender"
                case geoLocation = "geoLocation"
                case lastSeen = "lastSeen"
                case name = "name"
                case phone = "phone"
                case picture = "picture"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                age = try values.decodeIfPresent(Int.self, forKey: .age)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                favoriteColor = try values.decodeIfPresent(String.self, forKey: .favoriteColor)
                gender = try values.decodeIfPresent(String.self, forKey: .gender)
                geoLocation = try UserGeoLocation(from: decoder)
                lastSeen = try values.decodeIfPresent(String.self, forKey: .lastSeen)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                phone = try values.decodeIfPresent(String.self, forKey: .phone)
                picture = try values.decodeIfPresent(String.self, forKey: .picture)
        }

}


struct UserGeoLocation :  Codable {

        let latitude : Float?
        let longitude : Float?

        enum CodingKeys: String, CodingKey {
                case latitude = "latitude"
                case longitude = "longitude"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                latitude = try values.decodeIfPresent(Float.self, forKey: .latitude)
                longitude = try values.decodeIfPresent(Float.self, forKey: .longitude)
        }

}
