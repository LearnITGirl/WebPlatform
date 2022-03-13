@ApplicationSelectField= React.createClass
  changeValue: (e) ->
    @props.setApplicationField(@props.field, e.target.value)

  checkedValue: (value) ->
    @props.application[@props.field] == value

  errorClass: ->
    if @props.application.errors && @props.application.errors.keys.indexOf(@props.field) > -1
      ' error'
    else
      ''

  render: ->
    React.DOM.div
      className: 'form-group'
      if (@props.label)
        React.DOM.label
          className: 'bottom-space'
          @props.label
      React.DOM.select
        className: 'form-control'+@errorClass()
        defaultValue: @props.application[@props.field] || ''
        onChange: @changeValue
        React.DOM.option
          defaultValue: ''
          @props.placeholder
        for option in @props.options
          React.DOM.option
            key: option.value
            value: option.value
            option.name

