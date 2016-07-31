@MenteeApplicationRadioGroup = React.createClass
  getInitialState: ->
    application: @props.application
    field: @props.field
    placeholder: @props.placeholder
    value: @props.application[@props.field]
    options: @props.options

  changeValue: (e) ->
    @state.application[@state.field] = e.target.value
    console.log @state.application

  render: ->
    React.DOM.div
      className: 'form-group'
      React.DOM.label null
        @state.placeholder
      for option in @state.options
        React.DOM.div
          className: "radio"
          key: option
          React.DOM.label null
            React.DOM.input
              type: 'radio'
              name: @state.field
              value: option
              onChange: @changeValue
            option


