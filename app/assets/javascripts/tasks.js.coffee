jQuery ->

  $("input.time").inputmask()

  $('.input-append.form-datepicker').datepicker(
    keyboardNavigation: false,
    format: "dd.mm.yyyy",
    autoclose: true,
    weekStart: 1
  )
