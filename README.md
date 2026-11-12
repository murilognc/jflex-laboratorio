# Laboratório de Análise Léxica com JFlex e Docker

Projeto didático para a disciplina de Compiladores. O laboratório utiliza Java 17, JFlex 1.9.1, Maven e Docker Compose para gerar e executar um analisador léxico simples para a linguagem fictícia MiniLang.

## Requisitos

- Docker Desktop ou Docker Engine com o plugin Docker Compose.
- Acesso à internet na primeira construção da imagem (para baixar dependências Maven).

Não é necessário instalar Java, Maven ou JFlex na máquina diretamente.

## Estrutura

```text
jflex-laboratorio/
├── Dockerfile
├── compose.yaml
├── pom.xml
├── README.md
├── src/main/jflex/Lexer.flex
├── src/main/java/Main.java
└── exemplos/
    ├── programa1.txt
    ├── programa2.txt
    ├── programa_invalido.txt
    └── programa3_operadores.txt
```

## 1. Construir a imagem

Na raiz do projeto:

```bash
docker compose build
```

## 2. Executar interativamente

```bash
docker compose run --rm lexer
```

Digite o código-fonte e finalize a entrada com `Ctrl+D` no macOS/Linux ou `Ctrl+Z` seguido de Enter no Windows.

## 3. Testar os arquivos de exemplo

```bash
docker compose run --rm -T lexer < exemplos/programa1.txt
docker compose run --rm -T lexer < exemplos/programa2.txt
docker compose run --rm -T lexer < exemplos/programa_invalido.txt
docker compose run --rm -T lexer < exemplos/programa3_operadores.txt
```

## 4. Modificar o analisador

Edite `src/main/jflex/Lexer.flex`. O diretório do projeto está montado no container como volume, portanto as alterações ficam na máquina de execução.

Execute novamente o comando `docker compose run --rm lexer`. O comando padrão executa `mvn clean compile`, regenerando o analisador a partir do arquivo `.flex`.

## 5. Gerar somente o analisador

Para observar a etapa de geração:

```bash
docker compose run --rm lexer mvn -DskipTests generate-sources
```

O arquivo Java gerado ficará em:

```text
target/generated-sources/jflex/Lexer.java
```

## Observações didáticas

Este projeto implementa apenas a análise léxica. Ele não verifica se a sequência de tokens forma um programa sintaticamente válido nem executa o código MiniLang.

O JFlex escolhe o padrão que consome a maior quantidade de caracteres; em caso de empate, vence a regra declarada primeiro. Por isso, as palavras reservadas aparecem antes da regra de identificadores. Operadores de vários caracteres também foram declarados explicitamente.

A linguagem é intencionalmente pequena. Por exemplo, ainda não há suporte a strings, números negativos como token único, notação científica ou validação de tipos.
