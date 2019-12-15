dotnet restore AutoDialer.Console.csproj
dotnet publish AutoDialer.Console.csproj -c Release --runtime linux-x64
ssh root@$1 'systemctl stop Autodial.service'

ssh root@$1 'mkdir -p /home/asterisk/services/Autodial'
ssh root@$1 'mkdir -p /home/asterisk/services'

scp bin/Release/netcoreapp2.2/linux-x64/publish/Auto* root@$1:/home/asterisk/services/Autodial/ 
ssh root@$1 'chown asterisk:asterisk /home/asterisk/services/Autodial/*'
ssh root@$1 'chown asterisk:asterisk /home/asterisk/services/Autodial'
ssh root@$1 'chown asterisk:asterisk /home/asterisk/services'

ssh root@$1 'cp /home/asterisk/services/Autodial/Autodial.service /etc/systemd/system/'
ssh root@$1 'service systemd-resolved restart'

ssh root@$1 'systemctl enable Autodial.service'
ssh root@$1 'systemctl start Autodial.service'

ssh root@$1 'systemctl status Autodial.service'