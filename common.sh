log=/tmp/roboshop.log
echo -e  "\e[35m>>>>> ${component} Service <<<<<<<<<\e[0m"
cp ${component}.service /etc/systemd/system/${component}.service &>>${log}

echo -e  "\e[35m>>>>> ctreate Mongo Repo  <<<<<<<<<"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}

echo -e  "\e[35m>>>>> Download nodejs Repos <<<<<<<<<"\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}

echo -e  "\e[35m>>>>> Install Nodejs <<<<<<<<<\e[0m"
yum install nodejs -y &>>${log}

echo -e  "\e[35m>>>>>Create Application User <<<<<<<<<\e[0m"
useradd roboshop &>>${log}

echo -e  "\e[35m>>>>> Removing exisiting data <<<<<<<<<\e[0m"
rm -rf /app &>>${log}

echo -e  "\e[35m>>>>> Creating the Application Directory  <<<<<<<<<\e[0m"
mkdir /app &>>${log}

echo -e  "\e[35m>>>>> Download Application Content <<<<<<<<<\e[0m"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}

echo -e  "\e[35m>>>>> Extract Application Content <<<<<<<<<\e[0m"
cd /app
unzip /tmp/${component}.zip &>>${log}
cd /app

echo -e  "\e[35m>>>>> Download Nodejs Dependencies  <<<<<<<<<\e[0m"
npm install &>>${log}

echo -e  "\e[35m>>>>> Install MongoDB Client <<<<<<<<<\e[0m"
yum install mongodb-org-shell -y &>>${log}

echo -e  "\e[35m>>>>> Load ${component} Schema <<<<<<<<<\e[0m"
mongo --host mongodb.devops7874.online </app/schema/${component}.js &>>${log}

echo -e  "\e[35m>>>>> Start ${component} Service <<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable ${component}
systemctl restart ${component} &>>${log}








