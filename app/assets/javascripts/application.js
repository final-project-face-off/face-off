// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap
//= require react
//= require react_ujs
//= require components
//= require_tree .
//= require Chart.bundle
//= require highcharts
//= require chartkick
//= require chartkick

function changeLogo1(selTeam) {
  if (!selTeam) {
    document.getElementById('team1').src = "/assets/logo-nhl.png"
  } else {
    document.getElementById('team1').src = "/assets/logo-" + selTeam + ".png"
  }
}

function changeLogo2(selTeam) {
  if (!selTeam) {
    document.getElementById('team2').src = "/assets/logo-nhl.png"
  } else {
    document.getElementById('team2').src = "/assets/logo-" + selTeam + ".png"
  }
}
