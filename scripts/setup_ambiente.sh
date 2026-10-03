#!/usr/bin/bash
# Script para criar o ambiente Conda para o projeto
# pára o script se ocorrer um erro
# (normalmente corre tudo que puder e avisa os erros depois)
#set -e
# mostra os comandos (útil para debugging)
set -x

# nome do ambiente como input
if [ -z "$1" ] #"-z" retorna TRUE se o comprimento da string for _z_ero
then
NOME_AMBIENTE="genomica_v1"
else
NOME_AMBIENTE="$1"
fi

# verificar se o ambiente existe
conda env list | grep "$NOME_AMBIENTE"
if [ $? -eq 0 ]
then
echo "O ambiente '$NOME_AMBIENTE' já existe"
exit 0
fi

# Define a lista de pacotes a instalar
PACOTES="shellcheck"

echo "A criar o ambiente conda chamado '$NOME_AMBIENTE'..."

conda create --name "$NOME_AMBIENTE" --channel conda-forge --yes $PACOTES

# Verifica se a criação foi bem-sucedidia
# O comando conda create falha se o ambiente já existir, por isso,
# verificamos o sucesso
if [ $? -eq 0 ]
then
echo ""
echo "Ambiente '$NOME_AMBIENTE' criado com sucesso"
echo "para ativar, execute 'conda activate $NOME_AMBIENTE"
else
echo ""
echo "ocorreu um erro ao criar o ambiente '$NOME_AMBIENTE'."
echo "verifique se o ambiente já existe com 'conda env list'"
fi

exit 0
