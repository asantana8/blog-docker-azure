# Blog Docker Azure

Este projeto é um blog simples estático, desenvolvido em HTML, CSS e JavaScript, que pode ser executado em um container Docker usando Nginx e publicado no Azure Container Registry e Azure Container Apps.

## Estrutura do Projeto

```
blog-docker-azure/
│
├── blog/
│   └── html/
│       ├── create-post.html
│       ├── index.html
│       └── post_detail.html
├── dockerfile
├── .gitignore
├── LICENSE
└── README.md
```

- **blog/html/**: Contém os arquivos HTML do blog.
- **dockerfile**: Dockerfile para criar a imagem do container usando Nginx.
- **LICENSE**: Licença MIT.
- **.gitignore**: Arquivos e pastas ignorados pelo Git.

## Como Executar Localmente com Docker

1. **Build da imagem Docker:**
   ```sh
   docker build -t blog-adriano-app:latest .
   ```

2. **Executar o container:**
   ```sh
   docker run -d -p 8080:80 blog-adriano-app:latest
   ```
   Acesse o blog em [http://localhost:8080](http://localhost:8080).

## Publicando no Azure

### 1. Login no Azure e no Azure Container Registry (ACR)

```sh
az login
az acr login --name <NOME_DO_SEU_ACR>
```

### 2. Tag e Push da Imagem para o ACR

```sh
docker tag blog-adriano-app:latest <NOME_DO_SEU_ACR>.azurecr.io/blog-adriano-app:latest
docker push <NOME_DO_SEU_ACR>.azurecr.io/blog-adriano-app:latest
```

### 3. Criar Ambiente e Container App no Azure

```sh
az containerapp env create \
  --name <NOME_DO_AMBIENTE> \
  --resource-group <NOME_DO_RESOURCE_GROUP> \
  --location <LOCALIZACAO>
```

```sh
az containerapp create \
  --name <NOME_DO_CONTAINER_APP> \
  --resource-group <NOME_DO_RESOURCE_GROUP> \
  --environment <NOME_DO_AMBIENTE> \
  --image <NOME_DO_SEU_ACR>.azurecr.io/blog-adriano-app:latest \
  --cpu 0.5 \
  --memory 1.0Gi \
  --ingress external \
  --registry-server <NOME_DO_SEU_ACR>.azurecr.io \
  --registry-username <USUARIO_ACR> \
  --registry-password <SENHA_ACR> \
  --target-port 80
```

> **Dica:** Consulte as combinações válidas de CPU e memória na [documentação oficial](https://learn.microsoft.com/azure/container-apps/).

## Observações & Comentarios

- O blog utiliza apenas armazenamento local do navegador (localStorage) para salvar posts e comentários.
- O Dockerfile expõe a porta 80.
- O projeto está licenciado sob a Licença MIT.
- Todos os objetos azures estao visiveis e funcionais no meu portal.azure

---
Desenvolvido por Adriano Cunha de Santana.