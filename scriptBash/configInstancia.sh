#!/bin/bash

# Comados ao abrir instancia:
# git clone https://github.com/InfraWatch-inc/config-ambiente-nuvem.git

# os q's são de quiet (silencio) para mostrar menos texto (por mais q monstre uma porrada ainda assim)
# e os y's são para não ficar fazendo perguntas no meio dos comandos

# Atualizar a máquina
echo -e "\033[41;1;37m Atualizando Sistema... \033[0m"
sudo apt update -qq -y
sudo apt upgrade -qq -y

# instalando Docker
echo -e "\033[41;1;37m Instalando Docker... \033[0m"
sudo bash scriptBash/scriptDocker.sh 

# Ativando serviços do docker
echo -e "\033[41;1;37m Ativando serviços do docker... \033[0m"
exit
sudo systemctl start docker
sudo systemctl enable docker

# Iniciar docker compose
echo -e "\033[41;1;37m Iniciando docker compose... \033[0m"
docker compose -f scriptBash/compose.yaml up -d