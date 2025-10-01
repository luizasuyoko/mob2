# CineFavorite - Formativa
Construir um Aplicativo do Zero - O CineFavorite permitirá criar uma conta e buscar filmes em uma API e montar uma galeria pessoal de filmes favoritos, com posters e notas.

## Objetivos 
- Criar uma galeria personalizada por usuário de filmes favoritos
- Conectar o APP com uma API(base de dados) de filmes
- Permitir a criação de contas para cada usuário 
- Buscar filmes por palavra chave  

## Levantamento de Requisitos do Projeto
- ## Funcionais

- ## Não Funcionais

## Recursos do Projeto
- Fluter/Dart
- Firebase(Authentication/Firestore Database)
- API TMDB
- Figma

## Diagramas 

1. ### Classes 
    Demonstrar o funcionamento das entidades do sistema
    - Usuario(User): classe já modelada pelo FirebaseAuth
        - Email  
        - Password 
        - uid
        - login()
        - logout()
        - create()
    - FilmeFavorito: Classe modelada pelo DEV
        - number:id
        - String:titulo
        - String:poster
        - Double:rating
        - adicionar()
        - remover()
        - listar()
        - updateNota()

```mermaid
classDiagram
    class User{
        +String uid
        +String email
        +String password
        +createUser()
        +login()
        +logout()
    }

    class FavoriteMovie{
        +String id
        +Strinf title
        +String posterPath
        +double rating 
        +addFavorite()
        +removeFavorite()
        +updateFavorite()
        +readList()
    }

    User "1"--"1+" FavoriteMovie : "save"
```

2. ### Uso
    Ações que os atores podem fazer
    - User: 
        - Registrar
        - Login
        - Logout
        - Procurar Filmes API
        - Salvar Filmes Favoritos
        - Dar Nota aos Filmes
        - Remover Favoritos

```mermaid
graph TD
    subgraph "Acoes"
    uc1([Registrar-se])
    uc2([Login])
    uc3([Logout])
    uc4([Search Movie])
    uc5([Favorite Movie])
    uc6([Rating Movie])
    uc7([Remove Favorite Movie])
    end

    user([Usuario])

    user --> uc1
    user --> uc2
    user --> uc3
    user --> uc4
    user --> uc5
    user --> uc6
    user --> uc7

    uc1 --> uc2
    uc2 --> uc3
    uc2 --> uc4
    uc2 --> uc5
    uc2 --> uc6
    uc2 --> uc7
```
3. ### Fluxo 
    Determina o caminho percorrido pelo ator para executar uma ação
    - Ação de Login

```mermaid
graph TD

    A[Início] --> B{Login Usuário}
    B --> C[Inserir Email e Senha]
    C --> D{Validar as Credenciais}
    D --> E[Sim]
    E --> F[Tela de Favoritos]
    D --> G[Não]
    G --> E
```

## Prototipagem 
- ## Figma: https://www.figma.com/design/RaVrlpiggF1y6KsHnla12U/Untitled?t=BT6b5NIQQkaFseV9-1

## Codificação