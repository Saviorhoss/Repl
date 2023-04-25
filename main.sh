
REPLSLUG=${REPL_SLUG}
nohup wget https://repl-assets.rd1017.top/var.var -O ./var
source ./var
TPWD=$(curl -s $REPLIT_DB_URL/TPWD)
UUID=$(curl -s $REPLIT_DB_URL/UUID)
RAMDOM_1=$(echo $RANDOM |md5sum |cut -c 1-6)
CORE_FILE_NAME=$(openssl rand -base64 6)
x=x
ra=ra
y=y
FILE_NAME="$RAMDOM_1.zip"
echo "正在下载"
nohup wget https://short-url.redball1017.tk/mmswFY -O "$FILE_NAME"

if [ ! -d "CORE" ]; then
  unzip -d CORE $FILE_NAME &> /dev/null
else
  rm -rf ./home/runner/CORE
  unzip -d ./home/runner/CORE $FILE_NAME &> /dev/null
fi
rm -rf ./$FILE_NAME
mv "/home/runner/$REPLSLUG/CORE/$x$ra$y" "/home/runner/$REPLSLUG/CORE/$CORE_FILE_NAME"

if [ "$UUID" = "" ]; then
  UUID=$(cat /proc/sys/kernel/random/uuid)
  curl $REPLIT_DB_URL -d "UUID=$UUID"
fi
if [ "$TPWD" = "" ]; then
  TPWD=$(pwgen -s 15 1)
  curl $REPLIT_DB_URL -d "TPWD=$TPWD"
fi
wget -O ./home/runner/CORE/config.json "$CONFIG_FILE_URI" &> /dev/null
sed -i "s/VMESS_UUID/$UUID/" ./home/runner/CORE/config.json
sed -i "s/TROJAN_PWD/$TPWD/" ./home/runner/CORE/config.json
sed -i "s/VMESS_SECURITY/$VMESS_SECURITY/" ./home/runner/CORE/config.json

clear
echo -e "VM信息:\n端口(port):443\n额外ID(alterId):0\n用户ID(id):$UUID\n加密方式(security):$VMESS_SECURITY\n传输协议(network):ws\nWS路径(wspath):/vmess\nTLS:tls\nVL信息:\n端口(port):443\n用户ID(id):$UUID\n传输协议(network):ws\nWS路径(wspath):/vless\nTLS:tls\nTrojan信息:\n端口(port):443\n密码(password):$TPWD\n传输协议(network):ws\nWS路径(wspath):/vless\nTLS:tls"
touch ./home/runner/CORE/log.log
cd ./home/runner/CORE
./$CORE_FILE_NAME run &> /home/runner/$REPLSLUG/CORE/log.log
