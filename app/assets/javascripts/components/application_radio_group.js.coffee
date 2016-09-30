@ApplicationRadioGroup = React.createClass
  getInitialState: ->
    application: @props.application
    field: @props.field
    placeholder: @props.placeholder
    value: @props.application[@props.field]
    options: @props.options

  changeValue: (e) ->
    @state.application[@state.field] = e.target.value
    console.log @state.application

  checkedValue: (value) ->
    @state.application[@state.field] == value

  render: ->
    React.DOM.div
      className: 'form-group'
      React.DOM.label null
        @state.placeholder
      for option in @state.options
        React.DOM.div
          className: "radio"
          key: option.value
          React.DOM.input
            id: option.value
            type: 'radio'
            name: @state.field
            value: option.value
            defaultChecked: @checkedValue(option.value)
            onChange: @changeValue
          React.DOM.label
            htmlFor: option.value
            option.name


