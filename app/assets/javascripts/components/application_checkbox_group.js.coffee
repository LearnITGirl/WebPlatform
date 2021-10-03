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

  setHintValue: (field, value) ->
    hint_field = @props.application[@props.hint_field] || {}
    hint_field[field] = value
    @props.setApplicationField(@props.hint_field, hint_field)

  renderInfo: (option) ->
    if @props.hint_field && @props.application[@props.field].indexOf(option.value) > -1
      React.DOM.div null,
        React.createElement(ApplicationTextArea, field: option.value, placeholder: "Tell us about projects that you have worked on. Paste a link to the code if you want/have.", application: @props.hint_field, setApplicationField: @setHintValue)

  render: ->
    React.DOM.div
      className: 'form-group'
      React.DOM.label null
        @props.placeholder
        React.DOM.div
          className: ""+@scrollableList()
          for option in @props.options
            final_id = option.value
            if (@props.groupId)
              final_id = @props.groupId + '_' + option.value
            React.DOM.div
              className: "checkbox"
              key: option.value
              React.DOM.input
                id: final_id
                type: 'checkbox'
                name: @props.field
                defaultValue: option.value || []
                defaultChecked: @checkedValue(option.value)
                onChange: @changeValue
                className: "styled"
              React.DOM.label
                htmlFor: final_id
                option.name
              @renderInfo(option)
