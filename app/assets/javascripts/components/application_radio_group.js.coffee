@ApplicationRadioGroup = React.createClass
  changeValue: (e) ->
    @props.setApplicationField(@props.field, e.target.value)

  errorClass: ->
    if @props.application.errors && @props.application.errors.keys.indexOf(@props.field) > -1
      ' error'
    else
      ''
  checkedValue: (value) ->
    @props.application[@props.field] == value

  render: ->
    options = @props.options
    React.DOM.div
      className: 'form-group'
      React.DOM.label null
        @props.placeholder
      for option in options
        React.DOM.div
          className: "radio"+@errorClass()
          key: option.value
          React.DOM.input
            id: option.value
            type: 'radio'
            name: @props.field
            defaultValue: option.value
            defaultChecked: @checkedValue(option.value)
            onChange: @changeValue
          React.DOM.label
            htmlFor: option.value
            option.name


