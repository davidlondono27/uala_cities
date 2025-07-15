//
//  HomeView.swift
//  FeatureDemo
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import DomainLayer
import LocalizedStrings
import SwiftUI
import Theme

struct HomeView<ViewModel>: View where ViewModel: HomeViewModelProtocol {
    @StateObject private var viewModel: ViewModel

    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        NavigationSplitView {
            List(viewModel.filteredCities, selection: $viewModel.selectedCity) { city in
                cityButton(city)
                    .tag(city)
            }
            .searchable(text: $viewModel.filterText, placement: .sidebar)
            .listStyle(.plain)
            .navigationTitle(L10n.citySearcher)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image.logo
                        .resizable()
                        .scaledToFit()
                        .frame(width: .logoWidth)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showOnlyFavorites.toggle()
                    } label: {
                        Image(systemName: "heart\(viewModel.showOnlyFavorites ? ".fill" : "")")
                            .resizable()
                            .scaledToFit()
                            .frame(width: .favoriteIconSize)
                            .foregroundColor(.red)
                    }
                }
            }
        } detail: {
            MapView(city: $viewModel.selectedCity)
        }
        .onAppear(perform: viewModel.onAppear)
        .navigationSplitViewStyle(.balanced)
    }

    @ViewBuilder
    private func cityButton(_ city: City) -> some View {
        HStack(spacing: .zero) {
            Text("\(city.name), \(city.country)")
            Spacer()
            Button {
                viewModel.didTapFavorite(city)
            } label: {
                Image(systemName: viewModel.isFavorite(city) ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: .favoriteIconSize)
                    .foregroundColor(.red)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .contentShape(Rectangle())
    }
}

private extension CGFloat {
    static let logoWidth: CGFloat = 100
    static let eraseIconSize: CGFloat = 16
    static let favoriteIconSize: CGFloat = 16
    static let homeCommonSpacing: CGFloat = 12
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
