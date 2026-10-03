DIR_SCRIPTS := scripts
SCRIPTS_A_ANALISAR := $(wildcard $(DIR_SCRIPTS)/*.sh)
FICHEIRO_RESULTADO := logs/analise_qualidade.log

# A primeira regra num makefile é a regra "default"
# ao executar 'make' sem argumentos, ele tentar+a construir este alvo
# '.PHONY' diz ao make que 'all' não é um ficheiro real

.PHONY: all
all: $(FICHEIRO_RESULTADO)

# O @ em cada comando impede que o próprio comando seja impresso no ecrã
# mostrando apenas o seu output
$(FICHEIRO_RESULTADO): $(SCRIPTS_A_ANALISAR)
	@echo "-> Um ou mais scripts foram modificados. A executar a análise de qualidade..."
	@./$(DIR_SCRIPTS)/analisar_scripts.sh > $(FICHEIRO_RESULTADO)
	@echo "-> Análise concluída. Resultados guardados em $(FICHEIRO_RESULTADO)"

.PHONY: clean
clean:
	@echo "-> A remover ficheiros de resultados gerados..."
	@rm -f $(FICHEIRO_RESULTADO)

# --- Secção para a aquisição de Dados ---

ENA_ACCESSION := ERR298477

DIR_SAIDA := dados_brutos

# continuar...........
