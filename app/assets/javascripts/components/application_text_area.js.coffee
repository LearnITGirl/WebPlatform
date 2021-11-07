@ApplicationTextArea= React.createClass
  changeValue: (e) ->
    @props.setApplicationField(@props.field, e.target.value)

  errorClass: ->
    if @props.application.errors && @props.application.errors.keys.indexOf(@props.field) > -1
      ' error'
    else
      ''
  renderLabel: (option) ->
    if @props.label
      React.DOM.label null,
        @props.label

  render: ->
    React.DOM.div
      className: 'form-group'
      @renderLabel()
      React.DOM.textarea
        className: "form-control"+@errorClass()
        defaultValue: @props.value || @props.application[@props.field]
        onChange: @changeValue
        placeholder: @props.placeholder
        rows: 5


