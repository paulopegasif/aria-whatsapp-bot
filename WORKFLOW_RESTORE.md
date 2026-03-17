# 🔄 Como Restaurar seus Workflows no n8n

Seus workflows foram salvos em arquivos e podem ser restaurados de forma simples.

## 📁 Workflows Disponíveis para Restauração

```
✅ Ar.Ia - Log Interações Bitrix24
   📄 Arquivo: n8n_bitrix_chat_log_workflow.json
   
✅ Ar.Ia - Agendamento Clínica (PowerBot)
   📄 Arquivo: workflows/Ar.Ia - Agendamento Clínica (PowerBot).json
   
✅ ArIA-Agendamento-PowerBot-Adaptado
   📄 Arquivo: workflows/ArIA-Agendamento-PowerBot-Adaptado.json
   
✅ Aula - IA de Agendamento Completo
   📄 Arquivo: workflows/IA de Agendamento Completo (n8n).json
```

## 🚀 Passo 1: Acessar n8n

1. Abra seu navegador e acesse: **http://localhost:55000**
2. Login com credenciais:
   - **Usuário:** admin
   - **Senha:** senha_forte

## 📥 Passo 2: Importar Workflows

### Opção A: Importar via UI (Recomendado)

1. No dashboard do n8n, clique em **"+ New"** no canto superior direito
2. Selecione **"Import from file"** ou **"Import code"**
3. Escolha o arquivo JSON do workflow que deseja restaurar
4. Clique em **"Import"**

### Opção B: Importar via CLI (Se preferir automático)

Execute este comando no seu terminal (na raiz do projeto):

```bash
# Para o workflow Bitrix
curl -X POST "http://localhost:55000/api/v1/workflows" \
  -u "admin:senha_forte" \
  -H "Content-Type: application/json" \
  -d @n8n_bitrix_chat_log_workflow.json
```

## ⚠️ Importante: Credenciais

Após importar cada workflow:

1. Verifique se há **"Missing credentials"** (sinais de aviso vermelhos)
2. Você precisará adicionar credenciais para:
   - Supabase (se usado no workflow Bitrix)
   - Bitrix24 (webhook URLs)
   - OpenAI (se usar IA)

3. Clique nos nós com erro e configure as credenciais necessárias

## 📦 Arquivos de Workflow

Os arquivos estão em:
- `/n8n_bitrix_chat_log_workflow.json` (n8n nativo - chatbot Bitrix)
- `/workflows/` (PowerBot workflows - estruturas de fluxo visual)

## 🔒 Proteção Futura

Para não perder workflows novamente:

1. **Fazer backup regular:**
   ```bash
   # Exportar todos os workflows
   curl -s http://localhost:55000/api/v1/workflows \
     -u "admin:senha_forte" | jq . > workflows_backup_$(date +%Y%m%d).json
   ```

2. **Usar volume persistente:**
   - O arquivo `docker-compose.yml` já tem `n8n_data:/home/node/.n8n`
   - Ele persiste automaticamente
   - Não rodar `docker volume rm aria-whatsapp-bot_n8n_data` sem backup!

---

💡 **Dica:** Se tiver problemas, verifique os logs do n8n:
```bash
docker logs n8n-aria --tail 50
```
