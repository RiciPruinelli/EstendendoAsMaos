# 🚀 Guia de Instalação - Sistema de Gestão para ONG

## ✅ Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- **Java JDK 17** ou superior
- **Maven 3.8+**
- **PostgreSQL 14+**
- **Redis 6+** (opcional, para cache)
- **Git** (para clonar o repositório)

## 📥 Passo 1: Obter o Código

Se você recebeu o projeto em ZIP:
```bash
unzip sistema-gestao-ong.zip
cd sistema-gestao-ong
```

Ou clone do repositório Git:
```bash
git clone <url-do-repositorio>
cd sistema-gestao-ong
```

## 🗄️ Passo 2: Configurar o Banco de Dados PostgreSQL

### 2.1 Criar o Banco de Dados

Abra o terminal do PostgreSQL e execute:

```sql
-- Conectar ao PostgreSQL
psql -U postgres

-- Criar o banco de dados
CREATE DATABASE sistema_ong;

-- Criar usuário (opcional)
CREATE USER ong_user WITH PASSWORD 'senha_segura';

-- Conceder privilégios
GRANT ALL PRIVILEGES ON DATABASE sistema_ong TO ong_user;
```

### 2.2 Verificar a Conexão

```bash
psql -U postgres -d sistema_ong -c "SELECT version();"
```

## ⚙️ Passo 3: Configurar o Arquivo application.properties

Edite o arquivo `src/main/resources/application.properties`:

```properties
# Altere estas configurações conforme seu ambiente:

spring.datasource.url=jdbc:postgresql://localhost:5432/sistema_ong
spring.datasource.username=postgres
spring.datasource.password=SUA_SENHA_AQUI

# IMPORTANTE: Altere esta chave JWT em produção!
jwt.secret=SUA_CHAVE_SECRETA_SUPER_SEGURA_AQUI

# Configure seu email SMTP
spring.mail.username=seu_email@gmail.com
spring.mail.password=sua_senha_app
```

## 🔨 Passo 4: Compilar o Projeto

```bash
# Limpar e compilar
mvn clean install

# Ou pular os testes
mvn clean install -DskipTests
```

## 🚀 Passo 5: Executar o Sistema

### Opção 1: Com Maven (Desenvolvimento)
```bash
mvn spring-boot:run
```

### Opção 2: Executar o JAR (Produção)
```bash
java -jar target/sistema-gestao-ong-1.0.0.jar
```

O sistema estará disponível em: **http://localhost:8080/api**

## ✅ Passo 6: Verificar se Está Funcionando

### Teste o endpoint de login:

```bash
curl -X POST http://localhost:8080/api/auth/login   -H "Content-Type: application/json"   -d '{
    "email": "admin@ong.org",
    "senha": "admin123"
  }'
```

**Credenciais padrão:**
- **Email:** admin@ong.org
- **Senha:** admin123

**⚠️ IMPORTANTE:** Altere a senha do administrador após o primeiro login!

## 🐳 Instalação com Docker (Alternativa)

Se você tem Docker instalado:

```bash
# Subir todos os serviços (PostgreSQL, Redis e App)
docker-compose up -d

# Ver os logs
docker-compose logs -f app

# Parar os serviços
docker-compose down
```

## 🔧 Solução de Problemas

### Problema: "Connection refused" ao PostgreSQL

**Solução:** Verifique se o PostgreSQL está rodando:
```bash
# Linux/Mac
sudo systemctl status postgresql

# Ou verificar processos
ps aux | grep postgres
```

### Problema: "Port 8080 already in use"

**Solução:** Altere a porta no `application.properties`:
```properties
server.port=8081
```

### Problema: Flyway Migration Failed

**Solução:** Limpe o banco e tente novamente:
```sql
DROP DATABASE sistema_ong;
CREATE DATABASE sistema_ong;
```

## 📊 Endpoints Disponíveis

Após a instalação, você pode acessar:

- **Login:** POST `/api/auth/login`
- **Beneficiárias:** GET `/api/beneficiarias` (requer autenticação)
- **Doações Públicas:** POST `/api/doacoes/public/iniciar`
- **Total de Doações:** GET `/api/doacoes/public/total`

## 📝 Próximos Passos

1. ✅ Alterar senha do administrador
2. ✅ Criar novos usuários
3. ✅ Cadastrar beneficiárias
4. ✅ Configurar email SMTP
5. ✅ Configurar backup do banco de dados
6. ✅ Configurar SSL/HTTPS em produção

## 🆘 Precisa de Ajuda?

- 📧 Email: suporte@suaong.org
- 📖 Documentação: Veja o arquivo README.md
- 🐛 Issues: Abra uma issue no GitHub

---

**Desenvolvido para fazer a diferença! ❤️**
