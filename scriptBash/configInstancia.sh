#!/bin/bash

# Comados ao abrir instancia:
# ssh -i token.pem ubuntu@dns/ip - conectar cm a instancia (local)
# mkdir producao/  -  criar pasta para guardar o zip q vamos enviar (nuvem)
# scp -i token.pem arquivo.zip ubuntu@dns/ip:producao/ - enviar o zip pra pasta (local)
# cd producao/ - entrar na pasta q criamos (nuvem)
# sudo apt-get install unzip - instalar lib para deszipar arquivo (nuvem)
# unzip arquivo.zip - deszipar o arquivo (nuvem)
# chmod 777 Scripts/configInstancia.sh - dar permissão ao script p rodar (nuvem)
# ./Scripts/configInstancia.sh - rodar o script e rezar muito pra funfar (nuvem)

# os q's são de quiet (silencio) para mostrar menos texto (por mais q monstre uma porrada ainda assim)
# e os y's são para não ficar fazendo perguntas no meio dos comandos

echo -e "\033[41;1;37m Indo ao local correto... \033[0m"
cd ~/infraWatch

# Atualizar a máquina
echo -e "\033[41;1;37m Atualizando Sistema... \033[0m"
sudo apt update -qq -y
sudo apt upgrade -qq -y

# Instalar Node.js 
echo -e "\033[41;1;37m  Instalando NodeJS... \033[0m" # formatacao de texto vermelho pra deixar destacado
sudo apt install -qq -y nodejs npm

# instalando Docker
echo -e "\033[41;1;37m Instalando Docker... \033[0m"
sudo bash ~/infraWatch/config-ambiente-nuvem/scriptBash/scriptDocker.sh 

# Ativando serviços do docker
echo -e "\033[41;1;37m Ativando serviços do docker... \033[0m"
exit
sudo systemctl start docker
sudo systemctl enable docker

# Baixando imagen do Mysql
echo -e "\033[41;1;37m Baixando imagen do Mysql... \033[0m"
sudo docker pull mysql:8.2 

# Criando conteiner
echo -e "\033[41;1;37m Criando conteiner e iniciando... \033[0m"
sudo docker run -d -p 3000:3306 --name db -e "MYSQL_ROOT_PASSWORD=urubu100" mysql:8.2 

# Entrando no conteiner.
echo -e "\033[41;1;37m Acessando o conteiner... \033[0m"
sudo docker exec –it db bash



# Liberar a porta 3306 para qualquer IP
echo -e "\033[41;1;37m Liberar 3306 do Servidor de Banco... \033[0m"
sudo iptables -A INPUT -p tcp --dport 3306 -j ACCEPT

# Salvar as regras de iptables
sudo apt-get -y update
sudo apt-get install -y iptables-persistent

sudo netfilter-persistent -y save
sudo netfilter-persistent -y reload

# configurando MYSQL
echo -e "\033[41;1;37m Criando e estruturando BD infrawatch... \033[0m"
sudo mysql < ~/InfraWatch-inc/database/script.sql

# Criar usuários MYSQL
echo -e "\033[41;1;37m Criando Usuários do Banco... \033[0m"
sudo mysql -e"CREATE USER 'infra_root'@'%' IDENTIFIED BY 'Urubu100#';"
sudo mysql -e"GRANT ALL PRIVILEGES ON infrawatch.* TO 'infra_root'@'%';"
sudo mysql -e"FLUSH PRIVILEGES;"

sudo mysql -e"CREATE USER 'insert_user'@'%' IDENTIFIED BY 'Urubu100#';"
sudo mysql -e"GRANT INSERT ON infrawatch.* TO 'insert_user'@'%';"
sudo mysql -e"FLUSH PRIVILEGES;"

sudo mysql -e"CREATE USER 'select_user'@'%' IDENTIFIED BY 'Urubu100#';"
sudo mysql -e"GRANT SELECT ON infrawatch.* TO 'select_user'@'%';"
sudo mysql -e"FLUSH PRIVILEGES;"

sudo mysql -e"CREATE USER 'update_user'@'%' IDENTIFIED BY 'Urubu100#';"
sudo mysql -e"GRANT UPDATE ON infrawatch.* TO 'update_user'@'%';"
sudo mysql -e"FLUSH PRIVILEGES;"

sudo mysql -e"CREATE USER 'delete_user'@'%' IDENTIFIED BY 'Urubu100#';"
sudo mysql -e"GRANT DELETE ON infrawatch.* TO 'delete_user'@'%';"
sudo mysql -e"FLUSH PRIVILEGES;"

# Clonando aplicação web
echo -e "\033[41;1;37m Clonando web-data-viz... \033[0m"
git clone --quiet https://github.com/InfraWatch-inc/web-data-viz.git

# configurar e rodar projeto node
echo -e "\033[41;1;37m Configurando e inicializando web-data-viz... \033[0m"
npm --prefix ./web-data-viz install
npm --prefix ./web-data-viz audit fix
npm --prefix ./web-data-viz start