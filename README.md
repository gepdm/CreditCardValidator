Neste tutorial, você aprenderá como fazer facilmente a validação da bandeira do número do cartão de crédito, para seu aplicativo flutter.

As próximas seções mostram como desenvolver uma validação simples que exibe a bandeira do cartão ao usuário.

---

### Instalação do Dart e Flutter

Para começar, caso não tenha o Dart e o Flutter instalados, siga as instruções na documentação para prosseguir.

---

### Visão geral

Uma funcionalidade mais comum nos sistemas de pagamentos é a identificação e validação do cartão de crédito ou débito. Para fazer isso, existem alguns algoritmos que facilitam a identificação do cartão e validação.

O algoritmo que iremos utilizar neste tutorial, é o algoritmo de **lush**.

---

### Vamos começar

Vamos iniciar, abra o seu terminal e crie um novo projeto com o _Flutter command-line tool_, substitua "my_app" por qualquer nome que queira dar ao aplicativo:

```shell
$ flutter create my_app
```

Entre no diretório e abra-o com o seu editor de código ou IDE preferido, nesse caso, utilizaremos o [Visual Studio Code](https://code.visualstudio.com/).

```shell
$ cd my_app
$ code .
```

Nossa estrutura final ficará desta forma. Se você começou criando o projeto, não terá o diretório `pages` e os arquivos abaixo dele.

```markdown
.
├── android/
├── build/
├── ios/
├── lib/
│ ├── pages/
│ │ └── card_page.dart
│ └── main.dart
├── test/
├── web/
├── .gitignore
├── .metadata
├── .packages
├── my_app.iml
├── README.md
└── pubspec.yaml
```

No diretório `lib`, vamos até `main.dart`, em seguida delete o código desnecessário e deixe apenas a função `main` e a classe `MyApp`.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
        title: Text("CardValidator"),
        ),
      ),
    );
  }
}
```

Agora, crie um diretório `pages` dentro do diretório `lib` e adicione um novo arquivo com o nome `card_page.dart`. Feito isso, agora, importe a biblioteca de Widgets do `material` e crie um Widget de estado para que o componente `_CardPageState` possa guardar informações.

```dart
import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {

  }
}
```

Em seguida, vamos adicionar um formulário (`Form`), uma estrutural básica de layout do material (`Scaffold`), vamos adicionar o widget `SafeArea` para evitar transbordamento do layout para outras partes do sistema operacional e uma _Scroll View_ para rolar a tela.

```dart
class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(

          ),
        ),
      ),
    );
  }
}
```

Volte para a classe main importe o arquivo `card_page.dart` e troque a home do `MaterialApp` para a classe `CardPage`.

```dart
class MyApp extends StatelessWidget {
  /* ... */
  return MaterialApp(
        title: 'CardValidator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CardPage(),
      );
  /* ... */.
}
```

Continuando com o `CardPage`, adicione um preenchimento (`Padding`) para cima, vamos centralizar com o widget (`Center`) e colocar uma caixa com um tamanho especificado (`SizedBox`) e, por último, vamos adicionar uma coluna (`Column`):

```dart
class _CardPageState extends State<CardPage> {
/* ... */
  child: SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.only(top: 50),
      child: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center

          ),
        ),
      ),
    ),
  ),
