//
//  ContentView.swift
//  SwiftUIAPICalls
//
//  Created by Jhon Freiman Arias on 7/02/23.
//

import SwiftUI


struct DealListView: View {
    @StateObject var DealsviewModel = DealsViewModel()
    @State private var searchText: String = ""
    
    var filteredDeals: [Deal] {
        if searchText.count == 0 {
            return DealsviewModel.deals
        } else {
            let resultsByName = DealsviewModel.deals.filter {$0.customerName.contains(searchText)}
            let resultsByPhone = DealsviewModel.deals.filter {$0.customerPhone.contains(searchText)}
            var resultsByProductName: [Deal] = []
            
            for deal in DealsviewModel.deals {
                for product in deal.productLines {
                    if let pd = product.name {
                        if pd.contains(searchText) {
                            print(deal)
                            resultsByProductName.append(deal)
                        }
                    }
                }
            }
            
            return resultsByName + resultsByPhone + resultsByProductName
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredDeals) {deal in
                    NavigationLink {
                        DealDetailView()
                    } label: {
                        if filteredDeals.count > 0 {
                            DealRowView(deal: deal)
                        } else {
                            VStack {
                                Text("No encontramos conincidencias")
                                    .padding(20)
                                ProgressView()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Deals")
        }
        .searchable(text: $searchText)
        .listStyle(PlainListStyle())
        .onAppear {
            DealsviewModel.fetchDeals()
        }
    }
}

struct DealListView_Previews: PreviewProvider {
    static var previews: some View {
        DealListView()
    }
}
