// URLs and base layers: 

// Establishes the URL to get earthquake data from (the last 7 days of earthquakes)
var earthquakeData = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson";

// Establishes the URL to get the tectonic plate data from
var tectonicPlateData = "https://raw.githubusercontent.com/fraxen/tectonicplates/master/GeoJSON/PB2002_boundaries.json";

// Establishes base layers for the map 
var street = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
});

var topo = L.tileLayer('https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png', {
	attribution: 'Map data: &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, <a href="http://viewfinderpanoramas.org">SRTM</a> | Map style: &copy; <a href="https://opentopomap.org">OpenTopoMap</a> (<a href="https://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA</a>)'
});

var stylized_topo = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
	attribution: 'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community'
});

var baseMaps = {
    "Street Map": street,
    "Topographical": topo,
    "Stylized topographical": stylized_topo
};

// Functions:

// Function to determine marker size based on magnitude
function markerSize(magnitude) {
    return (magnitude**2)*7000
}

// Function to determine marker color based on earthquake depth
function markerColor(depth) {
    if (depth < 10) return "#00FF00";
    if (depth < 30) return "#00D977";
    if (depth < 50) return "#8FED2F";
    if (depth < 70) return "#FFD800";
    if (depth < 90) return "#FF6E00";
    return "#FF0000"
}

// Full map creation:

// Perform a GET request to query the first URL
d3.json(earthquakeData).then(function(quakeData){

    // Once the first get request goes through, perform a second get request for techtonic plate data
    d3.json(tectonicPlateData).then(function(plateData){

        // Create a layer with earthquake data:
        // Assign features to a variable
        var quakeFeatures = quakeData.features;

        // Initialize an array to hold earthquake markers
        var quakeMarkers = [];

        // Loop through the earthquake features and assign markers to each feature
        for (let i=0; i<quakeFeatures.length; i++) {
            quakeMarkers.push(
                L.circle([quakeFeatures[i].geometry.coordinates[1], quakeFeatures[i].geometry.coordinates[0]], {
                  stroke: true,
                  fillOpacity: 0.75,
                  color: "black",
                  fillColor: markerColor(quakeFeatures[i].geometry.coordinates[2]),
                  radius: markerSize(quakeFeatures[i].properties.mag),
                  weight: 0.5
                }).bindPopup(`<h4>${quakeFeatures[i].properties.place}</h4><hr><p>Magnitude: ${quakeFeatures[i].properties.mag}</p><p>Depth: ${quakeFeatures[i].geometry.coordinates[2]}</p>`)
              );
        }

        // Create a layer with tectonic plate data:
        // Assign features to a variable
        var plateFeatures = plateData.features;

        // Initialize an array to hold earthquake markers
        var plateMarkers = [];

        // Loop through the plate features and assign markers to each feature
        for (let i=0; i<plateFeatures.length; i++) {
            // Format coordinates:
            // Initialize an array to hold formatted coordinates
            var formattedCoords = [];
            for (let x=0; x<plateFeatures[i].geometry.coordinates.length; x++){
                    formattedCoords.push(
                        plateFeatures[i].geometry.coordinates[x].reverse()
                    )
                };
            plateMarkers.push(
                L.polyline(formattedCoords, {
                    color: "yellow"
                })
              );
        }
        
        // Create two separate layer groups: one for the earthquake markers and another for the plate markers.
        var quakes = L.layerGroup(quakeMarkers);
        var plates = L.layerGroup(plateMarkers);

        // Create an overlay object.
        var overlayMaps = {
            "Earthquakes": quakes,
            "Tectonic Plates": plates
        };

        // Define a map object.
        var myMap = L.map("map", {
            center: [37.5,-62.8],
            zoom: 3,
            layers: [street, quakes, plates]
        });
        
        // Pass our map layers to our layer control.
        // Add the layer control to the map.
        L.control.layers(baseMaps, overlayMaps, {
            collapsed: false
        }).addTo(myMap);

        // Set up the legend.
        var legend = L.control({ position: "bottomright" });
        legend.onAdd = function() {
            var div = L.DomUtil.create("div", "info legend");
            var colors = ["#00FF00", "#00D977","#8FED2F", "#FFD800", "#FF6E00", "#FF0000"]
            var title = "Depth"
            var depths = ["-10-10", "10-30", "30-50", "50-70", "70-90", "90+"]

            var legendHTML = 
                '<div class="container bg-white py-sm-2">' + 
                    `<h5 class="ms-sm-1">${title}</h5>` +
                    `<div class="row row-cols-2 mx-sm-2" style="width: 128px;"><div style="height: 12px; width: 12px; background: ${colors[0]}"></div>` + `<span>${depths[0]}</span></div>` +
                    `<div class="row row-cols-2 mx-sm-2" style="width: 128px;"><div style="height: 12px; width: 12px; background: ${colors[1]}"></div>` + `<span>${depths[1]}</span></div>` +
                    `<div class="row row-cols-2 mx-sm-2" style="width: 128px;"><div style="height: 12px; width: 12px; background: ${colors[2]}"></div>` + `<span>${depths[2]}</span></div>` +
                    `<div class="row row-cols-2 mx-sm-2" style="width: 128px;"><div style="height: 12px; width: 12px; background: ${colors[3]}"></div>` + `<span>${depths[3]}</span></div>` +
                    `<div class="row row-cols-2 mx-sm-2" style="width: 128px;"><div style="height: 12px; width: 12px; background: ${colors[4]}"></div>` + `<span>${depths[4]}</span></div>` +
                    `<div class="row row-cols-2 mx-sm-2" style="width: 128px;"><div style="height: 12px; width: 12px; background: ${colors[5]}"></div>` + `<span>${depths[5]}</span></div>` +
                '</div>'
            
            div.innerHTML = legendHTML;

            return div;
          };
        
          // Adding the legend to the map
          legend.addTo(myMap);
    })
})