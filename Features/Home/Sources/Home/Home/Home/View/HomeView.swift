//
//  HomeView.swift
//  FeatureDemo
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import LocalizedStrings
import SwiftUI
import Theme

struct HomeView<ViewModel>: View where ViewModel: HomeViewModelProtocol {
    @StateObject private var viewModel: ViewModel

    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        VStack {
            Image.logo
                .frame(width: 200)
            Text(L10n.yourTextHere)
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
