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

# Instalar pip do Python 
echo -e "\033[41;1;37m Instalando Python e Pip... \033[0m"
sudo apt install -qq -y python3-pip

# Instalar virtualenv 
echo -e "\033[41;1;37m Instalando Virtualenv... \033[0m"
sudo apt install -qq -y python3-virtualenv

# Clonar repositório com python
echo -e "\033[41;1;37m Clonando Repositório... \033[0m"
git clone --quiet https://github.com/InfraWatch-inc/scripts-python.git

# Criar virtualenv
echo -e "\033[41;1;37m Criando Virtualenv... \033[0m"
python3 -m virtualenv scripts-python/env/

# Iniciando ambiente virtual
echo -e "\033[41;1;37m Iniciar Ambiente Virtual... \033[0m"
source scripts-python/env/bin/activate

# Instalar bibliotecas Python necessárias
echo -e "\033[41;1;37m Instalando bibliotecas Python... \033[0m"
pip3 install --quiet --no-input scripts-python/script_captura/requirements.txt

# Começar rodar Blender em segundo plano
echo -e "\033[41;1;37m Iniciar processo de renderização... \033[0m"
blender -b cycles_benchmark_230.blend --python use_gpu.py -o //frame_ -F PNG -f 1

# rodar o script python
echo -e "\033[41;1;37m Rondando Script Python... \033[0m"
chmod 777 ./scripts-python/script_captura/script_captura.py
python3 ./scripts-python/script_captura/script_captura.py

