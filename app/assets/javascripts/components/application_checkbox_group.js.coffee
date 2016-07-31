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
              React.DOM.label null
                React.DOM.input
                  type: 'checkbox'
                  name: @state.field
                  value: option.value || []
                  onChange: @changeValue
                option.name
