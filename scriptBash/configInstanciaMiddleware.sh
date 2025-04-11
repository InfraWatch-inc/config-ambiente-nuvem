#!/bin/bash

# os q's são de quiet (silencio) para mostrar menos texto (por mais q monstre uma porrada ainda assim)
# e os y's são para não ficar fazendo perguntas no meio dos comandos

# Atualizar a máquina
echo -e "\033[41;1;37m Atualizando Sistema... \033[0m"
sudo apt update -qq -y
sudo apt upgrade -qq -y

# Instalar Node.js 
echo -e "\033[41;1;37m  Instalando NodeJS... \033[0m" # formatacao de texto vermelho pra deixar destacado
sudo apt install -qq -y nodejs npm

# Clonar repositório api middleware
echo -e "\033[41;1;37m Clonando Repositório... \033[0m"
git clone --quiet https://github.com/InfraWatch-inc/api-middleware.git
