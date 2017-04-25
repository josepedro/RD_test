// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
function getCookie(name) {
  var value = "; " + document.cookie;
  var parts = value.split("; " + name + "=");
  if (parts.length == 2) return parts.pop().split(";").shift();
}

function sendDataToRDStationApp(e_mail_serialized) {
    var valuesToSubmit = e_mail_serialized + '&contact%5Btoken%5D=' + getCookie("XSRF-TOKEN")
                          + '&contact%5Bpage_views%5D=' + getCookie("page-views");
    //console.log(valuesToSubmit);
    //console.log(getCookie("XSRF-TOKEN"));
    alert ("Contact saved.");
    $.ajax({
        type: "POST",
        //url: $(this).attr('action'), //sumbits it to the given url of the form
        url: "http://localhost:3001/contacts.json",
        data: valuesToSubmit,
        dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
    });
    return false; // prevents normal behaviour
}

function deleteAllCookies() {
 var c = document.cookie.split("; ");
 for (i in c)
  document.cookie =/^[^=]+/.exec(c[i])[0]+"=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
}
//deleteAllCookies();

console.log("Eae galera");

var page_view = window.location.href;
var currentdate = new Date();
var datetime = currentdate.getDate() + "/"
                + (currentdate.getMonth()+1)  + "/"
                + currentdate.getFullYear() + "@"
                + currentdate.getHours() + ":"
                + currentdate.getMinutes() + ":"
                + currentdate.getSeconds();
var page_view_information = page_view + "@" + datetime;
document.cookie = "page-views="+page_view_information;
console.log(getCookie("page-views"));
