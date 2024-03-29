// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

'jQuery' in window && (function($) {
    function equalHeight(group) {
        tallest = 0;
        group.each(function() {
            thisHeight = $(this).height();
            if(thisHeight > tallest){
                tallest = thisHeight;
            }
        });
        group.height(tallest);
    }

    $(document).ready(function() {
        if ($(window).width() > 992 ){
            console.log($(window).width());
            equalHeight($("div.left-container,div.right-container"));
        }
    });
})(jQuery);

var my_google_map;
var my_google_geo;

function googlemap_init( id_name, addr_name ) {
    var latlng = new google.maps.LatLng(41, 133);
    var opts = {
        zoom: 15,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        center: latlng
    };
    my_google_map = new google.maps.Map(document.getElementById(id_name), opts);

    my_google_geo = new google.maps.Geocoder();
    var req = {
        address: addr_name ,
    };
    my_google_geo.geocode(req, geoResultCallback);
}


function geoResultCallback(result, status) {
    if (status != google.maps.GeocoderStatus.OK) {
        alert(status);
        return;
    }
    var latlng = result[0].geometry.location;
    my_google_map.setCenter(latlng);
    var marker = new google.maps.Marker({position:latlng, map:my_google_map, title:latlng.toString(), draggable:true});
    google.maps.event.addListener(marker, 'dragend', function(event){
        marker.setTitle(event.latLng.toString());
    });
}
