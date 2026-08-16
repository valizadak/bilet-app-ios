//
//  AppLanguage.swift
//  Bilet.az
//
//  Tətbiqin dilinin saxlanması və dəyişdirilməsi.
//
//  iOS-da dil `AppleLanguages` açarı ilə idarə olunur. Dəyişiklik yalnız
//  tətbiq yenidən açılanda qüvvəyə minir — sistem resurs paketini işə
//  düşəndə bir dəfə oxuyur. Android-də prosesi özümüz yenidən başladırdıq,
//  iOS-da bu qadağandır (App Store rədd edir), ona görə istifadəçiyə
//  tətbiqi bağlayıb açması bildirilir.
//

import Foundation

enum AppLanguage {

	/// Sıra dialoqda göstərilmə ardıcıllığıdır.
	static let supported: [(code: String, title: String)] = [
		("az", "Azərbaycan"),
		("en", "English"),
		("ru", "Русский"),
		("tr", "Türkçe"),
	]

	private static let key = "AppleLanguages"
	private static let fallback = "az"

	/// Hazırda seçilmiş dilin iki hərfli kodu.
	static var current: String {
		let stored = UserDefaults.standard.stringArray(forKey: key)?.first
		let identifier = stored ?? Locale.preferredLanguages.first ?? fallback
		let code = String(identifier.prefix(2)).lowercased()
		return supported.contains { $0.code == code } ? code : fallback
	}

	/// Başlıqdakı düymədə göstərilən qısa ad: AZ, EN, RU, TR
	static var currentShortTitle: String {
		current.uppercased()
	}

	static func set(_ code: String) {
		UserDefaults.standard.set([code], forKey: key)
		UserDefaults.standard.synchronize()
	}
}
