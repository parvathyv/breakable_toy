google.load('visualization', '1', {'packages':['corechart','wordtree','table']});
google.setOnLoadCallback(function() {
  drawChart(root, comments_array, colors_array);
});

function drawChart() {
  var data = google.visualization.arrayToDataTable(
    comments
  );

  var data1 = google.visualization.arrayToDataTable(
    colors
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

});
