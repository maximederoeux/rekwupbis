// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-datepicker
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .


// $.fn.datepicker.dates['en'] = {
//     days: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
//     daysShort: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
//     daysMin: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"],
//     months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
//     monthsShort: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
//     today: "Today",
//     clear: "Clear",
//     format: "mm/dd/yyyy",
//     titleFormat: "MM yyyy", /* Leverages same syntax as 'format' */
//     weekStart: 0
// };



$(document).ready(function(){
	$('.datepicker').datepicker({
		format: 'dd/mm/yyyy'

	});
});

