function getWeekNumber(d) {
    // Copy date so don't modify original
    d = new Date(d);
    d.setHours(0,0,0);
    // Set to nearest Thursday: current date + 4 - current day number
    // Make Sunday's day number 7
    d.setDate(d.getDate() + 4 - (d.getDay()||7));
    // Get first day of year
    var yearStart = new Date(d.getFullYear(),0,1);
    // Calculate full weeks to nearest Thursday
    var weekNo = Math.ceil(( ( (d - yearStart) / 86400000) + 1)/7)
    // Return array of year and week number
    return [d.getFullYear(), weekNo];
}

$(function() {

  $('#calendar_button_daily').datepicker({
    keyboardNavigation: false,
    forceParse: false,
    autoclose: true,
    weekStart: 1
  }).on('changeDate', function(e){
        var path = "/reporting/daily/" + String(e.date.getFullYear()) + "/" + String(e.date.getMonth()+1) + "/" + String(e.date.getDate());
        Turbolinks.visit(path);
    });

    $('#calendar_button_weekly').datepicker({
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    weekStart: 1
  }).on('changeDate', function(e){
        var weekNumberAndYear = getWeekNumber(e.date);
        var path = "/reporting/weekly/" + String(weekNumberAndYear[0]) + "/" + String(weekNumberAndYear[1]);
        Turbolinks.visit(path);
    });

  $('#calendar_button_monthly').datepicker({
    keyboardNavigation: false,
    forceParse: false,
    minViewMode: 1,
    autoclose: true,
    weekStart: 1
  }).on('changeDate', function(e){
        var path = "/reporting/monthly/" + String(e.date.getFullYear()) + "/" + String(e.date.getMonth()+1);
        Turbolinks.visit(path);
    });

    $('#calendar_input_from').datepicker({
    keyboardNavigation: false,
    forceParse: true,
    format: "dd.mm.yyyy",
    autoclose: true,
    todayBtn: "linked",
    weekStart: 1
  }).on('changeDate', function(e){
        var date_to = moment($('#calendar_input_to > input').val(), 'DD.MM.YYYY');
        var path = "/reporting/custom/from/" + String(e.date.getFullYear()) + "/" + String(e.date.getMonth()+1) + "/" + String(e.date.getDate());
        path += "/to/" + String(date_to._a[0]) + "/" + String(date_to._a[1]+1) + "/" + String(date_to._a[2]);
        Turbolinks.visit(path);
    });

  $('#calendar_input_to').datepicker({
    keyboardNavigation: false,
    forceParse: true,
    format: "dd.mm.yyyy",
    autoclose: true,
    todayBtn: "linked",
    weekStart: 1
  }).on('changeDate', function(e){
        var date_from = moment($('#calendar_input_from > input').val(), 'DD.MM.YYYY');
        var path = "/reporting/custom/from/" + String(date_from._a[0]) + "/" + String(date_from._a[1]+1) + "/" + String(date_from._a[2]);
        path += "/to/" + String(e.date.getFullYear()) + "/" + String(e.date.getMonth()+1) + "/" + String(e.date.getDate());
        Turbolinks.visit(path);
    });

});
