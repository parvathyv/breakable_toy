
var width = 1024,
    height = 768;

var cluster = d3.layout.cluster()
    .size([height, width - 160]);

var diagonal = d3.svg.diagonal()
    .projection(function(d) { return [d.y, d.x]; });

var svg = d3.select("#collapsibletree").append("svg")
    .attr("width", width)
    .attr("height", height)
    .append("g")
    .attr("transform", "translate(40,0)");

    svg.append("rect")
    .attr("width", "100%")
    .attr("height", "100%")
    .attr("fill", "#071665");

d3.json("/questionsets.json", function(error, root) {
  var nodes = cluster.nodes(root),
      links = cluster.links(nodes);

  var link = svg.selectAll(".link")
      .data(links)
      .enter().append("path")
      .attr("class", "link")
      .attr("d", diagonal);


  var node = svg.selectAll(".node")
      .data(nodes)
      .enter().append("g")
      .attr("class", "node")
      .attr("transform", function(d) { return "translate(" + d.y + "," + d.x + ")"; })
      .attr("fill", "orange")
      .style("font-size","1em");

  node.append("circle")
      .attr("r", 8)


  node.append("text")
      .attr("dx", function(d) { return d.children ? -15 : 15; })
      .attr("dy", 3)
      .style("text-anchor", function(d) { return d.children ? "end" : "start"; })
      .text(function(d) { return d.name; });
});

 //d3.select(self.frameElement).style("height", height + "px");


