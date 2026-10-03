#!/usr/bin/env bash

if [ "$1" = "-v" ]
then set -x
fi
# script para analisar a qualidade de outros scripts
# com shellcheck

# ---configuração---
NOME_AMBIENTE="genomica_v1"

DIR_SCRIPTS=$(dirname "$0")

# ---execução---
echo ""
echo "================================================"
echo "A iniciar a análise de scripts em : $DIR_SCRIPTS"
echo "usando o ambiente conda '$NOME_AMBIENTE'"
echo "================================================"

HOUVE_ERROS=0

for script_file in "$DIR_SCRIPTS"/*.sh
do
echo ""
echo " --- A analisar o ficheiro: $(basename "$script_file") ---"

# Executar o shellcheck dentro do ambiente especificado

conda run -n "$NOME_AMBIENTE" shellcheck -e SC2181 "$script_file"

if [ $? -ne 0 ]
then
HOUVE_ERROS=1
fi
done

# Resumo final
echo ""
echo "=============================="
echo "Análise concluída."
if [ $HOUVE_ERROS -eq 1 ]
then
echo "Foram detetados problemas. Por favor reveja as mensagens acima."
else
echo "Todos os scripts passaram na verificação do shellcheck. Bom trabalho!"
fi
echo "=============================="
echo ""
