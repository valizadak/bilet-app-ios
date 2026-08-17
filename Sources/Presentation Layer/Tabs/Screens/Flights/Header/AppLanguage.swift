//
//  AppLanguage.swift
//  Bilet.az
//
//  Tətbiqin hazırkı dili.
//
//  Dil iOS-un öz "Preferred Language" mexanizmi ilə idarə olunur: istifadəçi
//  onu telefonun ayarlarında, tətbiqin öz səhifəsində dəyişir. Sistem
//  dəyişikliyi tətbiq edib tətbiqi özü yenidən açır — bizim tərəfdən
//  yaddaşa yazmağa və ya prosesi yenidən başlatmağa ehtiyac yoxdur.
//
//  Bu bölmə iOS-da yalnız bir neçə dil resursu olan tətbiqlərdə görünür;
//  bizdə 29 dil var, ona görə həmişə mövcuddur.
//

import Foundation

enum AppLanguage {

	private static let fallback = "az"
	private static let known = ["az", "en", "ru", "tr"]

	/// Sistemin tətbiq üçün seçdiyi dilin iki hərfli kodu.
	static var current: String {
		let identifier = Bundle.main.preferredLocalizations.first
			?? Locale.preferredLanguages.first
			?? fallback
		let code = String(identifier.prefix(2)).lowercased()
		return known.contains(code) ? code : fallback
	}

	/// Başlıqdakı düymədə göstərilən qısa ad: AZ, EN, RU, TR
	static var currentShortTitle: String {
		current.uppercased()
	}

	// MARK: - İlk açılışda dilin təyini

	private static let languagesKey = "AppleLanguages"
	private static let defaultAppliedKey = "bilet_default_language_applied"

	/// Tətbiq ilk dəfə açılanda dili azərbaycancaya çevirir.
	///
	/// Müştərilərimiz Azərbaycandandır, ona görə telefonun dili rus və ya
	/// ingilis olsa belə tətbiq azərbaycanca açılmalıdır.
	///
	/// Yalnız bir dəfə edilir: sonradan istifadəçi telefonun ayarlarından
	/// başqa dil seçsə, seçimi pozulmasın deyə bir daha müdaxilə olunmur.
	///
	/// Mümkün qədər erkən — interfeys qurulmamışdan əvvəl çağırılmalıdır.
	static func applyDefaultOnFirstLaunch() {
		let defaults = UserDefaults.standard

		guard !defaults.bool(forKey: defaultAppliedKey) else {
			return
		}
		defaults.set(true, forKey: defaultAppliedKey)

		var order = defaults.stringArray(forKey: languagesKey) ?? Locale.preferredLanguages
		order.removeAll { $0.lowercased().hasPrefix(fallback) }
		order.insert(fallback, at: 0)

		defaults.set(order, forKey: languagesKey)
		defaults.synchronize()
	}
}
