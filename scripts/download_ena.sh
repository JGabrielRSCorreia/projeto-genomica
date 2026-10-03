#!/usr/bin/env bash

# Verifica se o accession foi passado como argumento
if [ -z "$1" ]
then
echo "Erro: é necessário fornecer um Run Accession do ENA como argumento."
echo "uso: $0 <ENA_RUN_ACCESSION>"
exit 1
fi

set -e
set -x

ACCESSION="$1"
DIR_SAIDA="dados_brutos"
ENA_FTP_BASE="ftp.sra.ebi.ac.uk/vol1/fastq"

# --- Lógica de construção do URL ---
# O ENA organiza os ficheiros numa estrutura de diretórios.
# Nota: A lógica funciona apenas para um subconjunto de ACCESSIONS do ENA.
# ex: ERR298477 está em .../ERR298/
# Extraimos os primeiros caracteres do accession para construir o caminho
PREFIXO_DIR="${ACCESSION:0:6}"

# Construir os URLs completos para os dois ficheiros
URL_R1="ftp://${ENA_FTP_BASE}/${PREFIXO_DIR}/${ACCESSION}/${ACCESSION}_1.fastq.gz"
URL_R2="ftp://${ENA_FTP_BASE}/${PREFIXO_DIR}/${ACCESSION}/${ACCESSION}_2.fastq.gz"

echo "A iniciar o download para o accession: $ACCESSION"
echo "A guardar em: $DIR_SAIDA"

# wget com flag -P para especificar o diretório de saída
wget -P "$DIR_SAIDA" "$URL_R1"
wget -P "$DIR_SAIDA" "$URL_R2"

echo "Download de $ACCESSION concluido"
