#!/bin/bash
echo "Writing to /etc/apt/sources.list..."
sudo tee /etc/apt/sources.list > /dev/null <<EOF
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.bfsu.edu.cn/debian/ testing main contrib non-free non-free-firmware
# deb-src https://mirrors.bfsu.edu.cn/debian/ testing main contrib non-free non-free-firmware

deb https://mirrors.bfsu.edu.cn/debian/ testing-updates main contrib non-free non-free-firmware
# deb-src https://mirrors.bfsu.edu.cn/debian/ testing-updates main contrib non-free non-free-firmware

deb https://mirrors.bfsu.edu.cn/debian/ testing-backports main contrib non-free non-free-firmware
# deb-src https://mirrors.bfsu.edu.cn/debian/ testing-backports main contrib non-free non-free-firmware

# 以下安全更新软件源包含了官方源与镜像站配置，如有需要可自行修改注释切换
deb https://mirrors.bfsu.edu.cn/debian-security testing-security main contrib non-free non-free-firmware
# deb-src https://mirrors.bfsu.edu.cn/debian-security testing-security main contrib non-free non-free-firmware
EOF
echo "updating apt"
sudo apt update

read -p "Do you want to perform a system upgrade? (y/n): " perform_upgrade
if [[ $perform_upgrade == [Yy]* ]]; then
    echo "Running sudo apt full-upgrade..."
    sudo apt full-upgrade
else
    echo "Skipping system upgrade."
fi
sudo apt install git
git clone https://github.com/wiwyil2tr/optimizeddebian.git
cd optimizeddebian/postinstall
chmod +x ./*.sh
sudo ln -sf /usr/share/images/desktop-base/Aurora.jpg /usr/share/backgrounds/Photo\ of\ Valley.jpg

echo "Choose your desktop style:"
select style in "gnome2 -- traditional style, top + bottom panels" "dock.sh -- top panel + dock style" "windows.sh -- bottom panel (Windows-like)" "Skip"; do
    case $style in
        "gnome2 -- traditional style, top + bottom panels")
            echo "Executing gnome2.sh..."
            ./gnome2.sh
            break
            ;;
        "dock -- top panel + dock style")
            echo "Executing dock.sh..."
            ./dock.sh
            break
            ;;
        "windows -- bottom panel (Windows-like)")
            echo "Executing windows.sh..."
            ./windows.sh
            break
            ;;
        "Skip")
            echo "Skipping desktop style setup."
            break
            ;;
        *)
            echo "Invalid option. Please choose a valid option."
            ;;
    esac
done
echo "cleaning"
rm -r postinstall
echo "Script execution completed. Welcome to SULET Optimized Debian GNU/Linux"

