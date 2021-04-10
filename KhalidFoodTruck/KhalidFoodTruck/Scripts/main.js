var uri = 'api/foodTruck';

//var uriLocation = 'api/foodTruckLocation';

$(document).ready(function () {
    GetServerData();
});

//$(document).ready(function () {
//    GetServerDataLocation();
//});

function GetServerData() {
    // Send an AJAX request
    $.get(uri)
        .done(function (data) {
            $('#foodTrucks').empty();
            console.log(data);
            // On success, 'data' contains a list of notes.
            $.each(data, function (key, item) {
                // Add a list item for the note.
                $('<li>', { text: formatItem(item) }).appendTo($('#foodTrucks'));
            });
        });
}

function formatItem(item) {
    //: {$id: "1", NoteID: 1, Description: "Must Do ASAP", Content: "Get this working"}length: 1__proto__: Array(0)
    //return item.NoteID + " : " + item.Description + ': ' + item.Content;
    return item.FoodTruckID + " : " + item.FoodTruckName + ': ' + item.FoodTruckPlateNumber;
}


//function GetServerDataLocation() {
//    // Send an AJAX request
//    $.get(uri2)
//        .done(function (data) {
//            $('#foodTruckLocations').empty();
//            console.log(data);
//            // On success, 'data' contains a list of notes.
//            $.each(data, function (key, item) {
//                // Add a list item for the note.
//                $('<li>', { text: formatItemLocation(item) }).appendTo($('#foodTruckLocations'));
//            });
//        });
//}

//function formatItemLocation(item) {
//    //: {$id: "1", NoteID: 1, Description: "Must Do ASAP", Content: "Get this working"}length: 1__proto__: Array(0)
//    //return item.NoteID + " : " + item.Description + ': ' + item.Content;
//    return item.FoodTruckID + " : " + item.FoodTruckLocationDay /*+ ': ' + item.FoodTruckPlateNumber*/;
//}

function find() {
    var id = $('#foodTruckId').val();
    $.getJSON(uri + '/' + id)
        .done(function (data) {
            $('#foodTruck').text(formatItem(data));
        })
        .fail(function (jqXHR, textStatus, err) {
            $('#foodTruck').text('Error: ' + err);
        });
}

//function findLocation() {
//    var id = $('#locationId').val();
//    $.getJSON(uri + '/' + id)
//        .done(function (data) {
//            $('#location').text(formatItem(data));
//        })
//        .fail(function (jqXHR, textStatus, err) {
//            $('#location').text('Error: ' + err);
//        });
//}

function deleteItem() {
    var id = $('#deleteId').val();
    $.ajax({
        url: uri + '/' + id,
        type: 'DELETE',
        contentType: "application/json",
        success: function (response) {
            //alert("Note successfully deleted in cloud");
            $('#deleteId').val("");
            GetServerData();
        },
        error: function (response) {
            alert("Food Truck NOT deleted in cloud");
        }
    })
};

function addItem() {
    var foodTypeID = parseInt($('#select-foodType').val());
    var truckName = $('#truckName').val();
    var plateNumber = $('#plateNumber').val();

    var foodTruckLocationDay = $('#TruckLocationDay').val();
    //var foodTypeID = $('#foodTypeID').val();
    //var id = Math.random().toString(16).slice(5)  // tiny chance could get duplicates!
    //SQL will make up the ID
    var newFoodTruck = { FoodTruckID: 0, FoodTypeID: foodTypeID, FoodTruckName: truckName, FoodTruckPlateNumber: plateNumber };
    console.log(newFoodTruck);

    $.ajax({
        url: uri,
        type: "POST",
        dataType: "json",
        contentType: 'application/json',
        data: JSON.stringify(newFoodTruck),
        success: function (response) {
            alert("New Food Truck successfully added to cloud");
            GetServerData();
        },
        error: function (response) {
            alert("Food Truck NOT added in cloud");
        }
    });
}

function findModify() {
    var id = $('#modFoodTruckId').val();
    $.getJSON(uri + '/' + id)
        .done(function (data) {
            $('#modSelect-foodType').val(-1);
            $('#modPlateNumber').val(data.FoodTruckPlateNumber);
            $('#modTruckName').val(data.FoodTruckName);

        })
        .fail(function (jqXHR, textStatus, err) {
            $('#foodTruck').text('Error: ' + err);
        });
}

function modify() {
    // counting on this to still be valid!
    var id = $('#modFoodTruckId').val();
    var foodTypeID = parseInt($('#modSelect-foodType').val());
    var modPlateNumber = $('#modPlateNumber').val();
    var modTruckName = $('#modTruckName').val();

    var modFoodTruck = { FoodTruckID: id, FoodTypeID: foodTypeID, FoodTruckName: modTruckName, FoodTruckPlateNumber: modPlateNumber };
    console.log(modFoodTruck);

    $.ajax({
        url: uri + '/' + id,
        type: "PUT",
        dataType: "json",
        contentType: 'application/json',
        data: JSON.stringify(modFoodTruck),
        success: function (response) {
            console.log(response);
            alert("Food Truck successfully Saved");
            GetServerData();
        },
        error: function (response) {
            alert("Food Truck NOT saved");
        }
    })
};