function getCookie(name) {
  var value = "; " + document.cookie;
  var parts = value.split("; " + name + "=");
  if (parts.length == 2) return parts.pop().split(";").shift();
}

function updateDataInRDStationApp(){
  var valuesToSubmit = '&contact%5Bclient_id%5D=' + getCookie("client-id")
                        + '&contact%5Bpage_views%5D=' + getCookie("page-views");
  $.ajax({
      type: "POST",
      url: "http://localhost:3001/update_outside", //local
      //url: "https://sleepy-beach-18308.herokuapp.com/update_outside", //remote
      data: valuesToSubmit,
      dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
  });
  return false; // prevents normal behaviour
}

function sendDataToRDStationApp(e_mail_serialized) {
    createIdClient();
    var valuesToSubmit = e_mail_serialized +
                        '&contact%5Bclient_id%5D=' + getCookie("client-id") +
                        '&contact%5Bpage_views%5D=' + getCookie("page-views");
    alert ("Contact saved.");
    $.ajax({
        type: "POST",
        url: "http://localhost:3001/contacts.json", //local
        //url: "https://sleepy-beach-18308.herokuapp.com/contacts.json", //remote
        data: valuesToSubmit,
        dataType: "JSON"
    });
    return false;
}

function deleteAllCookies() {
 var c = document.cookie.split("; ");
 for (i in c)
  document.cookie =/^[^=]+/.exec(c[i])[0]+"=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
}

function getPageInformations(){
  checkClientId();
  var page_view = window.location.pathname;
  var currentdate = new Date();
  var datetime = currentdate.getDate() + "/"
                  + (currentdate.getMonth()+1)  + "/"
                  + currentdate.getFullYear() + "@"
                  + currentdate.getHours() + ":"
                  + currentdate.getMinutes() + ":"
                  + currentdate.getSeconds();
  var page_view_information = page_view + "@" + datetime;
  var page_views_informations = getCookie("page-views") + "@@"
                                + page_view_information;
  document.cookie = "page-views="+page_views_informations;
}

function checkClientId(){
  if (typeof getCookie("client-id") === 'undefined') {
    createIdClient();
  }
}

function createIdClient(){
  var currentdate = new Date();
  var client_id = currentdate.getDate() + ""
                  + (currentdate.getMonth()+1) + ""
                  + currentdate.getFullYear() + ""
                  + currentdate.getHours() + ""
                  + currentdate.getMinutes() + ""
                  + currentdate.getSeconds() + ""
                  + currentdate.getMilliseconds();
  document.cookie = "client-id=" + client_id;
}
