#!/usr/bin/env bash

# Copyright (c) 2019 Alann Santos

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

###############################################################################

### Variaveis.

#Variavel que não pode ser alterada.
CAMINHO_SELECIONADO=$1

#Variavel que pode ser. 
PESQUISA="nairobi*.dat"
PRIMEIRA_EXPRESSAO="s/nairobi_20/na/"
SEGUNDA_EXPRESSAO="s/T[0-9][0-9]_.*$/.08z/"

### Caso voce não digite o local apos o script, ele vai mostrar uma mensagem explicando.

if [ -z "$1" ] ; then
    echo -e "  \033[1;34m╭──────────────────────────────────────────────────────────────────────╮\033[0m"
    echo -e "  \033[1;34m│    \033[1;33mColoque o caminho da pasta que vai ser escaneada após o script\033[0m    \033[1;34m│\033[0m"
    echo -e "  \033[1;34m│                  \033[1;33mExemplo:\033[0m \033[1;35m./rename.sh ~/Documentos\033[0m                   \033[1;34m│\033[0m"
    echo -e "  \033[1;34m│    \033[1;33mou simplesmente arraste a pasta do seu gerenciador de arquivos\033[0m    \033[1;34m│\033[0m"
    echo -e "  \033[1;34m│                  \033[1;33mpara o terminal após o\033[0m \033[1;35m./rename.sh\033[0m                  \033[1;34m│\033[0m"
    echo -e "  \033[1;34m╰──────────────────────────────────────────────────────────────────────╯\033[0m"
    exit

### Caso voce digite um caminho que não existe, ele vai mostrar a mensagem dizendo.

elif [[ -e "$CAMINHO_SELECIONADO" ]]; then
	CAMINHO="$CAMINHO_SELECIONADO"
else
    echo -e "  \033[1;34m╭──────────────────────────╮\033[0m"
    echo -e "  \033[1;34m│ \033[1;33mEste caminho não existe.\033[0m \033[1;34m│\033[0m"
    echo -e "  \033[1;34m╰──────────────────────────╯\033[0m"
    exit
fi

### Ele vai verificar se o Rename está instalado caso não esteja, ele vai mandar instalar.

if [ ! -e /usr/bin/rename ] && [ ! -e /usr/local/bin/rename ] ; then
    echo
    echo -e "\033[1;32m  Esse Script depende do\033[0m \033[1;33mRename\033[0m \033[1;32mesteja instalado.\033[0m"
    echo -e "\033[1;32m  Por favor, instale-o usando:\033[0m"
    echo
    echo -e "  \033[1;34m╭─────────────────────────╮\033[0m"
    echo -e "  \033[1;34m│\033[0m \033[1;33msudo apt install rename\033[0m \033[1;34m│\033[0m"
    echo -e "  \033[1;34m╰─────────────────────────╯\033[0m"
    echo
else
    RESULTADOS="$(find "$CAMINHO" -iname "$PESQUISA")"

### Aqui é onde a magia acontece.

for RESULTADO in $RESULTADOS
    do
        echo -e "\n\033[1;33mRenomenando\033[0m \033[1;34m$RESULTADO\033[0m"
        echo -e "\033[1;33mPara\033[0m \033[1;32m$RESULTADO\033[0m" | sed "$PRIMEIRA_EXPRESSAO" | sed "$SEGUNDA_EXPRESSAO"
        echo "Renomenando $RESULTADO" >> "rename-log.txt"
        echo "Para $RESULTADO" | sed "$PRIMEIRA_EXPRESSAO" | sed "$SEGUNDA_EXPRESSAO" >> "rename-log.txt"
        rename "$PRIMEIRA_EXPRESSAO, $SEGUNDA_EXPRESSAO" "$RESULTADO"
done

### Mostra mensangem Dizendo que criou um arquivo log.

echo -e "  \033[1;34m╭───────────────────────────╮"
echo -e "  \033[1;34m│\033[0m \033[1;33mUm Arquivo log foi criado\033[0m \033[1;34m│\033[0m"
echo -e "  \033[1;34m│\033[0m \033[1;33mcom o nome rename-log.txt\033[0m \033[1;34m│\033[0m"
echo -e "  \033[1;34m╰───────────────────────────╯\033[0m"
fi