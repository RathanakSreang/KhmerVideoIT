$(document).bind 'page:change', ->
  $(ClientSideValidations.selectors.forms).validate()
