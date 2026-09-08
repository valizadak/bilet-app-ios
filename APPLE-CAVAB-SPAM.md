# Apple 4.3(a) — Spam rədd cavabı

Bu, şablon əsaslı tətbiqlərin ən çox rastlaşdığı problemdir. Apple White Label
məhsullarını «təkrarlanan şablon» kimi görür.

İki cəbhədə eyni anda işləmək lazımdır:
1. Apple-a cavab — tətbiqin öz biznesimizə aid olduğunu və unikal hissələrini göstərmək
2. Travelpayouts-a müraciət — onların digər partnyorları bu problemi necə həll edib

---

## 1. Apple-a cavab (Resolution Center)

```
Hello,

Thank you for the review. We would like to clarify that Bilet.az is not a
repackaged template app. It is the mobile application of an operating travel
business in Azerbaijan.

ABOUT THE COMPANY

Granit AS Travel is a licensed travel agency based in Baku, Azerbaijan. We sell
flight tickets, hotel bookings, tours, visa support and travel insurance. The
app is one of our sales channels, alongside our website bilet.az and our office
in Baku. It is not a product we distribute to other parties.

TECHNOLOGY WE LICENSE

Flight search data is provided by Travelpayouts, our official data partner
(partner ID 266031). We license their SDK for the flight search functionality in
the same way that many travel businesses license mapping, payment or booking
SDKs. The SDK provides data; the application, brand, content and business behind
it are ours.

WHAT IS UNIQUE TO OUR APP

1. Azerbaijani localization. The SDK ships with no Azerbaijani language at all.
   We produced the complete Azerbaijani translation ourselves — 249 interface
   strings plus plural forms — including aviation terminology adapted for the
   local market. To our knowledge this is the only flight search app fully
   available in Azerbaijani.

2. Custom service navigation. We added our own branded header with a scrolling
   service menu (Flights, Visa, Hotel, Tour, Transfer, Insurance, eSIM). These
   entries connect users to services our agency actually provides, including our
   visa service at viza.az and direct WhatsApp contact with our agents. This
   interface does not exist in the SDK.

3. Custom branding and launch experience. Our own app icon, brand colours and a
   custom launch animation built with our logo.

4. Direct customer support. The Contact tab connects users to our agency in Baku
   by phone, WhatsApp and email — a real support team, not an automated form.

MARKET

The app is built for the Azerbaijani market: prices in Azerbaijani manat,
Azerbaijani interface, local phone support, and routes departing from Baku.

We would be glad to provide our company registration documents, our partnership
agreement with Travelpayouts, or any other verification that would help confirm
that this app belongs to a real, operating business.

Kind regards,
Granit AS Travel
info@bilet.az
```

---

## 2. Travelpayouts-a müraciət (rusca)

Onlar bu problemlə mütləq qarşılaşıblar — White Label App məhsulunu satırlarsa,
digər partnyorları da App Store-a çıxarıb.

```
Здравствуйте,

ID партнёра: 266031

Наше мобильное приложение, созданное на вашем White Label App SDK, было
отклонено в App Store по причине Guideline 4.3(a) - Design - Spam.

Apple считает, что приложение имеет схожий бинарный код и концепцию с другими
приложениями, уже размещёнными в App Store другими разработчиками. Это, судя по
всему, связано с тем, что White Label App использует общий шаблон для всех
партнёров.

Вопросы:

1. Сталкивались ли ваши партнёры с отклонением по 4.3(a) при публикации White
   Label App в App Store?

2. Есть ли у вас рекомендованный текст ответа или практика, которая помогает
   пройти проверку?

3. Есть ли возможность изменить что-то в конфигурации или коде, чтобы
   приложение не воспринималось как копия шаблона?

4. Возможно ли, чтобы приложение публиковалось от вашего имени как поставщика
   контента, если это требуется правилами Apple?

Приложение уже успешно опубликовано в Google Play, проблема только с App Store.

Спасибо,
Kanan Valizada
Granit AS Travel
```

---

## Dürüst qiymətləndirmə

4.3(a) rədd cavabları çətin keçilir. Apple-ın mövqeyi belədir: şablon əsaslı
tətbiqlər ya şablonu verən şirkət tərəfindən yerləşdirilməli, ya da ciddi
şəkildə fərqlənməlidir.

Bizim əlimizdə güclü arqumentlər var — real şirkət, öz brendi, azərbaycan dili,
əlavə etdiyimiz interfeys. Amma zəmanət yoxdur.

Alınmasa, variantlar:
- Tətbiqə şablonda olmayan real funksiya əlavə etmək (məsələn, öz bron tariximiz,
  sevimli marşrutlar üzrə qiymət bildirişi, agentliyə birbaşa sifariş formu)
- Travelpayouts-un öz adından yerləşdirməsi (əgər belə imkan varsa)

Android tərəfdə isə tətbiq onsuz da yayımdadır — bu problem yalnız App Store-a aiddir.
