@ApplicationCheckboxGroup= React.createClass
  changeValue: (e) ->
    options = @props.application[@props.field] || []
    if $(e.target).is(":checked")
      options.push(e.target.value)
    else
      index = options.indexOf(e.target.value)
      options.splice(index,1)
    @props.setApplicationField(@props.field, options)

  scrollableList: ->
    if @props.sources
      " sources"

  checkedValue: (value) ->
    if @props.application[@props.field]
      @props.application[@props.field].indexOf(value) > -1
    else
      false

  render: ->
    React.DOM.div
      className: 'form-group'
      React.DOM.label null
        @props.placeholder
        React.DOM.div
          className: ""+@scrollableList()
          for option in @props.options
            React.DOM.div
              className: "checkbox"
              key: option.value
              React.DOM.input
                id: option.value
                type: 'checkbox'
                name: @props.field
                defaultValue: option.value || []
                defaultChecked: @checkedValue(option.value)
                onChange: @changeValue
              React.DOM.label
                htmlFor: option.value
                option.name
