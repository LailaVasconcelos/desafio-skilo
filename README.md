# desafio-skilo

## Tarefas

* OK - Instalar extensões no vs code
* OK - Adicionar editorconfig
* OK - Criar docker-compose com o banco e o pgadmin
* OK - Definir o schema da api
* Ok - Criar o projeto phoenix e fazer merge do readme
* OK - Adicionar o doctor e credo 
* OK - Adicionar o CI (semaphore)
* OK - Adicionar e configurar absinthe
* Definir o schema do banco de dados

## Detalhes do desafio

### Desafio: GraphBanking

Este é um desafio para testar seus conhecimentos em Elixir e GraphQL.

### Obrigatório

O projeto deve ser desenvolvido em Elixir usando o Phoenix Framework.

### GraphBanking

Seu objetivo é criar um API GraphQL que permita a abertura de uma conta bancária e a transferência de ativos entre elas.

A API deve permitir:

- Abrir uma conta bancária com saldo inicial;
- Transferir ativos da "conta A" para "conta B";
- Obter as informações de uma conta, incluindo suas movimentações;

Critérios de aceitação:

- Durante a abertura da conta o saldo inicial deve ser informado;
- Não pode aceitar saldo negativo;
- Deve exibir um erro se a conta A não possuir saldo para transferência;
- Todos os campos devem ser obrigatórios;
- Não pode transferir dinheiro pra conta de origem;

Chamadas GraphQL

Query

```
account(uuid: <account_uuid>) {
  uuid
  currentBalance
  transactions {
    uuid
    address
    amount
    when
  }
}
```

Mutations

Abertura da conta

```
openAccount(balance: 100) {
  uuid
  currentBalance
}
```

Transferência entre contas

```
transferMoney(sender: <account_uuid>, address: <account_uuid>, amount: 45.5) {
  uuid
  address
  amount
  when
}
```

### Diferenciais

- Arquitetura baseada em eventos
- Utilizar alguma ferramenta de CI
- Seguir algum Elixir Style Guide
- Documentação no código
- Testes Unitários

---

## Esquema do banco

- Tabela da conta corrente: CONTA
  - uuid: UUID
  - current_balance: BigInt
- Tabela de transações: TRANSACAO
  - uuid: UUID
  - conta_uuid: UUID
  - address: UUID
  - amount: BigInt
  - when: DateTime

## Como usar

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
