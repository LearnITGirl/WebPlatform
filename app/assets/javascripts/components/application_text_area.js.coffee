@ApplicationTextArea= React.createClass
  changeValue: (e) ->
    @props.setApplicationField(@props.field, e.target.value)

  render: ->
    React.DOM.div
      className: 'form-group'
      React.DOM.label null
        @props.label
      React.DOM.textarea
        className: "form-control"
        defaultValue: @props.value
        onChange: @changeValue


