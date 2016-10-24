@ApplicationTextField = React.createClass
  changeValue: (e) ->
    @props.setApplicationField(@props.field, e.target.value)

  render: ->
    React.DOM.div
      className: 'form-group'
      React.DOM.input
        className: "form-control text-center"
        placeholder: @props.placeholder
        defaultValue: @props.application[@props.field]
        onChange: @changeValue


