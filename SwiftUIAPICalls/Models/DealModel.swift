//
//  Model.swift
//  SwiftUIAPICalls
//
//  Created by Jhon Freiman Arias on 8/02/23.
//

import Foundation


/**
 {
 "customer": {
     "name": "Yesenia Valdelamar ",
     "phone": "3117551060",
     "business_type": "Persona",
     "city": null,
     "email": "Y-vanu@outlook.com ",
     "device_type": null,
     "origin": "pharmarket.co",
     "priority_text": "24 Hrs",
     "priority_in_hours": "24"
 },
 "consecutive": 1279,
 "status": "new",
 "close_description": null,
 "observation": null,
 "ref_code": "119857578",
 "seller_id": null,
 "_id": "63e7095797345a0036bfa313",
 "product_lines": [
     {
     "name": "Nedox 5 mg Granulado x 1 U",
     "drug_id": "nedox-5-mg-con-2-20075204-1",
     "presentation_id": "nedox-5-mg-caja-con-1-20075204-7",
     "quantity": "1",
     "target_price": null,
     "_id": "63e7095797345a0036bfa314"
     }
 ],
 "createdAt": "2023-02-11T03:19:51.222Z",
 "updatedAt": "2023-02-11T03:19:51.222Z"
 }
 */

struct ProductLine: Codable, Identifiable {
    let name: String?
    let drugId: String?
    let presentationId: String?
    let quantity: String
    let targetPrice: Int?
    let id: String
    
    enum CodingKeys: String, CodingKey  {
        case name
        case quantity
        case drugId = "drug_id"
        case presentationId = "presentation_id"
        case targetPrice = "target_price"
        case id = "_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.drugId = try values.decode(String?.self, forKey: .drugId)
        self.presentationId = try values.decode(String?.self, forKey: .presentationId)
        self.targetPrice = try values.decode(Int?.self, forKey: .targetPrice)
        self.id = try values.decode(String.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.quantity = try values.decode(String.self, forKey: .quantity)
    }
    
    init(name: String, drugId: String, presentationId: String, quantity: String, targetPrice: Int, id: String) {
        self.name = name
        self.drugId = drugId
        self.presentationId = presentationId
        self.quantity = quantity
        self.targetPrice = targetPrice
        self.id = id
    }
    
    static func exampleProductLine() -> Self {
        return ProductLine(
            name: "Acetaminofen 500mg",
            drugId: "acetaminofen-500mg-20-tabletas",
            presentationId: "acetaminofen-500mg-20-tabletas-123123",
            quantity: "20",
            targetPrice: 0,
            id: "1"
        )
    }
    
}

struct Deal: Decodable, Identifiable {
    let customerName: String
    let customerPhone: String
    let customerOrigin: String
    let consecutive: Int
    let status: String
    let id: String
    let productLines: [ProductLine]
    let priotiryInHours: String
    
    enum CodingKeys: String, CodingKey {
        case customer
        case customerName
        case customerPhone
        case customerOrigin
        case consecutive
        case priority = "priority_in_hours"
        case name
        case phone
        case origin
        case status
        case id = "_id"
        case productLines = "product_lines"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let customerContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .customer)
        self.customerName = try customerContainer.decode(String.self, forKey: .name)
        self.customerPhone = try customerContainer.decode(String.self, forKey: .phone)
        self.customerOrigin = try customerContainer.decodeIfPresent(String.self, forKey: .origin) ?? "bot whatsapp"
        self.priotiryInHours = try customerContainer.decodeIfPresent(String.self, forKey: .priority) ?? "sin definir"
        
        self.id = try container.decode(String.self, forKey: .id)
        self.productLines = try container.decodeIfPresent([ProductLine].self, forKey: .productLines) ?? []
        self.consecutive = try container.decode(Int.self, forKey: .consecutive)
        self.status = try container.decode(String.self, forKey: .status)
    }
    
    init(customerName: String, customerPhone: String, customerOrigin: String, consecutive: Int, status: String, id: String, productLines: [ProductLine]?, priotiryInHours: String ) {
        self.customerName = customerName
        self.customerPhone = customerPhone
        self.customerOrigin = customerOrigin
        self.consecutive = consecutive
        self.status = status
        self.id = id
        self.productLines = productLines ?? []
        self.priotiryInHours = priotiryInHours
    }
    
    static func exampleDeal() -> Self {
        return Deal(customerName: "Jhoncito",
                    customerPhone: "3012025584",
                    customerOrigin: "pharmarket.co",
                    consecutive: 1001,
                    status: "Nuevo",
                    id: "1",
                    productLines: [ProductLine.exampleProductLine()],
                    priotiryInHours: "24 hours")
    }
}
