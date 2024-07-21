# !/bin/bash

current_folder=$(basename "$PWD")

if [ "$current_folder" != "devilbox" ]; then
    echo "Você precisa executar o script dentro da pasta 'devilbox'."
    exit 1
fi

echo "================================================="
echo "‖                                               ‖"
echo "‖    CRIAÇÃO DE PROJETOS LARAVEL NO DEVILBOX    ‖"
echo "‖                 by linojackson                ‖"
echo "‖                                               ‖"
echo "================================================="
echo
echo "Bem-vindo a criação e configuração de projetos Laravel"
echo "usando containers do Devilbox."
echo
echo "O CONTAINER DO DEVILBOX PRECISA ESTAR RODANDO"
echo
echo "Qual o nome que gostaria de dar ao projeto?"

read project_name

echo
echo "O projeto $project_name será criado"
echo "Após a criação, acesse $project_name.dvl.to no seu navegador."

# ESCOLHA DE VERSAO DO LARAVEL PARA O PROJETO

array_laravel_version=("5.0" "5.1" "5.2" "5.3" "5.4" "5.5" "5.6" "5.7" "5.8" "6.x" "7.x" "8.x" "9.x" "10.x")

echo
echo "Qual a versão do Laravel você deseja utilizar?"
for i in "${!array_laravel_version[@]}"; do
    echo "$i. ${array_laravel_version[$i]}"
done
read -p "Digite o número da versão desejada: " laravel_version

# Verifique se a escolha do usuário está dentro dos limites do array
while [ "$laravel_version" -lt 0 ] || [ "$laravel_version" -ge ${#array_laravel_version[@]} ]; do
    echo "Escolha inválida. Por favor, escolha um número válido."
    read laravel_version
done

laravel_version_choosed=${array_laravel_version[$laravel_version]}

##################

if hash docker-compose 2>/dev/null; then
    docker-compose exec --user devilbox php bash -l -c "
        mkdir $project_name
        cd $project_name
        composer create-project laravel/laravel=$laravel_version_choosed $project_name-laravel --prefer-dist
        ln -s $project_name-laravel/public/ htdocs
    "
else
    docker compose exec --user devilbox php bash -l -c "
        mkdir $project_name
        cd $project_name
        composer create-project laravel/laravel=$laravel_version_choosed $project_name-laravel --prefer-dist
        ln -s $project_name-laravel/public/ htdocs
    "
fi

if [ $? != 0 ]; then
    echo "Ocorreu um erro na execução do script."
    exit 1
fi

url_to_update="127.0.0.1 $project_name.dvl.to"
hosts_file="/etc/hosts"

if [ "$(id -u)" != "0" ]; then
    echo
    echo "---------------------------------"
    echo "Insira sua senha de usuário para que seja criado o"
    echo "redirecionamento de DNS no arquivo de /etc/hosts"
    echo "$url_to_update" | sudo -H tee -a "$hosts_file"
fi

if [ $? != 0 ]; then
    echo "Ocorreu um erro na execução do script."
    exit 1
fi

echo  "---------------------------------"
echo  "Seu projeto Laravel foi criado com sucesso!"
echo  "Acesse $project_name.dvl.to no seu navegador."
echo  "Para acessar o projeto via VSCode, utilize o comando:"
echo  "code $PWD/data/www/$project_name"
echo  "---------------------------------"
echo  "Obrigado por utilizar o script!"