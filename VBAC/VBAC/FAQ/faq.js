$(document).ready(function(){
var current = 0;
$("li.question_title:first").css("background-color", "#68B9D0");
$("div.question_block:first").slideDown();
  $("li.question_title").click(function(){
	if($(this).index() != current){
		$("li.question_title").css("background-color", "#8BB0BE");
		$("div.question_block").slideUp(250);
		current = $(this).index();
		$(this).css("background-color", "#68B9D0");
		$(this).next().slideDown(250);	
		}
	else{
			$("li.question_title").css("background-color", "#8BB0BE");
			$("div.question_block").slideUp(250);
			current = -1;
		}
  });
});