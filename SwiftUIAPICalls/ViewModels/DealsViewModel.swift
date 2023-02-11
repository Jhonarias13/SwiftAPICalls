//
//  ViewModel.swift
//  SwiftUIAPICalls
//
//  Created by Jhon Freiman Arias on 8/02/23.
//

import Foundation


class DealsViewModel: ObservableObject {
    @Published var deals: [Deal] = []
    @Published var isLoading: Bool = false
    
    func fetchDeals() {
        self.isLoading = true
        guard let url = URL(string: "https://api.adgency.us/api/omnibot/deals/all/?status=new&search_string=&limit=100&skip=0") else {
            print("Ups! Invalid URL")
            return
        }
        
        let deal = URLSession.shared.dataTask(with: url) { [unowned self] data, response,
            error in
            guard let data = data, error == nil else {
                return
            }
            
            // convert to JSON
            do {
                let deals = try JSONDecoder().decode([Deal].self, from: data)
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.deals = deals
                }
            }
            catch {
                print("aqui el error =>", error)
            }
        }
        
        deal.resume()
    }
}