/* ... */
}
```

O widget `Column` aceita um array de widgets, iremos adicionar como primeiro widget do array o widget `AspectRatio` e uma pilha de outros filhos como segundo filho do `Container`, o qual irá criar nosso card.

```dart
/* ... */
child: Column(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.center
  children: [
    AspectRatio(
     aspectRatio: 1.586,
     child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 8,
            blurRadius: 100
          )
        ],
      ),
      child: Stack(
        children: [

         ],
       ),
     ),
   ),
 ],
),
/* ... */
```

Como filhos do widget `Stack`, adicionaremos dois widgets `Positioned`, para indicar onde eles serão posicionados dentro da pilha.

```dart
/* ... */
child: Stack(
  children: [
    Positioned(
      top: 90,
      left: 20,
      child: Text(
        "XXXX XXXX XXXX XXXX",
        style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600
        ),
      ),
    ),
    Positioned(
      top: 20,
      right: 20,
      child: Text("Bandeira"),
    )
  ],
),
/* ... */
```

Agora, vamos criar o input de texto, instale as dependências que iremos utilizar e importe no arquivo `card_page.dart`.

Instale com o terminal, a dependência de máscara para o número do cartão.

```shell
flutter pub add easy_mask
```

Importe no arquivo `card_page.dart`

```dart
import 'package:flutter/services.dart';
import 'package:easy_mask/easy_mask.dart';
/* ... */
```

O segundo filho do widget `Column`, será o input, vamos adicionar um padding do cartão e formatar o tamanho do input e label.

```dart
/* ... */
child: Column(
  children: [
    AspectRatio(/* ... */),
    Padding(
    padding: EdgeInsets.only(top: 40),
    child: TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        TextInputMask(mask: '9999 9999 9999 9999')
      ],
      onChanged: (_) {
        setState(() {});
      },
      obscureText: false,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 1
          )
        ),
        labelText: 'Número',
        hintText: 'XXXX XXXX XXXX XXXX',
        errorStyle: TextStyle(
          color: Colors.green
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 1
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF646464),
            width: 1
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF646464),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 15
        ),
      ),
    ),
  ),
)
/* ... */
```

Por último, vamos criar o botão de validação. Por enquanto ele não irá fazer nada, dado que nenhum evento foi acionado. Em seguida iremos criar as funções que serão disparadas ao evento de toque.

```dart
/* ... */
child: Column(
  children: [
    AspectRatio(/* ... */),
    Padding(/* ... */),
    Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue[900],
              minimumSize: Size(120, 40),
            ),
            onPressed: () {},
            child: Text(
              'Validar',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    ),
  ],
),
/* ... */
```

### Algoritmo de Luhn

O algoritmo Luhn é utilizado para validar uma variedade de números de identificação, como números de cartão de crédito que são aplicados a sites de comércio eletrônico, por exemplo. O número de cartão parece ser aleatório, mas cada parte tem um significado, eles são dívidos em grupos responsavéis por indentificar dados importantes do emissor, da indústria e da conta.

<img src="https://i.imgur.com/oOaWg9X.png" width="300px" />

Os grupos são:

1. Identificador principal da indústria (MII - Major Industry Identifier)
2. Número de identificação do emissor (IIN - Issuer Identification Number)
3. Número da conta
4. Soma de verificação

Logo, o algoritmo de Luhn determina a validade de um número de cartão utilizando o número da conta e a soma de verificação. Os números sequenciais de posição par devem ser multiplicados por dois; caso o resultado dessa multiplicação seja maior que 9, devemos somar os dígitos (16 => 1+6=7), posteriormente somar todos os valores. Assim, a soma com o resto da divisão sendo igual a zero, o número do cartão será válido e, caso contrário, será inválido.

<img src="https://camo.githubusercontent.com/a2f75e73d94d0c9c7475296b056bdf3219e13a52cd99368c67cdbcccc3af4573/68747470733a2f2f7777772e313031636f6d707574696e672e6e65742f77702f77702d636f6e74656e742f75706c6f6164732f4c75686e2d416c676f726974686d2e706e67" width="400px">

Fonte: [Laboratoria](https://github.com/Laboratoria/SAP004-card-validator#5-criterios-de-aceptacao-m%C3%ADnimos-do-projeto)

Implementação do Algoritmo de Luhn

Bom, sabendo da teoria vamos ao código. Acima da classe `CardPage`, crie uma função que recebe como parâmetro o número do cartão e retorna um resultado booleano (true/false).

```dart
bool isCardValid(String cardNumber) {
  int sum = 0;
  if (cardNumber != null && cardNumber.length >= 13) {
    List<String> card = cardNumber.replaceAll(new RegExp(r"\s+"), "").split("");
    int i = 0;
    card.reversed.forEach((num) {
      int digit = int.parse(num);
      i.isEven
          ? sum += digit
          : digit >= 5
              ? sum += (digit * 2) - 9
              : sum += digit * 2;
      i++;
    });
  }
  return sum % 10 == 0 && sum != 0;
}
```

Agora, precisamos criar os estados (states) para guardar os dados de input e validação. O `TextEditingController`vai notificar seus ouvintes para que possam ler o valor do texto toda vez que for editado. Vamos criar uma key para o formulário, um widget de bandeira para ser trocado após a validação do número e, por último, um booleano para identificar se o número é válido ou não que começa como `false`.

Crie um método `initState` para executar sempre que montar em tela a aplicação e atríbua ao `textController` o `TextEditingController`

```dart
class _CardPageState extends State<CardPage> {
  TextEditingController textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Widget bandeira = Container();
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  Widget build(BuildContext context) { /* ... */ }
```

Para colocar a bandeira do emissor, precisamos das imagens. Dessa forma, é necessário que você tenha as imagens em um diretório local e importe pelo `path` relativo. Também, é preciso adicionar ao arquivo `pubspec.yaml` o path relativo das imagens na lista `assest`.

```yaml
flutter:
  assets:
    - lib/assets/images/amex.png
    - lib/assets/images/mastercard.png
    - lib/assets/images/visa.png
```

Vamos criar a função que valida o emissor do cartão e nos retorne um Widget. Vamos criar uma função assíncrona `checkCardBanner` que recebe o número do cartão e retorna um Widget, vamos validar com regex correspondente ao padrão que o emissor utiliza em seus cartões.

```dart
Future<Widget> checkCardBanner(String card) async {
  card = card.replaceAll(new RegExp(r"\s+"), "");
  if (RegExp(r'^4\d{12}(\d{3})?$').hasMatch(card))
    return Image.asset('lib/assets/images/visa.png', height: 30);
  if (RegExp(r'^5[1-5]\d{14}$').hasMatch(card))
    return Image.asset('lib/assets/images/mastercard.png', height: 50);
  if (RegExp(r'^3[47]\d{13}$').hasMatch(card))
    return Image.asset('lib/assets/images/amex.png', height: 60);
  return Container();
}
```

Feito isso, vamos alterar algumas coisas para que os elementos mudem conforme os dados são modificados. Primeiro, adicione ao widget Form da classe `_CardPageState` a key.

```dart
/* ... */
    return Form(
      key: _formKey,
      /* ... */
    )
/* ... */
```

No input (`TextFormField`) atribua a propriedade `controller` o controlador de texto.

```dart
/* ... */
TextFormField(
  controller: textController,
  /* ... */
)
/* ... */
```

No `onChanged` do botão, a cada moficação será disparado um evento que irá setar um novo estado, vamos verficar a bandeira passando o texto como argumento e na resposta da função assíncrona, atribuir a variável `bandeira` a imagem correspondente ao emissor.

```dart
/* ... */
onChanged: (_) {
  setState(() {
    checkCardBanner(textController.text).then(
        (image) => bandeira = image);
  });
/* ... */
```

No card, podemos mostrar o número do cartão conforme é alterado ou o padrão de formatação.

```dart
/* ... */
Positioned(
  top: 90,
  left: 20,
  child: Text(
    textController.text.isNotEmpty ?
    textController.text :
    'XXXX XXXX XXXX XXXX',
    style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600),
  ),
),
/* ... */
```

Em seguida, para a bandeira do emissor aparecer, vá até o widget da bandeira e adicione como `child` a variável `bandeira`.

```dart
/* ... */
Positioned(
  top: 20,
  right: 20,
  child: bandeira,
)
/* ... */
```

O input também aceita um validator, aqui vamos validar o número de cartão chamando a função do algoritmo de Luhn e passar o valor do input, como resultado vamos obter um booleano. Adicione esse trecho de código antes ou após a função `onChanged` do widget de input.

```dart
/* ... */
validator: (value) {
  isValid = isCardValid(value);
  return isValid
  ? 'Cartão válido'
  : 'Cartão inválido';
},
/* ... */
```

Para dar feedback ao usuário sobre a validade ou não do input, precisamos verificar se o formulário foi preenchido, podemos fazer isso adicionando um `setState` ao `onPressed` do botão. A partir da `key` do `Form`, conseguimos acessar os estados criados automaticamente pelo ` FormState` no montar o formulário e, assim, validar cada campo do formulário.

```dart
onPressed: () {
  setState(() =>
    _formKey.currentState.validate()
  );
},
```

Ainda no input, vamos adicionar uma funcionalidade de limpar o input e algumas customizações. Quando o input não estiver vazio, vamos adicionar um icone para limpar o campo de texto.

```dart
/* ... */
Padding(
  child: TextFormField(
    decoration: InputDecoration(
      suffixIcon:
        textController.text.isNotEmpty
        ? InkWell(
          onTap: () => setState(() => textController.clear()),
          child: Icon(
            Icons.clear,
            color: Color(0xFF757575),
            size: 22,
          ),
        )
        : null,
    )
  ),
),
/* ... */
```

Por fim, vamos trocar as cores das bordas do input para quando o número for válido ou inválido

```dart
/* ... */
focusedErrorBorder: OutlineInputBorder(
  borderSide: BorderSide(
    color: isValid ? Colors.green : Colors.red,
  )
)
/* ... */
```

Também, vamos alterar a cor na borda de erro.

```dart
/* ... */
decoration: InputDecoration(
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: isValid ? Colors.green : Colors.red,
    ),
  ),
),
/* ... */
```

Por último altere e estilo de texto da label.

```dart
/* ... */
decoration: InputDecoration(
  errorStyle: TextStyle(
    color: isValid ? Colors.green : Colors.red,
  ),
),
/* ... */
```

---

### Referências

[Hussein, Khalid Waleed, et al. Enhance Luhn Algorithm for Validation of Credit Cards Numbers. 2013.](https://academic.microsoft.com/paper/2280797598/citedby/search?q=Enhance%20luhn%20algorithm%20for%20validation%20of%20credit%20cards%20numbers.&qe=RId%253D2280797598&f=&orderBy=0)
