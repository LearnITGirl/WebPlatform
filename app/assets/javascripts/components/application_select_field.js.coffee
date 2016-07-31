@ApplicationSelectField= React.createClass
  getInitialState: ->
    application: @props.application
    field: @props.field
    placeholder: @props.placeholder
    label: @props.label
    value: @props.application[@props.field]
    options: @props.options

  changeValue: (e) ->
    @state.application[@state.field] = e.target.value

  render: ->
    React.DOM.div
      className: 'form-group'
      React.DOM.label
        className: 'bottom-space'
        @state.label
      React.DOM.select
        className: 'form-control'
        value: @state.value
        onChange: @changeValue
        React.DOM.option
          defaultValue: ''
          @state.placeholder
        for option in @state.options
          React.DOM.option
            key: option.value
            value: option.value
            option.name


