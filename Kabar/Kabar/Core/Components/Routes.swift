//
//  Routes.swift
//  Kabar
//
//  Created by user on 10/08/26.
//

enum AuthRoute: Hashable {
    case login
    case dashboard
}

enum AppRoute: Hashable {
    case newsDetail(Articles)
    case newsDetailSaved(NewsArticleSave)
}
