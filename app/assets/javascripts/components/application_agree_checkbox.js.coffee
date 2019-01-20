@ApplicationAgreeCheckbox= React.createClass
  changeValue: (e) ->
    @props.setApplicationField(@props.field, $(e.target).is(":checked"))

  checkedValue: (value) ->
    @props.application[@props.field] == value

  errorClass: ->
    if @props.application.errors && @props.application.errors.keys.indexOf(@props.field) > -1
      ' error'
    else
      ''

  render: ->
    console.log(@props.value)
    React.DOM.div
      className: 'form-group'
      React.DOM.label null
        @props.placeholder
        if (@props.link)
          React.DOM.a
            href: @props.link.href
            target: "_blank"
            style: {"marginLeft": "5px"}
            @props.link.text
        React.DOM.div
          className: "checkbox"+@errorClass()
          key: @props.value
          React.DOM.input
            id: @props.value
            type: 'checkbox'
            name: @props.field
            defaultValue: true
            defaultChecked: @props.checked
            onChange: @changeValue
          React.DOM.label
            htmlFor: @props.value
            @props.name
