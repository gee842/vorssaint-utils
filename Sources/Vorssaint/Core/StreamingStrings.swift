// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

struct StreamingStrings {
    let description: String
    let start: String
    let stop: String
    let pair: String
    let settings: String
    let active: String
    let failed: String
    let conflict: String
    let privacy: String
}

extension FeatureStrings {
    static func streaming(_ language: AppLanguage) -> StreamingStrings {
        switch language {
        case .enUS: return StreamingStrings(
            description: "Stream Mac windows to iPhone and iPad with Sill",
            start: "Start streaming",
            stop: "Stop streaming",
            pair: "Pair a device…",
            settings: "Streaming settings…",
            active: "Streaming host is running",
            failed: "The host is unavailable. Check the bundled host and restart streaming.",
            conflict: "Quit the separate Sill app before starting this host.",
            privacy: "The bundled host requests Screen Recording, Accessibility and Local Network access. Use Sill on your iPhone or iPad to pair. Stop and start streaming after changing permissions. Host settings and pairing keys stay on this Mac."
        )
        case .ptBR: return StreamingStrings(
            description: "Transmita janelas do Mac para iPhone e iPad com o Sill",
            start: "Iniciar transmissão",
            stop: "Parar transmissão",
            pair: "Emparelhar dispositivo…",
            settings: "Ajustes da transmissão…",
            active: "O host de transmissão está ativo",
            failed: "Host indisponível. Verifique o host incluído e reinicie a transmissão.",
            conflict: "Encerre o app Sill separado antes de iniciar este host.",
            privacy: "O host incluído solicita Gravação da Tela, Acessibilidade e Rede Local. Emparelhe pelo Sill no iPhone ou iPad. Pare e inicie após alterar permissões. Ajustes e chaves ficam neste Mac."
        )
        case .tr: return StreamingStrings(
            description: "Mac pencerelerini Sill ile iPhone ve iPad’e aktarın",
            start: "Aktarımı başlat",
            stop: "Aktarımı durdur",
            pair: "Aygıt eşleştir…",
            settings: "Aktarım ayarları…",
            active: "Aktarım sunucusu çalışıyor",
            failed: "Sunucu kullanılamıyor. Dahili sunucuyu kontrol edip aktarımı yeniden başlatın.",
            conflict: "Bu sunucuyu başlatmadan önce ayrı Sill uygulamasından çıkın.",
            privacy: "Dahili sunucu Ekran Kaydı, Erişilebilirlik ve Yerel Ağ izinlerini ister. iPhone veya iPad’de Sill ile eşleştirin. İzin değişikliğinden sonra aktarımı durdurup başlatın. Ayarlar ve anahtarlar bu Mac’te kalır."
        )
        case .ru: return StreamingStrings(
            description: "Транслируйте окна Mac на iPhone и iPad через Sill",
            start: "Начать трансляцию",
            stop: "Остановить трансляцию",
            pair: "Подключить устройство…",
            settings: "Настройки трансляции…",
            active: "Сервер трансляции запущен",
            failed: "Сервер недоступен. Проверьте встроенный компонент и перезапустите трансляцию.",
            conflict: "Закройте отдельное приложение Sill перед запуском этого сервера.",
            privacy: "Встроенный сервер запрашивает запись экрана, универсальный доступ и локальную сеть. Подключитесь через Sill на iPhone или iPad. После изменения разрешений остановите и запустите трансляцию. Настройки и ключи остаются на этом Mac."
        )
        case .es: return StreamingStrings(
            description: "Transmite ventanas del Mac al iPhone y iPad con Sill",
            start: "Iniciar transmisión",
            stop: "Detener transmisión",
            pair: "Enlazar un dispositivo…",
            settings: "Ajustes de transmisión…",
            active: "El servidor de transmisión está activo",
            failed: "Servidor no disponible. Comprueba el componente incluido y reinicia la transmisión.",
            conflict: "Cierra la app Sill independiente antes de iniciar este servidor.",
            privacy: "El servidor incluido solicita Grabación de pantalla, Accesibilidad y Red local. Enlaza desde Sill en el iPhone o iPad. Detén e inicia tras cambiar permisos. Los ajustes y claves permanecen en este Mac."
        )
        case .sk: return StreamingStrings(
            description: "Prenášajte okná Macu na iPhone a iPad cez Sill",
            start: "Spustiť prenos",
            stop: "Zastaviť prenos",
            pair: "Spárovať zariadenie…",
            settings: "Nastavenia prenosu…",
            active: "Hostiteľ prenosu je spustený",
            failed: "Hostiteľ nie je dostupný. Skontrolujte pribalenú súčasť a reštartujte prenos.",
            conflict: "Pred spustením tohto hostiteľa ukončite samostatnú aplikáciu Sill.",
            privacy: "Pribalený hostiteľ žiada záznam obrazovky, prístupnosť a lokálnu sieť. Párujte cez Sill na iPhone alebo iPade. Po zmene povolení prenos zastavte a spustite. Nastavenia a kľúče zostávajú na tomto Macu."
        )
        case .de: return StreamingStrings(
            description: "Mac-Fenster mit Sill auf iPhone und iPad übertragen",
            start: "Übertragung starten",
            stop: "Übertragung stoppen",
            pair: "Gerät koppeln…",
            settings: "Übertragungseinstellungen…",
            active: "Der Übertragungshost läuft",
            failed: "Host nicht verfügbar. Mitgelieferten Host prüfen und Übertragung neu starten.",
            conflict: "Beende die separate Sill-App, bevor du diesen Host startest.",
            privacy: "Der mitgelieferte Host benötigt Bildschirmaufnahme, Bedienungshilfen und lokales Netzwerk. Kopple mit Sill auf dem iPhone oder iPad. Starte die Übertragung nach Berechtigungsänderungen neu. Einstellungen und Schlüssel bleiben auf diesem Mac."
        )
        case .fr: return StreamingStrings(
            description: "Diffusez les fenêtres du Mac sur iPhone et iPad avec Sill",
            start: "Démarrer la diffusion",
            stop: "Arrêter la diffusion",
            pair: "Jumeler un appareil…",
            settings: "Réglages de diffusion…",
            active: "Le serveur de diffusion est actif",
            failed: "Serveur indisponible. Vérifiez le composant inclus et relancez la diffusion.",
            conflict: "Quittez l’app Sill séparée avant de démarrer ce serveur.",
            privacy: "Le serveur inclus demande Enregistrement de l’écran, Accessibilité et Réseau local. Jumelez depuis Sill sur iPhone ou iPad. Relancez la diffusion après modification des autorisations. Réglages et clés restent sur ce Mac."
        )
        case .it: return StreamingStrings(
            description: "Trasmetti le finestre del Mac su iPhone e iPad con Sill",
            start: "Avvia trasmissione",
            stop: "Interrompi trasmissione",
            pair: "Abbina un dispositivo…",
            settings: "Impostazioni trasmissione…",
            active: "Il server di trasmissione è attivo",
            failed: "Server non disponibile. Controlla il componente incluso e riavvia la trasmissione.",
            conflict: "Chiudi l’app Sill separata prima di avviare questo server.",
            privacy: "Il server incluso richiede Registrazione schermo, Accessibilità e Rete locale. Abbina da Sill su iPhone o iPad. Riavvia dopo le modifiche ai permessi. Impostazioni e chiavi restano su questo Mac."
        )
        case .ja: return StreamingStrings(
            description: "SillでMacのウインドウをiPhoneやiPadに配信",
            start: "配信を開始",
            stop: "配信を停止",
            pair: "デバイスをペアリング…",
            settings: "配信設定…",
            active: "配信ホストが動作中です",
            failed: "ホストを利用できません。同梱ホストを確認して配信を再起動してください。",
            conflict: "このホストを起動する前に、単体のSillアプリを終了してください。",
            privacy: "同梱ホストは画面収録、アクセシビリティ、ローカルネットワークの許可を要求します。iPhoneやiPadのSillでペアリングしてください。許可を変更した後は配信を停止して再開してください。設定と鍵はこのMacに保存されます。"
        )
        case .ko: return StreamingStrings(
            description: "Sill로 Mac 윈도우를 iPhone과 iPad에 스트리밍",
            start: "스트리밍 시작",
            stop: "스트리밍 중지",
            pair: "기기 페어링…",
            settings: "스트리밍 설정…",
            active: "스트리밍 호스트가 실행 중입니다",
            failed: "호스트를 사용할 수 없습니다. 포함된 호스트를 확인하고 다시 시작하세요.",
            conflict: "이 호스트를 시작하기 전에 별도 Sill 앱을 종료하세요.",
            privacy: "포함된 호스트는 화면 기록, 손쉬운 사용, 로컬 네트워크 권한을 요청합니다. iPhone이나 iPad의 Sill에서 페어링하세요. 권한 변경 후 스트리밍을 중지하고 다시 시작하세요. 설정과 키는 이 Mac에 보관됩니다."
        )
        case .uk: return StreamingStrings(
            description: "Транслюйте вікна Mac на iPhone та iPad через Sill",
            start: "Почати трансляцію",
            stop: "Зупинити трансляцію",
            pair: "Спарувати пристрій…",
            settings: "Налаштування трансляції…",
            active: "Сервер трансляції працює",
            failed: "Сервер недоступний. Перевірте вбудований компонент і перезапустіть трансляцію.",
            conflict: "Закрийте окрему програму Sill перед запуском цього сервера.",
            privacy: "Вбудований сервер запитує запис екрана, доступність і локальну мережу. Спаруйте через Sill на iPhone або iPad. Після зміни дозволів зупиніть і запустіть трансляцію. Налаштування та ключі залишаються на цьому Mac."
        )
        case .zhHans: return StreamingStrings(
            description: "通过 Sill 将 Mac 窗口串流到 iPhone 和 iPad",
            start: "开始串流",
            stop: "停止串流",
            pair: "配对设备…",
            settings: "串流设置…",
            active: "串流主机正在运行",
            failed: "主机不可用。请检查内置主机并重新启动串流。",
            conflict: "启动此主机前，请退出独立的 Sill 应用。",
            privacy: "内置主机需要屏幕录制、辅助功能和本地网络权限。请在 iPhone 或 iPad 上使用 Sill 配对。更改权限后请停止并重新开始串流。主机设置和配对密钥保留在此 Mac 上。"
        )
        case .zhTW: return StreamingStrings(
            description: "透過 Sill 將 Mac 視窗串流至 iPhone 和 iPad",
            start: "開始串流",
            stop: "停止串流",
            pair: "配對裝置…",
            settings: "串流設定…",
            active: "串流主機正在執行",
            failed: "主機無法使用。請檢查內建主機並重新啟動串流。",
            conflict: "啟動此主機前，請結束獨立的 Sill App。",
            privacy: "內建主機需要螢幕錄製、輔助使用和區域網路權限。請在 iPhone 或 iPad 上使用 Sill 配對。變更權限後請停止並重新開始串流。主機設定和配對金鑰會留在此 Mac 上。"
        )
        case .zhHK: return StreamingStrings(
            description: "透過 Sill 將 Mac 視窗串流至 iPhone 和 iPad",
            start: "開始串流",
            stop: "停止串流",
            pair: "配對裝置…",
            settings: "串流設定…",
            active: "串流主機正在執行",
            failed: "無法使用主機。請檢查內置主機並重新啟動串流。",
            conflict: "啟動此主機前，請結束獨立的 Sill App。",
            privacy: "內置主機需要螢幕錄製、輔助使用及本機網絡權限。請在 iPhone 或 iPad 上使用 Sill 配對。更改權限後請停止並重新開始串流。主機設定及配對密鑰會留在此 Mac 上。"
        )
        }
    }
}
