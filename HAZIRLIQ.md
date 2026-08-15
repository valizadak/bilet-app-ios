# Bilet.az iOS — hazırlıq vəziyyəti

Son yenilənmə: 14 avqust 2026

---

## Tamamlanıb (Mac olmadan edildi)

| İş | Vəziyyət |
|---|---|
| Şablon klonlandı | ✅ `travelpayouts/white-label-app-ios` |
| `configuration.json` dolduruldu | ✅ marker, API key, domen, rənglər, əlaqə mətnləri |
| Azərbaycan dili — 249 mətn | ✅ `Resources/Strings/*/az.lproj` |
| Cəm formaları — 11 ədəd | ✅ `BasePlurals` + `FlightsPlurals` |
| Tətbiq ikonu 1024×1024 | ✅ `Images.xcassets/ic_application.appiconset` |
| bilet.az loqosu (1x/2x/3x) | ✅ `Images.xcassets/bilet_logo.imageset` |
| Başlıq + sürüşən xidmət menyusu | ✅ kod yazılıb |
| **Kompilyasiya yoxlaması** | ✅ **GitHub Actions-da uğurla yığılır** |

Repozitoriya: https://github.com/valizadak/bilet-app-ios (gizli)
Hər `git push`-dan sonra yığma avtomatik işə düşür, ~16 dəqiqə çəkir.

---

## Yığma zamanı rast gəlinən tələlər

Sənədlərdə yazılmayıb, təkrar qarşıya çıxsa vaxt itirməmək üçün:

1. **`fileContainsInvalidSyntax`** — `configuration.json`-dakı mətnlərdə **həqiqi sətir keçidi** olmamalıdır.
   Konfiqurator onu `.strings` faylına köçürəndə faylı sındırır. Həlli: `\\n` yazmaq
   (JSON-da qaçış işarəsi ilə), onda fayla `\n` düşür və iOS onu abzas kimi oxuyur.
   Azərbaycan dili ilə əlaqəsi yoxdur — bu, diaqnostika ilə ayrıca təsdiqləndi.

2. **Xcode versiyası** — XcodeGen layihəni 77-ci formatda yaradır, Xcode 15 onu aça bilmir
   ("There are no schemes in workspace"). `macos-15` maşını və ən yeni Xcode seçilməlidir.

3. **SwiftLint sərt rejimdədir** — üslub pozuntusu yığmanı dayandırır:
   - `switch` gövdəsi `case` ilə eyni sətirdə ola bilməz
   - `@objc` funksiyadan ayrı, öz sətrində yazılmalıdır
   - `UIImage(named:)` qadağandır; şəkil literalı da qadağandır (iki qayda ziddir) —
     yeganə yol layihənin öz `R.image.<ad>()` mexanizmidir

Tərcümələrin 203-ü Android layihəsindən avtomatik köçürüldü (ingilis mətninə görə uyğunlaşdırma),
46-sı əl ilə yazıldı. Beləliklə iOS və Android eyni terminologiyanı işlədir.

---

## Mac tapılandan sonra ediləcək

1. **Qurulum:** `brew bundle` → `bundle install` → `pod install` → `xcodegen`
2. Layihəni Xcode-da açıb simulyatorda yığmaq
3. Azərbaycan dilinin doğru göründüyünü yoxlamaq
4. **Apple Developer hesabı** ($99/il) — yalnız App Store-a göndərmək üçün
5. `configuration.json` → `apple.team_id` doldurmaq (hesab açılandan sonra bilinir)
6. Sertifikat və provisioning profil
7. TestFlight → App Store

---

## Android-dən fərqlər

**Otel axtarışı yoxdur.** iOS şablonu yalnız `flights` və `other` (xarici link) ekranlarını dəstəkləyir —
kodda `ApplicationConfiguration.OptionalTab.swift` bunu təsdiqləyir. Android-dəki doğma otel axtarışının
iOS qarşılığı yoxdur.

**Başlıq yazılıb, amma yoxlanmayıb.** Loqo + sürüşən menyu (Aviabilet · Viza · Otel · Tur · Transfer ·
Sığorta · eSİM) Android-dəki linklərlə birlikdə kodlaşdırılıb:

- `Header/HomeService.swift` — xidmətlər və linklər
- `Header/BiletHeaderView.swift` — loqo + üfüqi sürüşən menyu
- `Header/FlightsContainerViewController.swift` — SDK ekranını əhatə edir, məzmunu 14% yuxarı sürüşdürür
- `Module/FlightsModule.swift` — tabda artıq konteyner göstərilir

Mac-da yoxlanmalı olan iki nöqtə:
1. **Sürüşmə payı (14%)** — Android-də bu dəyəri gözlə tənzimləmişdik, iOS-da fərqli çıxa bilər.
2. **Başlığın gizlədilməsi** — axtarışdan sonra gizlənməsi üçün SDK-nın `UINavigationController`
   işlətdiyi fərz edilib. İşlətmirsə, başlıq həmişə görünəcək və başqa üsul lazım olacaq.

**Valyuta/dil məcburiyyəti hələ yoxdur.** Android-də SDK-nın yaddaşına AZN və "az" yazırdıq
(`SdkDefaults.kt`, `LocaleHelper.kt`). iOS-da eyni davranış üçün SDK-nın hansı açarları işlətdiyini
Mac-da müşahidə etmək lazımdır.

---

## Kirayə Mac seçərkən

**SSH dəstəyi olan plan seç.** Yalnız ekran paylaşımı verən planlarda Claude uzaqdan işləyə bilmir.
SSH varsa, yığma və düzəlişlər uzaqdan aparıla bilər — TinTin botunun Hetzner serverində qurulduğu kimi.
