# Apple-a cavab — Guideline 4 (mixed languages)

Build 10 TestFlight-a düşəndən sonra:

1. Versiya səhifəsində build-i **10**-a dəyiş
2. Resolution Center-ə aşağıdakı mətni yaz
3. **Отправить на проверку**

---

## Cavab mətni

```
Hello,

Thank you for the detailed feedback. We reproduced the issue and fixed it.

CAUSE
The app previously forced the interface language to Azerbaijani on first launch,
because it is built for the Azerbaijani market. On a device set to another
language this produced a mixed interface: static strings came from the device
language, while configuration-driven strings (tab titles, menu items) came from
the forced language. This is exactly what you saw on the English device.

FIX
We removed the forced language entirely. The app now follows the device language
through the standard iOS localization mechanism, with no override anywhere in
the code. The interface is therefore always shown in a single language:

- Device in Azerbaijani -> the whole app is in Azerbaijani
- Device in Russian -> the whole app is in Russian
- Device in English -> the whole app is in English
- Device in Turkish -> the whole app is in Turkish
- Any other language -> the app falls back to English

Users can change the app language at any time in Settings > Bilet.az >
Preferred Language.

VERIFICATION
We verified the fix on a clean install on an English device: every element,
including the tab bar titles, the service menu and the contact screen, is now in
English only. No mixed content remains.

This is included in build 10, which is now available for review.

Kind regards,
Granit AS Travel
info@bilet.az
```
