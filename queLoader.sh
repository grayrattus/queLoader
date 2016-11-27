#!/bin/bash

displayMenu()
{
  echo "MENU";
  echo "1) Wylosowanie pytania"
  echo "-1) Konczy dzialanie programu"
}
createJson()
{
    json=`cat cppQuestions.txt`;
}
randQuestion()
{
  lengthOfQuestionsArray=$(echo $json | jq '.myQuestions|length');
  rQuestionIndex=$(($RANDOM % $lengthOfQuestionsArray ));
}
randAnswers()
{
  lengthOfAnswersArray=$(echo $json | jq '.myQuestions|length');
  until [[ $rTrueAnswerIndex -ne $rAnswerIndex ]]; do
    rAnswerIndex=$(($RANDOM % $lengthOfAnswersArray ));
    echo $rAnswerIndex a prawdzwy $rTrueAnswerIndex;
  done
}
randPositionOfTrueAnswer()
{
  rTrueAnswerIndex=$(($RANDOM % 2));
}
checkAnswer()
{
    if [[ $key -eq $rTrueAnswerIndex ]]; then
      points=$(expr $points + 1);
      tput setaf 2;
      echo "Dobrze!";
      tput setaf 7;
      echo "Naciśnij enter by kontynuować";
      answered=true;
    elif [[ $key -eq -1 ]]; then
        exit;
    else
      tput setaf 1;
      echo Zle;
      tput setaf 7;
      echo "Naciśnij enter by kontynuować";
      answered=false;
    fi
}
main()
{
  key=1;
  points=0;
  createJson;
  displayMenu;
  until [[ $key -lt 0 ]];
  do
    randQuestion;
    echo Masz $points punktów, Pytanie:
    echo $json | jq ".myQuestions[$rQuestionIndex].question";
    echo "Możliwe odpowiedzi:"
    randPositionOfTrueAnswer;
    for (( i = 0; i < 3; i++ )); do
      if [[ $rTrueAnswerIndex -eq $i ]]; then
        echo -n $i\);
        echo $json | jq ".myQuestions[$rQuestionIndex].answer";
      else
        randAnswers;
        echo -n $i\);
        echo $json | jq ".myQuestions[$rAnswerIndex].answer";
      fi
    done
    read key;
    checkAnswer;
    read key;
  done
}
main;
