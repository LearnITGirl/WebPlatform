@ApplicationTextArea= React.createClass
  getInitialState: ->
    application: @props.application
    field: @props.field
    value: @props.application[@props.field]
    label: @props.label

  changeValue: (e) ->
    @state.application[@state.field] = e.target.value

  render: ->
    React.DOM.div
      className: 'form-group'
      React.DOM.label null
        @state.label
      React.DOM.textarea
        className: "form-control"
        value: @state.value
        onChange: @changeValue


