//
//  MainView.swift
//  SwiftUIAPICalls
//
//  Created by Jhon Freiman Arias on 8/02/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var dealsViewModel: DealsViewModel = DealsViewModel()
    var body: some View {
        
        if dealsViewModel.isLoading {
            LoadingView()
        }
        TabView{
            DealListView()
                .tabItem {
                    Label("Deals", systemImage: "list.bullet")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
