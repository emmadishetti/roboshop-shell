log=/tmp/roboshop.log
echo ">>>>>>>>>>> ${component} Service <<<<<<<<<"
cp ${component}.service /etc/systemd/system/${component}.service &>>${log}

echo ">>>>>>>>>>> ctreate Mongo Repo  <<<<<<<<<"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}

echo ">>>>>>>>>>> Download nodejs Repos <<<<<<<<<"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}

echo ">>>>>>>>>>> Install Nodejs <<<<<<<<<"
yum install nodejs -y &>>${log}

echo ">>>>>>>>>>> Create Application User <<<<<<<<<"
useradd roboshop &>>${log}

echo ">>>>>>>>>>> Removing exisiting data <<<<<<<<<"
rm -rf /app &>>${log}

echo ">>>>>>>>>>> Creating the Application Directory  <<<<<<<<<"
mkdir /app &>>${log}

echo ">>>>>>>>>>> Download Application Content <<<<<<<<<"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}

echo ">>>>>>>>>>> Extract Application Content <<<<<<<<<"
cd /app
unzip /tmp/${component}.zip &>>${log}
cd /app

echo ">>>>>>>>>>> Download Nodejs Dependencies  <<<<<<<<<"
npm install &>>${log}

echo ">>>>>>>>>>> Install MongoDB Client <<<<<<<<<"
yum install mongodb-org-shell -y &>>${log}

echo ">>>>>>>>>>> Load ${component} Schema <<<<<<<<<"
mongo --host mongodb.devops7874.online </app/schema/${component}.js &>>${log}

echo ">>>>>>>>>>> Start ${component} Service <<<<<<<<<"
systemctl daemon-reload
systemctl enable ${component}
systemctl restart ${component} &>>${log}








