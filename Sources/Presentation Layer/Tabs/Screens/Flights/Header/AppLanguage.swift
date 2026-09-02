//
//  AppLanguage.swift
//  Bilet.az
//
//  Tətbiqin hazırkı dili.
//
//  Dil tamamilə iOS-un öz mexanizmi ilə idarə olunur: sistem cihazın dilinə
//  uyğun resurs paketini seçir, istifadəçi isə onu telefonun ayarlarında,
//  tətbiqin öz səhifəsində ("Preferred Language") dəyişə bilir.
//
//  ⚠️ DİLİ KODDAN MƏCBUR ETMƏK OLMAZ — iki dəfə sınandı, hər dəfə interfeys
//  qarışıq dildə göründü və App Store rədd cavabı verdi (Guideline 4 —
//  "mixed languages"):
//
//    1-ci cəhd: `AppleLanguages` açarı yazıldı. Resurs paketi proses işə
//       düşəndə artıq seçilmiş olduğu üçün sabit mətnlər cihazın dilində
//       qaldı, konfiqurasiyadan gələnlər (tab adı, əlaqə linki) isə
//       azərbaycanca oldu.
//
//    2-ci cəhd: üstəlik `Bundle.main` azərbaycan paketinə yönləndirildi.
//       Bu dəfə sabit mətnlər azərbaycanca oldu, amma SDK və bizim menyu
//       `Locale`-a baxdığı üçün ingiliscə qaldı — qarışıq tərsinə döndü.
//
//  Səbəb: `Locale.preferredLanguages` prosesin əvvəlində təyin olunur və
//  sonradan dəyişdirilə bilmir. Yəni tətbiqin bir hissəsi həmişə cihazın
//  dilində qalır. Yeganə etibarlı həll — heç nəyi məcbur etməmək.
//
//  Nəticədə: cihaz azərbaycancadırsa tətbiq azərbaycanca, rusdursa rusca
//  açılır. Hər halda vahid dildə olur, qarışıq mümkün deyil.
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
}
