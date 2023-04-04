# projeto_diario_de_treino

A new Flutter project.

## Getting Started

Seguir o passo-a-passo da documentação abaixo para baixar e configurar o Flutter e o Android Studio.

- https://docs.flutter.dev/get-started/install

Quando terminar de configurar rodar um flutter doctor no terminal pra ver se está tudo ok!

```
$ flutter doctor
```

O único erro/warning que deve aparecer é o referente a não ter um dispositvo emulador conectado.

## Criar um emulador no Android Studio 

- Abrir o android studio
- Criar um novo projeto com o Android Studio (pode ser um projeto vazio)
- Abrir o gerenciador de dispositivos
- Criar um dispositivo (qualquer dispostivo android, vai ser necessário baixar a imagem e outras coisas que vem junto na hora)
- Rodar no terminal o comando flutter emulators --launch com o nome do dispostivo que você criou. Exemplo:

```
$ flutter emulators --launch Nexus 5X API 30
```

- Quando terminar, rodar novamente o comando flutter doctor no terminal (agora não deve ter nenhum erro)

```
$ flutter doctor
```

## Clonar o repositório e rodar o projeto localmente

Você pode só baixar o projeto direto pelo github, mas se tiver o git pode clonar com git clone:

```
$ git clone https://github.com/Bruno-Mafra/projeto-diario-de-treino.git
```

- Abrir o projeto com a IDE que desejar
- Dar play no dispostivo que criou com o Android Studio
- Na raiz do projeto se tudo já estiver configurado adequadamente, só rodar flutter run

```
$ flutter run
```

## Documentação

- [Flutter](https://docs.flutter.dev/)

