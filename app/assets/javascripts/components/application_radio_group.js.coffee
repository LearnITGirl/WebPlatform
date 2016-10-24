@ApplicationRadioGroup = React.createClass
  changeValue: (e) ->
    @props.setApplicationField(@props.field, e.target.value)

  checkedValue: (value) ->
    @props.application[@props.field] == value

  render: ->
    React.DOM.div
      className: 'form-group'
      React.DOM.label null
        @props.placeholder
      for option in @props.options
        React.DOM.div
          className: "radio"
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


