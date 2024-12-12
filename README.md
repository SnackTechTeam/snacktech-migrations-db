# SnackTech - Database Migration Scripts ⚙️

> Repositório para armazenar scripts de migração de banco de dados do projeto SnackTech com execução automatizada via GitHub Actions. Permite que DBAs possam avaliar e revisar os scripts antes de sua aplicação.

---

## 📌 Índice

- [Sobre o Projeto](#sobre-o-projeto)  
- [Objetivo](#objetivo)  
- [Pré-requisitos](#pre-requisitos)  
- [Estrutura do Repositório](#estrutura-do-repositorio)  
- [Tecnologias utilizadas](#tecnologias-utilizadas)  
- [Configuração de Execução com GitHub Actions](#configuracao-de-execucao-com-github-actions)  
- [Instalação e Execução Local (se necessário)](#instalacao-e-execucao-local)  
- [Equipe](#equipe) 

---

## 🛠️ Sobre o Projeto

Este repositório tem o objetivo de centralizar scripts de migração de banco de dados, garantindo que sejam revisados por DBAs antes de serem aplicados em ambientes de produção.

Os scripts podem ser executados automaticamente por meio do GitHub Actions, garantindo agilidade e segurança no fluxo de CI/CD para a migração de dados.

---

## 🎯 Objetivo

- Permitir a revisão manual de scripts antes da execução.  
- Automatizar a execução de scripts de migração usando GitHub Actions.  
- Facilitar o versionamento e controle de mudanças no esquema do banco de dados.

---

## 🛡️ Pré-requisitos

Antes de usar os scripts ou configurar os workflows, é necessário ter a instância **SQL Server na AWS RDS** configurada para permitir a conexão. Os detalhes da criação dessa infraestrutura estão no repositório [snacktech-infra-db](https://github.com/SnackTechTeam/snacktech-infra-db)


### ⚙️ Configuração da instância SQL Server
1. **Configure a instância na AWS RDS** com SQL Server.  
   - Certifique-se de que a instância está acessível pela rede.  
   - Certifique-se de que a database já esteja criada. Caso seja a primeira execução, criei a database pelo seguinte comando usando o MSSMS
  
```sql
CREATE DATABASE [SnackTechDb];
GO
```

2. **Obtenha as credenciais e informações de conexão**, como:
   - Endpoint da instância (**DB_INSTANCE**)
   - Porta  (**DB_PORT**)
   - Nome do banco  (**DB_NAME**)
   - Usuário (**DB_UID**)
   - Senha  (**DB_PASSWORD**)

3. **Atualize suas configurações no `Actions secrets and variables`** para refletir esses dados.
   - Atenção! Se as variáveis já existirem no `Organization secrets`, não há necessidade de modificá-las a não ser que alguma informação tenha mudado.

---

## 🗂️ Estrutura do Repositório

Aqui está a estrutura padrão do repositório:

```
/
├── Migrations/                  # Contém as pastas com scripts de migração e o arquivo PowerShell para execução dos scripts
│   ├── Applied/                 # Contém os scripts já aplicados no DB. Serve apenas para um melhor controle.
│   ├── NotApplied/              # Contém os scripts que necessitam de revisão do DBA e que serão executados no DB pelo GitHub Actions
│   └── PowerShell/              # Contém o script PowerShell que se conecta no banco e executa todos os arquivos contidos na pasta /NotApplied
│
├── .github/                     # Configurações do GitHub Actions
│   └── workflows/
│       └── main.yml
│
└── README.md                     # Documentação do repositório
```

---

## 💻 Tecnologias utilizadas

As tecnologias e recursos principais usados neste repositório incluem:

- **SQL Server no AWS RDS** - Instância que deve estar configurada para execução.
- **PowerShell** - Para executar a conexão com o banco de dados e executar todos os scripts contidos na pasta /NotApplied
- **GitHub Actions** - Para automatizar os workflows.  
- **Ferramentas SQL Server Management Studio (SSMS)** ou equivalentes para a execução local.  

---

## ⚙️ Configuração de Execução com GitHub Actions {#configuracao-de-execucao-com-github-actions}

Os workflows no GitHub Actions garantem que os scripts possam ser executados de forma segura após revisão manual.

Os scripts dependem da conexão com uma instância **SQL Server na AWS RDS**.

### Configurar credenciais seguras no GitHub Secrets
Antes de configurar o workflow, defina os seguintes segredos no GitHub:

- `DB_INSTANCE`: Endpoint da instância SQL Server  
- `DB_PORT`: Porta utilizada pela instância  
- `DB_UID`: Nome do usuário para conexão  
- `DB_PASSWORD`: Senha do usuário  
- `DB_NAME`: Nome do banco de dados  

Você pode configurar esses segredos assim:

1. Acesse seu repositório no GitHub.
2. Vá até **Settings → Secrets and Variables → Actions → Organization secrets**.
3. Insira os valores necessários com os nomes acima.

---

## 💡 Instalação e Execução Local

Caso precise executar scripts manualmente ou em um ambiente local:

1. **Configure a instância SQL Server na AWS RDS** com as credenciais apropriadas.  
2. Certifique-se de que as portas necessárias estão abertas para acesso seguro.  

### Executando o script PowerShell localmente

1. Abra a pasta desse repositório pelo VSCode.
2. Abra o arquivo ApplyMigrations.ps1 localizado na pasta /Migrations/PowerShell no VSCode.
3. Pressione F5 ou acesso o menu superior Run > Start Debugging.
4. O TERMINAL do VSCode iniciará e solicitará os valores das variáveis de conexão com o banco de dados.
5. Informe todos os valores teclando Enter após cada valor inserido.
6. Ao final de todos os valores informados corretamente, todos os scripts de migrations da pasta NotApplied serão executados

Exemplo do terminal:

![image](https://github.com/user-attachments/assets/57d7446a-91d5-417b-9ba3-efde8c789c7e)

---

## Equipe

* Adriano de Melo Costa. Email: adriano.dmcosta@gmail.com
* Rafael Duarte Gervásio da Silva. Email: rafael.dgs.1993@gmail.com
* Guilherme Felipe de Souza. Email: gui240799@outlook.com
* Dayvid Ribeiro Correia. Email: dayvidrc@gmail.com
