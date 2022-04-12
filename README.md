## Challenge AutoSeg
### TaskManager App
Considere o app deste projeto já estruturado, onde nele conseguimos cadastrar tarefas do dia-a-dia a serem realizadas, junto com uma descrição, colocar comentários e algumas outras features :) 
  Então... considere a atual estrutura de model já existente:
                ____________
               | User       |
        _____* | - email    |
       /       | - password |
      /        |____________|
     /
    *
 _______________              __________
| Tasks         |            | Comments |
| - title       |1 -------- *| - body   |
| - description |            | - status |
| - status      |            | - score  |
| - priority    |            | - like   |             
| - share       |            |__________|
|_______________|
### Instruções para o challenge
0 - Versão do Ruby
`ruby 2.7.1`
1 - Clone o projeto
```console
$ git clone git@github.com:autoseg/mini-app.git
```
2 - Build o projeto e roda os seeds
```console
$ bundle install
$ bundle exec rails db:create db:migrate db:seeds
$ yarn install --check-files
$ rails s
```
3 - Ao acessar a aplicação, crie uma conta. 
### Tarefa 1
1 - Logo na sequência que criou a conta no passo anterior, será necessário criar um perfil.
Porém há um bug nesta feature, a atividade da tarefa 1 é tentar identificá-lo e corrigir.
### Tarefa 2
2 - Para esta tarefa é necessário a execução do seeds antes, certifique-se que você populou o banco de dados.
2.1 - Esta atividade é para ser criado um relatório de todas as Tarefas, onde listaremos algo semelhante ao exemplo abaixo:
___________________________________ 
| Tasks (ID) | Comments | Status   |
| 1          | Aaaaaa   | complete |
| 2          | Bbbbbb   | complete |
|__________________________________|
2.2 - Para isto, crie:
 - Uma controller;
 - Uma rota;
 - Uma view;
2.3 - Exiba um relatório das Tasks completas do User, e liste todos os comentários em ordem alfabética conforme o exemplo acima.
2.4 - Crie um spec de integração para o relatório.
### Tarefa 3
3 - Crie um CRUD de tarefas em tasks/new
3.1 - Temos o arquivo deste spec vazio, escreva o(s) spec(s) de integração.
3.2 - Crie um spec unitário.
### Boa sorte
Caso tenha dúvidas, por gentileza entre em contato com a Equipe AutoSeg :)
### Observações
- Não é necessário realizar o deploy do projeto no Heroku.
- Crie um projeto em seu Github e suba o projeto lá após a finalização.
- Não dê um fork / suba um PR em nosso repositório.

