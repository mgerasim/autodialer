ng build --prod
cp dist/AutoDialer/* ../../public/
cd ../../
mv public/index.html public/index2.html
git add .
git commit -m deploy
git pull origin master
git push origin master
