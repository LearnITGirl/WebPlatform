@ApplicationTextField = React.createClass
  changeValue: (e) ->
    @props.setApplicationField(@props.field, e.target.value)

  errorClass: ->
    if @props.application.errors && @props.application.errors.keys.indexOf(@props.field) > -1
      ' error'
    else
      ''
  render: ->
    React.DOM.div
      className: 'form-group'
      React.DOM.input
        className: "form-control text-center"+@errorClass()
        placeholder: @props.placeholder
        defaultValue: @props.application[@props.field]
        onChange: @changeValue
