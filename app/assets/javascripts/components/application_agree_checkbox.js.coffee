@ApplicationAgreeCheckbox= React.createClass
  changeValue: (e) ->
    if $(e.target).is(":checked")
      @props.setApplicationField(@props.field, true)
    else
      @props.setApplicationField(@props.field, false)

  checkedValue: (value) ->
    @props.application[@props.field] == value

  render: ->
    React.DOM.div
      className: 'form-group'
      React.DOM.label null
        @props.placeholder
        React.DOM.div
          className: "checkbox"
          key: @props.value
          React.DOM.input
            id: @props.value
            type: 'checkbox'
            name: @props.field
            defaultValue: true
            defaultChecked: true
            onChange: @changeValue
          React.DOM.label
            htmlFor: @props.value
            @props.name
