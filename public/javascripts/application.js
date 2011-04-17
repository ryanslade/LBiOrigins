// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var latlng = new google.maps.LatLng(51.5001524, -0.1262362);

var myOptions = {
  zoom: 3,
  center: latlng,
  mapTypeId: google.maps.MapTypeId.TERRAIN
};

var map = new google.maps.Map(document.getElementById("map_canvas"),
    myOptions);

var panels = [];

function parseJson()
{
    $.ajax({
        url: '/people.json',
        dataType: 'json',
        success: function(data) 
		{
            processMarkers(data);
        }, 
        error: function (data)
		{
        }
    });
}

function placeMarker(row) 
{	
	var person = row.person
	
	var latitude = person.latitude,
		longitude = person.longitude,
		lbiMarker = 'images/media/redMarker.png',
		nonLbiMarker = 'images/media/purpleMarker.png',
	
		first_name = person.first_name,
		last_name = person.last_name,
		combinedName = person.first_name+' '+person.last_name,

		labelClass = 'infoLabel',
		textClass = 'infoText',
		
		p = function (text, className) {
			return '<p class="'+className+'">'+text+'</p>';
		},
		
		thisMarker = new google.maps.Marker({
			position: new google.maps.LatLng(latitude, longitude),
			map: map,
			icon: lbiMarker
		}),
		
		infoWindow = new google.maps.InfoWindow({
			content: 
				p('Name', labelClass) + p(combinedName, textClass) + 
				p('Birth place', labelClass) +
				p(person.home_town+', '+person.home_country, textClass)
		});
		
	panels.push(infoWindow);
	google.maps.event.addListener(thisMarker, 'click', function(){
		for (var i=0, len=panels.length; i<len; i+=1) {
			panels[i].close(map);
		}
		infoWindow.open(map, this);
	});
}

function processMarkers(data)
{
    var totalMarkers = data.length, i;
    for(i=0;i<totalMarkers;i+=1)
	{
		placeMarker(data[i]);
	}
}

function submitForm(){
	$.ajax({
		type: 'POST',
        url: 'register.php',
		data: {
			first_name: $('#first_name').val(),
			last_name: $('#last_name').val(),
			birthTown: $('#birthTown').val(),
			birthCountry: $('#birthCountry').val(),
			interests: $('#interests').val(),
			email: $('#email').val(),
			company: $('#company').val(),
			workedLBi: $('.workedLBi').val()
		},
		dataType: 'json',
        success: function(data, b, c) {
			
			processMarkers(data);
			
			// hide the form
			$('#form').css({
				'display' : 'none'
			});
        }, 
        error: function (data) {
        }
    });
}
	
		 
$('#dataInput').submit(function(){
	submitForm();
	return false;
});

// form showing and hiding
 $('#addOrigin').click(function(){
	$('#form').css({
		'display' : 'block'
	});
});
 
 $('#screen').click(function(){
	$('#form').css({
		'display' : 'none'
	});
 });
 
$('#close').click(function(){
	$('#form').css({
		'display' : 'none'
	});
});

parseJson();
