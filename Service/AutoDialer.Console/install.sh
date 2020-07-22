sudo cp /home/dotnet/apps/Autodial/Autodial.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable Autodial.service
sudo systemctl start Autodial.service