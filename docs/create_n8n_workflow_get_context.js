const fs = require('fs');

const workflow = {
    "name": "Ar.Ia - Get Patient Context (Redis)",
    "nodes": [
        {
            "parameters": {
                "httpMethod": "POST",
                "path": "get_patient_context",
                "responseMode": "responseNode",
                "options": {}
            },
            "id": "webhook-get-context",
            "name": "Webhook Recebe Telefone",
            "type": "n8n-nodes-base.webhook",
            "typeVersion": 2,
            "position": [0, 0]
        },
        {
            "parameters": {
                "jsCode": "const Redis = require('ioredis');\nconst client = new Redis({ host: 'redis-aria', port: 6379 });\n\nconst body = $('Webhook Recebe Telefone').first().json.body || {};\nconst telefone = body.telefone || '';\n\nif (!telefone) {\n  await client.quit();\n  return [{ json: { nome: '', data_nascimento: '', perfil: '', historico: '' } }];\n}\n\n// Busca o ultimo log desse telefone (que contem os dados mais recentes do usuario)\nconst ultimoEventoData = await client.hget('ultimo:' + telefone, 'agendamento') \n  || await client.hget('ultimo:' + telefone, 'cancelamento')\n  || await client.hget('ultimo:' + telefone, 'duvidas')\n  || await client.lindex('log:' + telefone, 0);\n\nawait client.quit();\n\nif (ultimoEventoData) {\n  try {\n    const parsed = JSON.parse(ultimoEventoData);\n    return [{\n      json: {\n        nome: parsed.nome_completo || '',\n        data_nascimento: parsed.data_nascimento || '', // Vindo de logs futuros se adicionado\n        perfil: parsed.perfil || '', // Vindo de logs futuros se adicionado\n        historico: parsed.tipo_tratamento ? `Último tratamento: ${parsed.tipo_tratamento}` : ''\n      }\n    }];\n  } catch(e) {}\n}\n\n// Fallback: Retorna chaves vazias se nao encontrar paciente\nreturn [{ json: { nome: '', data_nascimento: '', perfil: '', historico: '' } }];"
            },
            "id": "code-redis-get",
            "name": "Busca no Redis",
            "type": "n8n-nodes-base.code",
            "typeVersion": 2,
            "position": [220, 0]
        },
        {
            "parameters": {
                "respondWith": "json",
                "responseBody": "={{ JSON.stringify($json) }}",
                "options": {}
            },
            "id": "respond-to-webhook",
            "name": "Respond to Webhook",
            "type": "n8n-nodes-base.respondToWebhook",
            "typeVersion": 1.1,
            "position": [440, 0]
        }
    ],
    "connections": {
        "Webhook Recebe Telefone": {
            "main": [[{ "node": "Busca no Redis", "type": "main", "index": 0 }]]
        },
        "Busca no Redis": {
            "main": [[{ "node": "Respond to Webhook", "type": "main", "index": 0 }]]
        }
    },
    "active": true,
    "settings": {
        "executionOrder": "v1"
    }
};

fs.writeFileSync('/tmp/aria_get_context_workflow.json', JSON.stringify(workflow, null, 2));
console.log('JSON saved to /tmp/aria_get_context_workflow.json');
