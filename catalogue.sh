echo ">>>>>>>>>>> Catalogue Service <<<<<<<<<"
cp catalogue.service /etc/systemd/system/catalogue.service

echo ">>>>>>>>>>> ctreate Mongo Repo  <<<<<<<<<"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo ">>>>>>>>>>> Download nodejs Repos <<<<<<<<<"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo ">>>>>>>>>>> Install Nodejs <<<<<<<<<"
yum install nodejs -y

echo ">>>>>>>>>>> Create Application User <<<<<<<<<"
useradd roboshop

echo ">>>>>>>>>>> Removing exisiting data <<<<<<<<<"
rm -rf /app

echo ">>>>>>>>>>> Creating the Application Directory  <<<<<<<<<"
mkdir /app

echo ">>>>>>>>>>> Download Application Content <<<<<<<<<"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo ">>>>>>>>>>> Extract Application Content <<<<<<<<<"
cd /app
unzip /tmp/catalogue.zip
cd /app

echo ">>>>>>>>>>> Download Nodejs Dependencies  <<<<<<<<<"
npm install

echo “>>>>>>>>>>> Install MongoDB Client <<<<<<<<<”
yum install mongodb-org-shell -y

echo “>>>>>>>>>>> Load Catalogue Schema <<<<<<<<<”
mongo --host mongodb.devops7874.online </app/schema/catalogue.js

echo “>>>>>>>>>>> Start Catalogue Service <<<<<<<<<”
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue








