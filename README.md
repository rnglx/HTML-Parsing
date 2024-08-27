# HTML-Parsing
 é uma ferramenta de HTML Parsing voltada para pentest e análise de segurança, projetada para automatizar a extração e resolução de URLs, facilitando a coleta de informações durante atividades de reconhecimento.

### Funcionalidades
* Extração automática de URLs a partir do código HTML de um domínio.
 
* Resolução dos endereços IP correspondentes às URLs extraídas.
 
* Salva os resultados em um arquivo de texto para fácil referência futura.

### Como Usar:

#### Clonar o repositório:

git clone https://github.com/rnglx/HTML-Parsing.git

cd HTML-Parsing

chmod +x webscaner

#### Executar a ferramenta:

./webscaner.sh [domínio]

### Exemplo de uso:

./webscaner.sh www.exemplo.com

#### Funcionamento
A ferramenta realiza o download do HTML da página especificada.
Extrai todas as URLs encontradas no HTML.
Resolve os endereços IP dessas URLs.
Exibe os resultados no terminal e salva em um arquivo de texto.
