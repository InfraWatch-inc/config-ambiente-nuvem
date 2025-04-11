# Atualizar a máquina
echo -e "\033[41;1;37m Atualizando Sistema... \033[0m"
sudo apt update -qq -y
sudo apt upgrade -qq -y

# Instalar drivers 
echo -e "\033[41;1;37m Instalando Drivers da GPU... \033[0m"
sudo apt install -y nvidia-driver-525 nvidia-cuda-toolkit

# Instalando blender 
echo -e "\033[41;1;37m Instalando Blender... \033[0m"
sudo snap install blender --classic

# Instalando um modelo blend para rederizaçõ
echo -e "\033[41;1;37m Instalando Modelo 3D Blender... \033[0m"
wget https://download.blender.org/demo/test/cycles_benchmark_230.blend

# Clonar github com script python

# Instalar pip do Python 
echo -e "\033[41;1;37m Instalando Python e Pip... \033[0m"
sudo apt install -qq -y python3-pip

# Instalar virtualenv 
echo -e "\033[41;1;37m Instalando Virtualenv... \033[0m"
sudo apt install -qq -y python3-virtualenv

# Clonar repositório com python
echo -e "\033[41;1;37m Clonando Repositório... \033[0m"
git clone --quiet https://github.com/InfraWatch-inc/scripts-client.git

# Criar virtualenv
echo -e "\033[41;1;37m Criando Virtualenv... \033[0m"
python3 -m virtualenv env/

# Iniciando ambiente virtual
echo -e "\033[41;1;37m Iniciar Ambiente Virtual... \033[0m"
source env/bin/activate

# Instalar bibliotecas Python necessárias
echo -e "\033[41;1;37m Instalando bibliotecas Python... \033[0m"
pip3 install --quiet --no-input script_captura/requirements.txt

# 
blender -b cycles_benchmark_230.blend --python use_gpu.py -o //frame_ -F PNG -f 1

# rodar o script python
echo -e "\033[41;1;37m Rondando Script Python... \033[0m"
chmod 777 ./scripts-client/script_captura/script_captura_adaptado.py
python3 ./scripts-client/script_captura/script_captura_adaptado.py

