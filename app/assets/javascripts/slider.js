$(document).ready(function() { 
   
$('#slideshow > div:gt(0)').hide();
setInterval(function() { 
  $('#slideshow > div:first')
    .fadeOut(1000)
    .next()
    .fadeIn(1000)
    .end()
    .appendTo('#slideshow');
},  2000);



$('.clue1.small.button').click(function(){
    $('#clue1').toggle("slow");
});

$('.clue2.small.button').click(function(){
    $('#clue2').toggle("slow");
});

$('.clue3.small.button').click(function(){
    $('#clue3').toggle("slow");
});



});