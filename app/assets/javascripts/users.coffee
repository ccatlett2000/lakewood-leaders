# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
redirect = () ->
  window.location.replace '/'

String::capitalizeFirstLetter = () ->
  return this.charAt(0).toUpperCase() + this.slice(1);

$(document).on 'turbolinks:load', ->
  $('[name="user[rank]"]').change ->
    $(this).parent().submit()
  $('#user_search').change ->
    text = $(this).val()
    re =  RegExp(text ,"i");
    $(".user_name").filter ->
      if re.test($(this).html())
        $(this).parent().fadeIn("fast")
      else
        $(this).parent().fadeOut("fast")
    console.log($(".user_name:not(:contains(#{text}))"))
  $('form[data-remote]').on 'ajax:send', ->
    $(this).children('fieldset').attr 'class', 'form-group'
    $(this).children('.form-group').children('.error-label').remove()
  $('form[data-remote]').on 'ajax:success', ->
    $(this).children('fieldset').addClass 'form-group has-success'
    if $(this).hasClass('edit_user')
      setTimeout (window.location.href = window.location.href), 2000
    else
      setTimeout redirect, 2000
  $('form[data-remote]').on 'ajax:error', (evt, xhr, status, error) ->
    errors = xhr.responseJSON.error
    console.log(errors)
    grecaptcha.reset()
    for form of errors
      fieldSet = $(this).find("#user_#{form}").parent()
      fieldSet.addClass 'has-danger'
      for key of errors[form]
        error = form.capitalizeFirstLetter().replace(/_/g, ' ') + ' ' + errors[form][key]
        fieldSet.append("<div class='error-label'><small class=\"text-danger\">#{error}</small></div>")
