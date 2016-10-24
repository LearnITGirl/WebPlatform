@ApplicationSelectField= React.createClass
  changeValue: (e) ->
    @props.setApplicationField(@props.field, e.target.value)

  checkedValue: (value) ->
    @props.application[@props.field] == value

  render: ->
    React.DOM.div
      className: 'form-group'
      React.DOM.label
        className: 'bottom-space'
        @props.label
      React.DOM.select
        className: 'form-control'
        defaultValue: @props.value || ''
        onChange: @changeValue
        React.DOM.option
          defaultValue: ''
          @props.placeholder
        for option in @props.options
          React.DOM.option
            key: option.value
            value: option.value
            option.name

