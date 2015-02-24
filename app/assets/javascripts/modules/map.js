  function initialize() {

  var styles = [
    {

       "featureType": "landscape",
        "stylers": [
            {
                "hue": "#F1FF00"
            },
            {
                "saturation": -27.4
            },
            {
                "lightness": 9.4
            },
            {
                "gamma": 1
            }
        ]
    },
    {
        "featureType": "road.highway",
        "stylers": [
            {
                "hue": "#0099FF"
            },
            {
                "saturation": -20
            },
            {
                "lightness": 36.4
            },
            {
                "gamma": 1
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "stylers": [
            {
                "hue": "#00FF4F"
            },
            {
                "saturation": 0
            },
            {
                "lightness": 0
            },
            {
                "gamma": 1
            }
        ]
    },
    {
        "featureType": "road.local",
        "stylers": [
            {
                "hue": "#FFB300"
            },
            {
                "saturation": -38
            },
            {
                "lightness": 11.2
            },
            {
                "gamma": 1
            }
        ]
    },
    {
        "featureType": "water",
        "stylers": [
            {
                "hue": "#00B6FF"
            },
            {
                "saturation": 4.2
            },
            {
                "lightness": -63.4
            },
            {
                "gamma": 1
            }
        ]
    },
    {
        "featureType": "poi",
        "stylers": [
            {
                "hue": "#9FFF00"
            },
            {
                "saturation": 0
            },
            {
                "lightness": 0
            },
            {
                "gamma": 1
            }
        ]
    }
]

  // Create a new StyledMapType object, passing it the array of styles,
  // as well as the name to be displayed on the map type control.
  var styledMap = new google.maps.StyledMapType(styles,
    {name: "Styled Map"});

  var myLatlng = new google.maps.LatLng(mapcenterlat, mapcenterlong);


  var mapOptions = {
    zoom: my_zoom,
    center: myLatlng,
    mapTypeControlOptions: {
      mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
    }
  }



  if (geoflag == 1){
// Try HTML5 geolocation
  if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = new google.maps.LatLng(position.coords.latitude,
                                       position.coords.longitude);

      var infowindow = new google.maps.InfoWindow({
        map: map,
        position: pos,
        content: 'Current location'
      });

      //map.setCenter(pos);
    }, function() {
      handleNoGeolocation(true);
    });
  } else {
    // Browser doesn't support Geolocation
    handleNoGeolocation(false);
  }

function handleNoGeolocation(errorFlag) {
  if (errorFlag) {
    var content = 'Error: The Geolocation service failed.';
  } else {
    var content = 'Error: Your browser doesn\'t support geolocation.';
  }

  var mapOptions = {
    map: map,
    zoom: 12,
    position: new google.maps.LatLng(mapcenterlat, mapcenterlong),
    content: content
  };

  var infowindow = new google.maps.InfoWindow(mapOptions);
  //map.setCenter(mapOptions.position);
}


}

var map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);

  //var icon = 'search.png';

  map.mapTypes.set('map_style', styledMap);
  map.setMapTypeId('map_style');


  if (flag === 1 || flag === 2) {

   for (var i = 0; i < map_array.length; i++){

      var location = new google.maps.LatLng(map_array[i][0], map_array[i][1]);

      var marker = new google.maps.Marker({
        position: location,
        map: map,
        draggable:true,
        title:"Drag me!"
       // icon: icon

      });


    var j = i + 1;
    var j = 1
    marker.setTitle(j.toString());
    createinfoWindow(marker, content_array[i]);

    }



    function createinfoWindow(marker, contentString){

      var infowindow = new google.maps.InfoWindow({
        content: contentString,
        maxWidth: 200
    });

    google.maps.event.addListener(marker, 'click', function() {
    infowindow.open(map, marker);
    /*$.ajax({
      url: '/locations/' + 'loc_id',
      method: 'get',
      data: {
        latitude: e.latLng.lat(),
        longitude: e.latLng.lng()
      }
    });*/


    });

      google.maps.event.addListener(marker, 'mouseover', function() {
      infowindow.open(map, marker);
      });

  }


    if (flag === 2) {


    var flightPlanCoordinates = [map_array.length];

    var lineSymbol = {
    path: google.maps.SymbolPath.CIRCLE,
    scale: 0,
    strokeColor: '#FFCC00'
    };

    for (var m = 0; m < map_array.length; m++){

       flightPlanCoordinates[m] = new google.maps.LatLng(map_array[m][0], map_array[m][1]);
    }


      var flightPath = new google.maps.Polyline({
          path: flightPlanCoordinates,
          geodesic: true,
          strokeColor: '#FF0000',
          strokeOpacity: 1.0,
          strokeWeight: 2,
          icons: [{
      icon: lineSymbol,
      offset: '100%'
    }]

        });
       flightPath.setMap(map);
    }

    if (map_array.length == 4){
         // animateCircle();
    }


}

 // end else for geolocation

  google.maps.event.addListener(map, 'click', function(e) {

     document.getElementsByClassName("address")[0].value = e.latLng.lat() + ', ' + e.latLng.lng();
     placeMarker(e.latLng, map);
     /*$.ajax({
      url: '/questionsets/' + quiz_id+'/huntsplayedusers',
      method: 'post',
      data: {
        latitude: e.latLng.lat(),
        longitude: e.latLng.lng()
      }
    });*/


  });

  function placeMarker(position, map) {
    var marker = new google.maps.Marker({
      position: position,
      map: map,
      draggable:true,
      title:"Drag me!"
    });

    google.maps.event.addListener(marker, 'drag', function(evt){
      document.getElementsByClassName("address")[0].value = evt.latLng.lat() + ', ' + evt.latLng.lng();
    });

    google.maps.event.addListener(marker, 'dragend', function(evt){
      document.getElementsByClassName("address")[0].value = evt.latLng.lat() + ', ' + evt.latLng.lng();
    });

  }


}

$(document).on('ready', function(){
  google.maps.event.addDomListener(window, 'load', initialize);
});
