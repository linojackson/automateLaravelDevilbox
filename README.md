# Automate Laravel Devilbox

Um script para automatizar novos projetos com Laravel usando o contêiner Devilbox

## Pré-requisitos

Você precisa ter clonado o container do Devilbox para sua máquina e ele precisa estar rodando

## Como usar

Para usar a automação, siga os passos:

Clone o projeto:

```bash
git clone https://github.com/linojackson/automateLaravelDevilbox
cd automateLaravelDevilbox
```

Copie o script para seu container Devilbox e altere as permissões:

```bash
cp createProject.sh caminho-do-seu-workspace/devilbox/createProject.sh
cd caminho-do-seu-workspace/devilbox
chmod 775 createProject.sh
```

Rode o script usando o bash e siga as instruções:

```bash
bash createProject.sh
```

Enjoy!