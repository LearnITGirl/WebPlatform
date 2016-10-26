@ApplicationTextArea= React.createClass
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
      React.DOM.label null
        @props.label
      React.DOM.textarea
        className: "form-control"+@errorClass()
        defaultValue: @props.application[@props.field]
        onChange: @changeValue
        rows: 5


