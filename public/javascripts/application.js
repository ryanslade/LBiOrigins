var latlng = new google.maps.LatLng(30, 0);

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
        url: '/map/people.json',
        dataType: 'json',
        success: function(data)
        {
            processMarkers(data);
        },
        error: function(data) 
        {
        }
    });
}

function placeMarker(person)
 {
    var latitude = person.latitude,
    longitude = person.longitude,

    first_name = person.first_name,
    last_name = person.last_name,
    combinedName = person.first_name + ' ' + person.last_name,

    labelClass = 'infoLabel',
    textClass = 'infoText',
    redMarker = '/images/redMarker.png',
    blueMarker = '/images/blueMarker.png',

    p = function(text, className) {
        return '<p class="' + className + '">' + text + '</p>';
    },

    thisMarker = new google.maps.Marker(
    {
        position: new google.maps.LatLng(latitude, longitude),
        map: map,
        animation: google.maps.Animation.DROP,
        icon: person.alumni ? blueMarker : redMarker 
    }),

    infoWindow = new google.maps.InfoWindow({
        content:
        p('Name', labelClass) + p(combinedName, textClass) +
        p('Birth place', labelClass) +
        p(person.home_town + ', ' + person.home_country, textClass) +
        p('Department', labelClass) +
        p(person.department.name, textClass)
    });

    panels.push(infoWindow);
    google.maps.event.addListener(thisMarker, 'click',
    function() {
        for (var i = 0, len = panels.length; i < len; i += 1) {
            panels[i].close(map);
        }
        infoWindow.open(map, this);
    });
}

function processMarkers(data)
 {
    var totalMarkers = data.length,
    i;
    for (i = 0; i < totalMarkers; i += 1)
    {
        placeMarker(data[i].person);
    }
}

// form showing and hiding
$('#addOrigin').click(function() {
    $('#form').css({
        'display': 'block'
    });
});

$('#screen').click(function() {
    $('#form').css({
        'display': 'none'
    });
});

$('#close').click(function() {
    $('#form').css({
        'display': 'none'
    });
});

$('#new_user').bind('ajax:success',
function() {
    alert("Success!");
});

function bindFormEvents()
 {
    // Example to show how to bind to ajax events
    // Not currently used
    $('#new_person')
    .live("ajax:success",
    function(evt, xhr, settings)
    {
        $('#form').css({
            'display': 'none'
        });
    });
}

$(document).ready(function() {
    parseJson();
})

