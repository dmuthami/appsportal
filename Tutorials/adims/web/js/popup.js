/**
 * Elements that make up the popup.
 */
        var container = document.getElementById('popup');
var content = document.getElementById('popup-content');
var closer = document.getElementById('popup-closer');

/**
 * Create an overlay to anchor the popup to the map.
 */
var overlay = new ol.Overlay(/** @type {olx.OverlayOptions} */({
    element: container,
    autoPan: true,
    autoPanAnimation: {
        duration: 250
    }
}));

/**
 * Add a click handler to hide the popup.
 * @return {boolean} Don't follow the href.
 */
closer.onclick = function () {
    overlay.setPosition(undefined);
    closer.blur();
    return false;
};
infoFormat = 'text/javascript'; //  'text/javascript'

function displayInfoFeatures(evt) {
    var coordinate = evt.coordinate;
    //-----------Trial code goes here---
    var viewResolution = view.getResolution();
    var viewProjection = view.getProjection();

    var url = wmsSource.getGetFeatureInfoUrl(
            evt.coordinate, viewResolution, viewProjection, {
                'INFO_FORMAT': infoFormat,
                'propertyName': 'farmerid,area,countyid,wardid,name,soiltype,lrnumber,topography'
            });
    if (url) {
        //console.log("URL: " + url);
        var parser = new ol.format.GeoJSON();
        $.ajax({
            url: url,
            type: 'POST',
            dataType: 'jsonp',
            jsonpCallback: 'parseResponse'
        }).then(function (response) {
            var result = parser.readFeatures(response);
            //console.log(result);
            if (result.length) {
                var info = [];
                for (var i = 0, ii = result.length; i < ii; ++i) {
                    /***/
                    info.push(result[i].get('farmerid'));
                    info.push(result[i].get('area'));
                    info.push(result[i].get('countyid'));
                    info.push(result[i].get('wardid'));
                    info.push(result[i].get('name'));
                    info.push(result[i].get('soiltype'));
                    info.push(result[i].get('lrnumber'));
                    info.push(result[i].get('topography'));

                }
                //console.log("info arr: " + info);
                //var me = info.join(', ');

                var str = '<b>Name: </b>' + info[4] + '<br>' +
                        '<b>LR Number: </b>' + info[6] + '<br>' +
                        '<b>Area: </b>' + info[1] + '<br>' +
                        '<b>Soil Type: </b>' + info[5] + '<br>' +
                        '<b>Topography: </b>' + info[7] + '<br>';

                //Popup content
                content.innerHTML = str;

                //Call function to display results on the pane
                displayFarmerDetailsonPanel(info[0]);
                //console.log("url: " + url);
            } else {
                var str = "You might have clicked on a basemap. We are not at the moment able to pull attribute data from a basemap layer";
                content.innerHTML = str + '&nbsp;';
            }
        });
        overlay.setPosition(coordinate);
    }
}

function displayFarmerDetailsonPanel(farmerID) {
    $.ajax({
        url: "farmerDetails",
        type: "POST",
        dataType: "json",
        data: {
            farmerID: farmerID
        },
        success: function (responseText, textStatus, jqXHR) {
            formatFarmerDetailsonPanel(responseText);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        },
        close: function (event, ui) {}
    });
}

function formatFarmerDetailsonPanel(responseText) {

    //Creates a div for the table
    addTableDiv();

    var data = JSON.stringify(responseText);
    m_JsonObj = JSON.parse(data);
    //console.log(m_JsonObj);
    var str,str2;
    var idRow = -1;
    $.each(m_JsonObj, function (key, value) {
        //console.log("key"+ value);
        str = "";
        $.each(value, function (k0, valueTime) {
            //get plain text object
            console.log(k0 + " " + valueTime);
            str += "<div  class='col-xs-3'>" + valueTime + "</div>";


        });
        //Results row div
        idRow++;
        str2 = "<div id='id" + idRow + "' class='row'></div>";
        $("#idContainer").append(str2); //Add separator div  

        $("#id"+ idRow).html(str);
    });
    // $('#idPanelBody').append(str);

}

function addTableDiv() {

//Add tabl view div
    /*
     var str = "<div id='tableView' class='row search-results'></div>";
     $("#mainContainer").append(str);//Add the tabe header*/

    //add farmer table div
    str = "<div id='idContainer' class='container'></div>";
    $("#idPanelBody").html(str); //Add the tabe div

    //Results  row header div
    str = "<div id='idResultRowHeader' class='row'></div>";
    $("#idContainer").html(str); //Add separator div  

    //Add column headers
    str = "<div  class='col-xs-3'>ID</div>";

    str += "<div  class='col-xs-3'>Name</div>";

    str += "<div  class='col-xs-3'>Farmer ID</div>";

    str += "<div  class='col-xs-3'>LR Number</div>";
    $("#idResultRowHeader").html(str); //Add the tabe div


}


$(document).ready(function () {
    //Map add overlay
    //map.addOverlay(overlay);

});
