# MinasBtc

![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
![Bitcoin](https://img.shields.io/badge/Bitcoin-F7931A?style=flat-square&logo=bitcoin&logoColor=white)
![Alpine](https://img.shields.io/badge/Alpine_Linux-0D597F?style=flat-square&logo=alpine-linux&logoColor=white)

**MinasBtc** é um projeto para mineração solo de Bitcoin usando Docker e Portainer. Ele cria um container baseado no Alpine Linux que executa o `cpuminer` para minerar Bitcoin em modo solo, com controles para o número de threads da CPU e o endereço da carteira Bitcoin.

## Visão Geral

Este projeto automatiza a criação de um container Docker que:
- Usa o Alpine Linux como base para maior leveza e eficiência.
- Compila e executa o `cpuminer` para mineração de Bitcoin em modo solo.
- Permite configurar o número de threads da CPU e o endereço da carteira via variáveis de ambiente.
- É gerenciado via Portainer para facilitar o deployment e monitoramento.

**Nota:** Mineração solo com CPU não é lucrativa devido à alta dificuldade da rede Bitcoin. Este projeto é mais adequado para fins educacionais ou experimentais.

## Pré-requisitos

Antes de começar, certifique-se de ter:
- [Docker](https://docs.docker.com/get-docker/) instalado no seu sistema.
- [Portainer](https://docs.portainer.io/start/install/server/docker) configurado e rodando.
- Um endereço de carteira Bitcoin válido para receber possíveis recompensas.
- Acesso à internet para baixar dependências e conectar ao pool de mineração.

## Como Usar

Siga os passos abaixo para implantar o projeto no Portainer.

### 1. Clone o Repositório

Clone o repositório do GitHub: https://github.com/jonereis/minasbtc

### 2. Configurar Variáveis de Ambiente

O projeto usa variáveis de ambiente para configurar o minerador. Você pode defini-las no Portainer ou em um arquivo `.env`. As variáveis são:

- `WALLET_ADDRESS`: Seu endereço de carteira Bitcoin (ex.: `1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa`).
- `CPU_THREADS`: Número de threads da CPU a serem usadas (ex.: `2`).
- `POOL_URL`: URL do pool solo (padrão: `stratum+tcp://solo.ckpool.org:3333`).

Exemplo de arquivo `.env` em texto simples:

WALLET_ADDRESS=your_bitcoin_wallet_address_here  
CPU_THREADS=2  
POOL_URL=stratum+tcp://solo.ckpool.org:3333

### 3. Implantar no Portainer

1. Acesse o Portainer via navegador (geralmente em `http://localhost:9000`).
2. Vá para *Stacks* > *Add Stack*.
3. Configure o stack:
   - *Name*: `minasbtc`
   - *Build Method*: Escolha *Repository*.
   - *Repository URL*: `https://github.com/jonereis/minasbtc.git`
   - *Repository Reference*: `refs/heads/main`
   - *Compose Path*: `docker-compose.yml`
4. Defina as variáveis de ambiente:
   - Adicione as variáveis `WALLET_ADDRESS`, `CPU_THREADS`, e `POOL_URL` na seção *Environment Variables*.
5. Clique em *Deploy the Stack*.
6. Verifique os logs do container `minasbtc-miner` para confirmar que a mineração começou.

### 4. Monitorar a Mineração

Acesse os logs do container no Portainer para verificar o status da mineração. Você deve ver algo como:

[2025-03-22 12:34:56] Starting Stratum on stratum+tcp://solo.ckpool.org:3333  
[2025-03-22 12:34:56] 2 miner threads started, using 'sha256d' algorithm.

Monitore o uso de CPU e ajuste o `CPU_THREADS` se necessário.

## Estrutura do Projeto

- `Dockerfile`: Define a imagem Docker baseada no Alpine Linux, instala dependências, e compila o `cpuminer`.
- `docker-compose.yml`: Configura o serviço para o Portainer, incluindo variáveis de ambiente e servidores DNS.
- `README.md`: Documentação do projeto (este arquivo).

## Configurações Avançadas

### Alterar o Pool de Mineração

Se o pool padrão (`solo.ckpool.org`) não estiver funcionando, você pode alterá-lo editando a variável `POOL_URL` no Portainer. Alguns pools solo alternativos:
- `stratum+tcp://solo.nicehash.com:3333`
- `stratum+tcp://solo.bitcoin.com:3333`

### Ajustar o Uso de CPU

Se o container estiver consumindo muita CPU, reduza o valor de `CPU_THREADS` no Portainer e reimplante o stack.

### Construir Localmente (Opcional)

Se o build no Portainer falhar devido a problemas de rede, você pode construir a imagem localmente e carregá-la:

Execute: docker build -t minasbtc:latest .  
Salve a imagem: docker save -o minasbtc.tar minasbtc:latest

Transfira o `minasbtc.tar` para o servidor do Portainer e carregue:

Execute: docker load -i minasbtc.tar

Ajuste o `docker-compose.yml` para usar a imagem pré-construída:

version: "3"  
services:  
  minasbtc:  
    image: minasbtc:latest  
    container_name: minasbtc-miner  
    dns:  
      - 8.8.8.8  
      - 8.8.4.4  
    environment:  
      - WALLET_ADDRESS=${WALLET_ADDRESS}  
      - CPU_THREADS=${CPU_THREADS}  
      - POOL_URL=${POOL_URL}  
    restart: unless-stopped

## Notas Importantes

- **Eficiência**: Mineração solo com CPU não é lucrativa devido à alta dificuldade da rede Bitcoin. Considere usar hardware especializado (ASICs) para mineração real.
- **Segurança**: Nunca compartilhe a chave privada da sua carteira Bitcoin. Use apenas o endereço público em `WALLET_ADDRESS`.
- **Rede**: Certifique-se de que o ambiente do Docker/Portainer tem acesso à internet para baixar dependências e conectar ao pool.

## Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests no [repositório GitHub](https://github.com/jonereis/minasbtc).

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

## Contato

Se precisar de ajuda, entre em contato via [GitHub Issues](https://github.com/jonereis/minasbtc/issues).