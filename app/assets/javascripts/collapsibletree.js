google.load('visualization', '1', {'packages':['corechart','wordtree','table']});
google.setOnLoadCallback(function() {
  drawChart(root, clues_array);
});

function drawChart(root, clues) {
  var data = google.visualization.arrayToDataTable(
    clues
  );



  var options = {
  fontName: 'Oswald',
  fontColor:'#FF0000',
  minFontSize: 24,
    wordtree: {
      format: 'implicit',
      word: root
    }
  };


  var chart = new google.visualization.WordTree(document.getElementById('wordtree_basic'));
  chart.draw(data, options);


}


