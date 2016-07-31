@MenteeApplicationInputField = React.createClass
  getInitialState: ->
    application: @props.application
    field: @props.field
    value: @props.application[@props.field]
    placeholder: @props.placeholder

  changeValue: (e) ->
    @state.application[@state.field] = e.target.value
    console.log @state.application

  render: ->
    React.DOM.div
      className: 'form-group'
      React.DOM.input
        className: "form-control text-center"
        placeholder: @state.placeholder
        value: @state.value
        onChange: @changeValue


