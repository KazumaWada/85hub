import { Controller } from "@hotwired/stimulus"

//id:オリジナルのみ。(仕様上だからいけるけれども、、)class: 複数でもいける
//classの最初の要素を取得する方法がある。↓
//document.queryselector('class名)
//全て取得してその中から選択することもできる
//elements = document.querySelectorAll(~)->elements[0]

//一つは選択できる。だから消えてはいく。
//しかし、最初から全てのカードを閉じていたい場合、どうやって

//まずidではなく、classにしてqueryselectにしたらどうなっていくのかみてみる。
//あ、そっかブラウザでは消えているけど、js上では消えていないんだ。
//hiddenではなく、本当に消せばいいんじゃない?

////////////////////////続き///////////////////////////
//javascript DOMで検索してアルゴリズムを考える。

export default class extends Controller{
 connect(){
  //そもそもrailsが出力したhtml要素にjavascriptで実装していくということだから、
  //すでにrails側で要素を5回loopしたやつはブラウザ上に5個表示されている。
  //それに対してjavascriptでDOMを操作していくということ。
  //だから、すでに5つある要素に対して実行していく。
  //だから、containerを基準にする必要がある。

///////////////////////////////////////////////////////////////
//コメントはzenn用に残しておく。

///////////////////////////////////////////////////////////////
  //0.Rails側で、HTML要素がすでにループされているものがフロントに届く。
  //1.まず0をフロント側でも全てloopさせて、配列に記録しておく。
  //2.今度はそのメモリ(配列)から色々と実行していく。loopなり配列なり。
//////////////////////////////////////////////////////////////

 //  1.まず0をフロント側でも全てloopさせて、配列(というかNodeList)に記録しておく。
  const flashcardContainers = document.querySelectorAll(".flashcardContainer");
  const opens = document.querySelectorAll(".open");  //配列ではなく、単一で返してきている。
  const answers = document.querySelectorAll(".answer");  //5*5になってしまっているけど、querySelectorで取得した5つはそれぞれまとまっていないから配列にしても何故かloopが一回しかできない。最初に取得された要素のみ。
  const judges = document.querySelectorAll(".judge");
  console.log(opens)
  const congratulation = document.getElementById("congratulationsCard");

  congratulation.hidden = true;

  let flashcardContainersHashmap = {};//全体
  let answersHashmap = {};//答え
  let judgesHashmap = {};//まるばつ

  //コンテナの全体
  flashcardContainers.forEach((flashcardContainer, index) =>{
   flashcardContainer.hidden = false;
   flashcardContainersHashmap[index] = flashcardContainer
  })
  //答えを全て隠しておく。ついでに各要素ごとにindexを記録
  answers.forEach((answer, index) =>{
   answer.hidden = true;
   answersHashmap[index] = answer
  })
  //判定を隠しておく。ついでに各要素ごとにindexを記録
  judges.forEach((judge, index) =>{
   judge.hidden = true;
   judgesHashmap[index] = judge
  })


 //openがクリックされたら、その同じ要素内(つまり同じindex内)にあるanswerとjudgeの要素を
 //取得したいので、上記で登録しておいた{要素:index}をここで使う。
  opens.forEach((open, index) => {
   open.addEventListener('click', () => {
     //このopenのindexに対応するanswerJudgeの要素をhidden=falseにする。
     answersHashmap[index].hidden = false
     judgesHashmap[index].hidden = false
   });
 });

 let count = 0;
 //マルバツを押したら、containerが消える。
 judges.forEach((judge, index) => {
  judge.addEventListener('click', () => {
    flashcardContainersHashmap[index].hidden = true;
    count++;
    //フラッシュカード.lengthになった == 全部消えている
    if(count == flashcardContainers.length)congratulationsCard();
  });
});

///////////////////////////////////////////////////////////
//こっからは、アニメーションの世界に入るから、zennは区切れる。
///////////////////////////////////////////////////////////////
//"無くなったら"をどうやって判断するのか。
//全てhidden=trueになっていたら
//hashmapで追跡して、indeOfで一気に探して判定する。
//hiddenされる度に、countしていって、containerの大きさと同じになったら、//これ！

//そのアクションが起こったら、どうしたいのか.
//アニメーション(わー+userページに戻るorもう一度やる)//これをunlimitedにできるのがプレミア。一日1回が無料ユーザー。

//アニメーションにしたい。何を参考にする?->progateとか?
//progateみたいに、どこからでもいいからニョキっとcardを出す。
//https://dubdesign.net/javascript/animationend-anime/

/////////これでいく。方法01.
//hidden trueの個数と、containerの個数が一致したら、
//新たな要素がinnerHTMLを使って作成される。
//カードを表示させる。「もう一度やる」をクリックしたら、リロードしてデータを反映させて、もう一度表示させる。
//↓
//5回一致したら、まずは簡単な文字列をブラウザに表示させてみる。

function congratulationsCard(){
  console.log("yay!");
  congratulation.hidden = false;
}
 }
 

 //

}

