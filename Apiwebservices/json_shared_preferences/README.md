# json_shared_preferences

A new Flutter project.

Shared Preferences (Armazenamento Interno do Aplicativo)

Armazenamento Chave -> Valor
            "config" -> "Texto" texto em formato Json

O que é um Txto em formato Json -> 
[
    config:{
        "NomedoUsuario": "nome do usuário",
        "IdadedoUsuario": 25,
        "TemaEscuro": true,
    }
]

dary -> Linguagem de Programação do Flutter não lê JSON
    -> converter => (json.decode => converte texto json em Map:dart)
                 => (json.decode => convert Map:Dart em Text:Json)