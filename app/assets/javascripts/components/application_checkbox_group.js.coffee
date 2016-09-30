@ApplicationCheckboxGroup= React.createClass
  getInitialState: ->
    application: @props.application
    field: @props.field
    placeholder: @props.placeholder
    value: @props.application[@props.field] || []
    options: @props.options
    sources: @props.sources || false

  changeValue: (e) ->
    if $(e.target).is(":checked")
      @state.application[@state.field].push(e.target.value)
    else
      index = @state.application[@state.field].indexOf(e.target.value)
      @state.application[@state.field].splice(index,1)
    console.log @state.application[@state.field]

  scrollableList: ->
    if @state.sources
      " sources"

  checkedValue: (value) ->
    @state.application[@state.field].indexOf(value) > -1

  render: ->
    React.DOM.div
      className: 'form-group'
      React.DOM.label null
        @state.placeholder
        React.DOM.div
          className: ""+@scrollableList()
          for option in @state.options
            React.DOM.div
              className: "checkbox"
              key: option.value
              React.DOM.input
                id: option.value
                type: 'checkbox'
                name: @state.field
                value: option.value || []
                defaultChecked: @checkedValue(option.value)
                onChange: @changeValue
              React.DOM.label
                htmlFor: option.value
                option.name
