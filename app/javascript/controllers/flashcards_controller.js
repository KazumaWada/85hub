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
  const container = document.getElementById("container");
  const flashcardContainer = document.getElementById("flashcardContainer");
  const answerAndJudge = document.getElementById("answerAndJudge");
  answerAndJudge.hidden = true;

  const openAnswerButton = document.getElementById("openAnswerAndJudge");
  openAnswerButton.addEventListener("click",()=>{
   answerAndJudge.hidden = false;
  })

  const correct = document.getElementById("correct")
  const incorrect = document.getElementById("incorrect")

  correct.addEventListener("click", ()=>{
   console.log("pressed correct button!")
   container.remove(flashcardContainer) = true;
  })
  incorrect.addEventListener("click", ()=>{
   console.log("poressed incorrect button!")
   flashcardContainer.remove = true;
  })



 }
 

}

