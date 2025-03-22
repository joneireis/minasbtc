# MinasBtc

![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
![Bitcoin](https://img.shields.io/badge/Bitcoin-F7931A?style=flat-square&logo=bitcoin&logoColor=white)
![Alpine](https://img.shields.io/badge/Alpine_Linux-0D597F?style=flat-square&logo=alpine-linux&logoColor=white)

**MinasBtc** é um projeto para mineração solo de Bitcoin usando Docker e Portainer. Ele cria um container baseado no Alpine Linux que executa o `cpuminer` para minerar Bitcoin em modo solo, com controles para o número de threads da CPU e o endereço da carteira Bitcoin.

## 📋 Visão Geral

Este projeto automatiza a criação de um container Docker que:
- Usa o Alpine Linux como base para maior leveza e eficiência.
- Compila e executa o `cpuminer` para mineração de Bitcoin em modo solo.
- Permite configurar o número de threads da CPU e o endereço da carteira via variáveis de ambiente.
- É gerenciado via Portainer para facilitar o deployment e monitoramento.

> **Nota**: Mineração solo com CPU não é lucrativa devido à alta dificuldade da rede Bitcoin. Este projeto é mais adequado para fins educacionais ou experimentais.

## 🛠️ Pré-requisitos

Antes de começar, certifique-se de ter:
- [Docker](https://docs.docker.com/get-docker/) instalado no seu sistema.
- [Portainer](https://docs.portainer.io/start/install/server/docker) configurado e rodando.
- Um endereço de carteira Bitcoin válido para receber possíveis recompensas.
- Acesso à internet para baixar dependências e conectar ao pool de mineração.

## 🚀 Como Usar

Siga os passos abaixo para implantar o projeto no Portainer.

### 1. Clone o Repositório
Clone este repositório para o seu ambiente local:
```bash
git clone https://github.com/jonereis/minasbtc.git
cd minasbtc