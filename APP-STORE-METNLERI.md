# App Store mətnləri — Bilet.az

App Store Connect-də doldurulacaq sahələr. Google Play-dəkindən fərqli sahələr var,
ona görə hazır mətnləri birbaşa köçürmək olmur.

---

## ⚠️ Əvvəlcə yoxlanmalı: azərbaycan dili

Apple mağaza səhifəsi üçün məhdud dil siyahısı dəstəkləyir və **azərbaycan dili
orada olmaya bilər** (Google Play-də var idi). App Store Connect açılanda
**"App Information → Localizations"** siyahısına bax.

- **Azərbaycan dili varsa** — əsas dil onu seç, aşağıdakı mətnləri tərcümə edərik.
- **Yoxdursa** — əsas dil **English** olsun, üstünə **Русский** və **Türkçe** əlavə edərik.

Diqqət: bu, yalnız **mağaza səhifəsinin** dilidir. **Tətbiqin özü** hər halda
azərbaycanca açılır — ona təsiri yoxdur.

---

## Tətbiqin adı (30 simvol)

```
Bilet.az - Ucuz Aviabiletlər
```
*(28 simvol)*

Telefonda isə qısa ad görünür — bu, `configuration.json`-dan gəlir: **Bilet.az**

---

## Subtitle / Alt başlıq (30 simvol)

Google Play-də bu sahə yoxdur, Apple-a məxsusdur. Adın altında kiçik şriftlə görünür.

| Dil | Mətn | Simvol |
|---|---|---|
| EN | `Cheap flights from Baku` | 23 |
| RU | `Дешёвые авиабилеты` | 18 |
| TR | `Ucuz uçak bileti` | 16 |

---

## Keywords / Açar sözlər (100 simvol, vergüllə)

Yalnız Apple-da var. Boşluq işlətmə — vergüldən sonra boşluq simvol yeyir.
Adda və subtitle-də olan sözləri təkrarlama, Apple onları onsuz da indeksləyir.

```
aviabilet,ucuz,uçuş,bakı,azərbaycan,otel,səyahət,bilet,turizm,aviabiletlər
```
*(74 simvol)*

---

## Promotional Text (170 simvol)

Yoxlamadan keçmədən dəyişdirilə bilən yeganə mətndir — kampaniyalar üçün əlverişlidir.

```
Bakıdan dünyanın istənilən nöqtəsinə ən sərfəli aviabiletləri tapın. Qiymətlər manatla, interfeys azərbaycan dilində.
```

---

## Description / Təsvir (4000 simvol)

```
Bilet.az — Azərbaycanın aviabilet və otel axtarış tətbiqi.

Bakıdan dünyanın istənilən nöqtəsinə ən sərfəli reyslərı tapın. Qiymətlər manatla (AZN) göstərilir, interfeys azərbaycan, rus, türk və ingilis dillərindədir.

AVİABİLET AXTARIŞI
• Yüzlərlə aviaşirkət və bron saytı arasında qiymət müqayisəsi
• Birbaşa reyslər və dayanacaqlı variantlar
• Qiymət qrafiki — hansı gün daha ucuzdur, görün
• Filtrlər: baqaj, dayanacaq sayı, uçuş vaxtı, aviaşirkət, hava limanı
• Bəyəndiyiniz marşrutları sevimlilərə əlavə edin

XİDMƏTLƏR
Tətbiqin içindən birbaşa müraciət edə bilərsiniz:
• Viza dəstəyi
• Otel bronu
• Turlar
• Transfer
• Səyahət sığortası
• eSİM — xaricdə internet

DƏSTƏK
Suallarınız üçün WhatsApp və ya telefonla əlaqə saxlayın. Granit AS Travel komandası kömək etməyə hazırdır.

Qeyd: biletin alınması tərəfdaş saytlarında tamamlanır. Tətbiq ödəniş məlumatlarınızı toplamır.

Bilet.az — Granit AS Travel şirkətinin məhsuludur.
Sayt: https://bilet.az
```

---

## Linklər

| Sahə | Dəyər |
|---|---|
| Support URL | `https://bilet.az/elaqe/` |
| Marketing URL | `https://bilet.az` |
| Privacy Policy URL | `https://bilet.az/mexfilik-siyaseti/` |

---

## Kateqoriya və yaş

| Sahə | Dəyər |
|---|---|
| Primary Category | **Travel** |
| Secondary Category | Navigation *(istəyə bağlı)* |
| Age Rating | **4+** |

Yaş anketində hamısına "None" cavab ver — tətbiqdə zorakılıq, qumar, əlaqə vasitəsi yoxdur.

---

## Ekran şəkilləri

Google Play-dəkiləri işlətmək olmur — Apple fərqli ölçü tələb edir və şəkillər
**iPhone çərçivəsində** olmalıdır. Mac götürüləndə simulyatordan çəkiləcək.

| Ölçü | Tələb |
|---|---|
| 6.9" (iPhone 16 Pro Max) | **Məcburi** — 1320×2868 |
| 6.5" (iPhone 11 Pro Max) | Məcburi ola bilər — 1242×2688 |
| iPad | Yalnız iPad dəstəyi elan edilsə |

Ən azı 3, ən çox 10 şəkil. Bizim plan: axtarış ekranı, nəticələr, qiymət qrafiki,
filtrlər, bilet detalları — Android-dəki ilə eyni.

---

## App Review üçün qeyd (App Review Information)

Apple yoxlayıcısına yazılacaq qeyd. Bu, çox vaxt rədd cavablarının qarşısını alır:

```
Bilet.az is a flight and hotel search app for the Azerbaijani market.
It uses the Travelpayouts white-label SDK. Bookings are completed on
partner websites; the app itself does not process payments or collect
payment data.

The interface defaults to Azerbaijani. Language can be changed in the
app settings.

No login is required to use the app, so no demo account is needed.
```
