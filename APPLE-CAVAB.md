# Apple-a cavab — Guideline 2.1 (Information Needed)

Bu, rədd deyil: Apple yeni tətbiqlərdən əlavə məlumat istəyir. Kodda dəyişiklik lazım deyil.

## Nə etməli — iki addım

**1.** iPhone-da ekran videosu çək (aşağıda təlimat var)
**2.** App Store Connect → **Resolution Center** → cavab yaz, videonu əlavə et

Aşağıdakı mətni olduğu kimi köçür. Eyni mətni **App Review Information → Notes**
sahəsinə də yapışdır — sonrakı versiyalarda bu sual təkrarlanmasın deyə.

---

## Ekran videosu necə çəkilir

iPhone-da: **Ayarlar → İdarəetmə Mərkəzi → Ekran Yazısı**ni əlavə et.
Sonra ekranın yuxarı sağ küncündən aşağı çək → yazı düyməsinə bas.

**Videoda mütləq göstər (60-90 saniyə):**

1. Tətbiqi ana ekrandan aç — açılış animasiyası görünsün
2. **Bildiriş icazəsi pəncərəsi** çıxanda göstər ("Bilet.az Would Like to Send
   You Notifications"). Tətbiqin istədiyi yeganə icazə budur — Apple məhz
   belə pəncərələri görmək istəyir. Çıxmasa (əvvəl cavab verilibsə), tətbiqi
   silib yenidən yüklə.
3. Gediş şəhəri seç → Bakı
4. Gəliş şəhəri seç → İstanbul
5. Tarix seç
6. **Axtar** düyməsinə bas
7. Nəticələr siyahısını aşağı sürüşdür
8. **Filtrlər**i aç, bir-iki filtri işlət
9. **Qiymət qrafiki**ni aç
10. Bir bileti aç, detallarını göstər
11. **Al** düyməsinə bas — tərəfdaş saytının açıldığını göstər (bu vacibdir:
    Apple ödənişin harada baş verdiyini görmək istəyir)
12. Alt tablardan **Əlaqə** və **Məlumat** bölmələrini göstər

Videonu Fayllara yaz, sonra kompüterdən Resolution Center-ə əlavə et.

---

## Cavab mətni (ingiliscə, olduğu kimi köçür)

```
Hello,

Thank you for reviewing Bilet.az. Please find the requested information below.

1. SCREEN RECORDING

A screen recording captured on a physical iPhone running the latest iOS is
attached. It begins with launching the app and shows the complete user flow:
the push notification permission prompt, selecting origin and destination
airports, choosing dates, running a search, browsing results, applying filters,
viewing the price chart, opening ticket details, and proceeding to the partner
website to complete a booking. It also shows the Contact and Information tabs.

The app has no account registration, login, or account deletion flows, no
in-app purchases or subscriptions, and no user-generated content.

The only permission the app requests is push notifications, which is shown in
the recording. The app does not request location, contacts, camera, microphone,
photo library access, or App Tracking Transparency. The departure city shown by
default is determined server-side from the IP address, not from device location.

2. DEVICES AND OPERATING SYSTEMS TESTED

- iPhone 17 Pro (physical device), iOS 26
- iOS Simulator: iPhone 16 Pro Max, iPhone 16 Pro, iOS 26

3. APP FUNCTION AND TARGET AUDIENCE

Bilet.az is a flight and hotel search application for the Azerbaijani market,
operated by Granit AS Travel, a travel agency based in Baku, Azerbaijan.

Problem it solves: travellers in Azerbaijan have to compare prices across many
airline and agency websites, most of which are not available in the Azerbaijani
language and display prices in foreign currencies. Bilet.az aggregates offers
from hundreds of airlines and booking sites in a single list, shows prices in
Azerbaijani manat (AZN), and provides a fully Azerbaijani interface.

Target audience: travellers departing from Azerbaijan, primarily residents of
Baku and other Azerbaijani cities. The interface is also available in Russian,
Turkish and English.

Core features: flight search with flexible dates, a price chart showing the
cheapest days, filters (baggage, number of layovers, departure time, airline,
airport), favourites, and hotel search.

4. SETUP AND ACCESS INSTRUCTIONS

No account, login, or credentials are required. All features are available
immediately after installation. No demo account or sample files are needed.

To use the main feature:
  1. Open the app. The flight search screen appears first.
  2. Tap the departure field and select a city (for example, Baku).
  3. Tap the arrival field and select a city (for example, Istanbul).
  4. Tap the date field and select travel dates.
  5. Tap "Axtar" (Search).
  6. Results appear as a list. Filters and the price chart are available at the
     top of the results screen.
  7. Selecting a ticket opens the partner website where the booking is
     completed.

The app is fully usable without granting any permission. Declining the push
notification prompt does not limit any feature.

5. EXTERNAL SERVICES USED

- Travelpayouts White Label SDK — provides all flight and hotel search data.
  Granit AS Travel is an official Travelpayouts partner (partner marker 266031).
  Flight schedules, prices, airline names and logos are supplied through this
  partnership.
- Firebase (Google) — Crashlytics for crash reporting, Cloud Messaging for
  push notifications, Analytics for anonymous usage statistics.

The app does not process payments and does not collect payment data. Ticket
purchases are completed on the partner websites (airlines and online travel
agencies), which are opened from the app.

There are no authentication services, no payment processors, and no AI services
in the app.

6. REGIONAL DIFFERENCES

The app functions identically in all regions. There are no region-locked
features or content.

The default interface language is Azerbaijani and the default currency is
Azerbaijani manat (AZN), because the app is built for the Azerbaijani market.
Users can change the language through the iOS Settings app (Preferred Language)
and the currency inside the app under Information > Regional settings. Search
results depend only on the route and dates entered by the user, not on the
user's region.

7. AUTHORIZATION FOR THIRD-PARTY MATERIAL

All flight data, airline names and airline logos displayed in the app are
provided by Travelpayouts through their official White Label partner program.
Granit AS Travel is a registered partner of this program (marker 266031), which
grants the right to display this content under our own brand. The application
is built on the official Travelpayouts White Label iOS template.

Granit AS Travel is a travel agency registered and operating in Baku,
Azerbaijan. We can provide the partnership agreement or company registration
documents if required.

Please let us know if any further information is needed.

Kind regards,
Granit AS Travel
info@bilet.az
```

---

## Diqqət

- **Cihaz siyahısını dəyiş** — yuxarıda iPhone 17 Pro yazılıb. Başqa telefonda da
  sınamısansa, əlavə et; sınamamısansa, olduğu kimi qalsın.
- Videoda **bilet alışına keçidi mütləq göstər.** Apple ödənişin tətbiqin içində
  yox, tərəfdaş saytında baş verdiyini görmək istəyir — bu, ən çox soruşulan sualdır.
- Mətni **Notes** sahəsinə də yaz. Onda növbəti versiyalarda bu sorğu təkrarlanmır.
