#!/bin/bash

#!/bin/bash

# cria uma pasta projeto na instacia da nuvem
# manda esse arquivo por scp na pasta 
# da permissao de chmod +x configScriptPython.sh
# executa ele ./configScriptPython.sh
# se nn executar e vc enviou um arquivo cujo a origem era de um pc windows, execute estes comandos e rode novamente: sudo apt update | sudo apt install dos2unix | dos2unix configScriptPython.sh

# os q's são de quiet (silencio) para mostrar menos texto (por mais q monstre uma porrada ainda assim)
# e os y's são para não ficar fazendo perguntas no meio dos comandos

# Atualizar a máquina
echo -e "\033[41;1;37m Atualizando Sistema... \033[0m"
sudo apt update -qq -y
sudo apt upgrade -qq -y

# clonar repositório 
echo -e "\033[41;1;37m Clonando Repositório... \033[0m"
git clone --quiet https://github.com/InfraWatch-inc/scripts-python.git

# Salvar as regras de iptables
sudo apt-get update
sudo apt-get install -y iptables-persistent

sudo netfilter-persistent save
sudo netfilter-persistent reload

# Instalar pip do Python 
echo -e "\033[41;1;37m Instalando Python e Pip... \033[0m"
sudo apt install -qq -y python3-pip

# Instalar virtualenv 
echo -e "\033[41;1;37m Instalando Virtualenv... \033[0m"
sudo apt install -qq -y python3-virtualenv

# Criar virtualenv
echo -e "\033[41;1;37m Criando Virtualenv... \033[0m"
python3 -m virtualenv infrawatch/scripts-python/script_captura/env

# Iniciando ambiente virtual
echo -e "\033[41;1;37m Iniciar Ambiente Virtual... \033[0m"
source infrawatch/scripts-python/script_captura/env/bin/activate

# Instalar bibliotecas Python necessárias
echo -e "\033[41;1;37m Instalando bibliotecas Python... \033[0m"
pip3 install --quiet --no-input psutil==7.0.0 mysql-connector-python==9.2.0 GPUtil==1.4.0 pynvml==12.0.0 

# rodar o script python
echo -e "\033[41;1;37m Rondando Script Python... \033[0m"
chmod 777 ./infrawatch/scripts-python/script_captura/script_captura.py
python3 ./infrawatch/scripts-python/script_captura/script_captura.py