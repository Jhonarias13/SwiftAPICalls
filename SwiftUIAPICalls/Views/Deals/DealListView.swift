//
//  ContentView.swift
//  SwiftUIAPICalls
//
//  Created by Jhon Freiman Arias on 7/02/23.
//

import SwiftUI


struct DealListView: View {
    @StateObject var DealsviewModel = DealsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(DealsviewModel.deals, id: \.id) {deal in
                    DealRowView(deal: deal)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Deals")
            .onAppear {
                DealsviewModel.fetchDeals()
            }
        }
    }
}

struct DealListView_Previews: PreviewProvider {
    static var previews: some View {
        DealListView()
    }
}
