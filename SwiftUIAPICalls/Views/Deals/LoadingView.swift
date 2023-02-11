//
//  LoadingView.swift
//  SwiftUIAPICalls
//
//  Created by Jhon Freiman Arias on 11/02/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
            Text("Cargando deals..")
                .padding(32)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
