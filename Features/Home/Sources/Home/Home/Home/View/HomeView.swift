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
        VStack(spacing: .homeCommonSpacing) {
            Image.logo
                .resizable()
                .scaledToFit()
                .frame(width: .logoWidth)
            VStack(spacing: .homeCommonSpacing) {
                Text(L10n.welcome)
                    .font(.title3)
                Text(L10n.citySearcher)
                    .font(.body)
            }
            VStack(spacing: .homeCommonSpacing) {
                HStack(spacing: .zero) {
                    TextField(
                        "",
                        text: $viewModel.filterText,
                        prompt: Text(L10n.searchACity)
                    )
                    Button {
                        viewModel.didTapCleanAll()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: .eraseIconSize)
                    }
                }
                List(viewModel.filteredCities) { city in
                    Text("\(city.name), \(city.country)")
                }
                .listStyle(.plain)
            }
            .padding(.horizontal, 24)
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

private extension CGFloat {
    static let logoWidth: CGFloat = 150
    static let eraseIconSize: CGFloat = 16
    static let homeCommonSpacing: CGFloat = 12
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
	
