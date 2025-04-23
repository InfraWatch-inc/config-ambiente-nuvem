echo -e "\033[41;1;37m Atualizando Sistema... \033[0m"
sudo apt update -qq -y
sudo apt upgrade -qq -y

# Clonando o repositório database 
echo -e "\033[41;1;37m Clonando o repositório databsae... \033[0m"
git clone https://github.com/InfraWatch-inc/database.git

sudo apt install mysql-server -y
sudo systemctl status mysql

sudo systemctl start mysql
sudo systemctl enable mysql

sudo mysql < database/script.sql

# sudo mysql
# sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf mudar bind address

# GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'sua_senha' WITH GRANT OPTION;
# FLUSH PRIVILEGES;

# sudo systemctl restart mysql

