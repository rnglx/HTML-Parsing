#!/bin/bash

# Função para desenhar uma linha separadora
draw_line() {
  echo "===================================================================="
}

# Função para exibir a interface
display_results() {
  local output_file="$1"
  
  draw_line
  echo -e "\e[1;32m[+] Resolvendo URLs em:\e[0m \e[1;36m$domain\e[0m"
  draw_line
  echo -e "\e[1;32m[+] Completo! : Salvando os resultado em:\e[1;31m $output_file\e[0m"
  draw_line
  echo -e "\e[1;33mLine\tIP\t\t\tADDRESS\e[0m"
  
  # Contador de linhas
  line_number=1
  while IFS= read -r line; do
    ip=$(echo "$line" | awk '{print $NF}')
    address=$(echo "$line" | awk '{print $1}')
    echo -e "$line_number\t$ip\t$address"
    line_number=$((line_number + 1))
  done < "$output_file"
  
  draw_line
}

# Exibe o ASCII
echo " __      __        ___.      _________                        "
echo "/  \    /  \  ____ \_ |__   /   _____/  ____  _____     ____  "
echo "\   \/\/   /_/ __ \ | __ \  \_____  \ _/ ___\ \__  \   /    \ "
echo " \        / \  ___/ | \_\ \ /        \\  \___  / __ \_|   |  \\"
echo "  \__/\  /   \___  >|___  //_______  / \___  >(____  /|___|  /"
echo "       \/        \/     \/         \/      \/      \/      \/ "
echo "                                                   By Lucas R."
echo ""

# Verifica se o domínio foi passado como argumento
if [ -z "$1" ]; then
  # Se não, solicita ao usuário para inserir o domínio
  read -p "Digite o domínio para análise: " domain
else
  # Caso contrário, utiliza o domínio passado como argumento
  domain="$1"
fi

# Define o nome do arquivo de saída
output_file="${domain//./_}.ip.txt"
temp_html=$(mktemp)

# Baixa o HTML do site e extrai as URLs
wget -q -O "$temp_html" "$domain"
grep -Eo '(http|https)://[^"]+' "$temp_html" | cut -d "/" -f 3 | grep "\." | cut -d '"' -f 1 | grep -v "<l" > lista

# Resolve os IPs das URLs extraídas e salva no arquivo de saída
> "$output_file"
for url in $(cat lista); do
  host_result=$(host "$url" | grep "has address")
  if [ -n "$host_result" ]; then
    echo "$host_result" >> "$output_file"
  fi
done

# Exibe os resultados 
display_results "$output_file"

# Remove o arquivo temporário
rm -f "$temp_html" lista

# Pergunta ao usuário se deseja fazer uma nova pesquisa
while true; do
  read -p "- Nova pesquisa? y/n: " yn
  case $yn in
      [Yy]* ) exec "$0"; break;;
      [Nn]* ) exit;;
      * ) echo "Please answer yes or no.";;
  esac
done
