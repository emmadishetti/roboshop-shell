Echo “>>>>>>>>>>> Catalogue Service <<<<<<<<<”
cp catalogue.service /etc/systemd/system/catalogue.service

Echo “>>>>>>>>>>> ctreate Mongo Repo  <<<<<<<<<”
cp mongo.repo /etc/yum.repos.d/mongo.repo

Echo “>>>>>>>>>>> Download nodejs Repos <<<<<<<<<”
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

Echo “>>>>>>>>>>> Install Nodejs <<<<<<<<<”
yum install nodejs -y

Echo “>>>>>>>>>>> Create Application User <<<<<<<<<”
useradd roboshop

Echo “>>>>>>>>>>> Removing exisiting data <<<<<<<<<”
rm -rf /app

Echo “>>>>>>>>>>> Creating the Application Directory  <<<<<<<<<”
mkdir /app

Echo “>>>>>>>>>>> Download Application Content <<<<<<<<<”
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

Echo “>>>>>>>>>>> Extract Application Content <<<<<<<<<”
cd /app
unzip /tmp/catalogue.zip
cd /app

Echo “>>>>>>>>>>> Download Nodejs Dependencies  <<<<<<<<<”
npm install

Echo “>>>>>>>>>>> Install MongoDB Client <<<<<<<<<”
yum install mongodb-org-shell -y

Echo “>>>>>>>>>>> Load Catalogue Schema <<<<<<<<<”
mongo --host mongodb.devops7874.online </app/schema/catalogue.js

Echo “>>>>>>>>>>> Start Catalogue Service <<<<<<<<<”
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue








