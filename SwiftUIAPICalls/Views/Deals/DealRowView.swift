//
//  DealRowView.swift
//  SwiftUIAPICalls
//
//  Created by Jhon Freiman Arias on 11/02/23.
//

import SwiftUI

struct DealRowView: View {
    var deal: Deal
    var body: some View {
        HStack{
            VStack {
                Text(deal.productLines[0].name ?? "-")
                    .bold()
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(deal.customerName)
                    .font(.system(size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(deal.customerPhone)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(deal.customerOrigin)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DealRowView_Previews: PreviewProvider {
    static var previews: some View {
        DealRowView(deal: Deal.exampleDeal())
    }
}
