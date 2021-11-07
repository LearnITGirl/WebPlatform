@ApplicationLanguageExperience = React.createClass
  experienceLevels: ->
    [
      {name: 'Beginner', value: 'beginner'},
      {name: 'Intermediate', value: 'intermediate'},
      {name: 'Professional', value: 'professional'},
    ]

  changeValue: (e) ->
    options = @props.application[@props.field] || []
    if $(e.target).is(":checked")
      options.push(e.target.value)
    else
      field = e.target.value
      index = options.indexOf(field)
      options.splice(index, 1)
      @removeLevelValue(field)
      @removeDetailValue(field)
    @props.setApplicationField(@props.field, options)

  checkedValue: (value) ->
    if @props.application[@props.field]
      @props.application[@props.field].indexOf(value) > -1
    else
      false

  getLevelField: ->
    @props.application[@props.level_field] || {}

  setLevelValue: (field, value) ->
    level_field = @getLevelField()
    possible_values = names = @experienceLevels().map (experience) -> experience.value
    if possible_values.indexOf(value) > -1
      level_field[field] = value
      @props.setApplicationField(@props.level_field, level_field)
    else
      @removeLevelValue(field)

  removeLevelValue: (field) ->
    level_field = @props.application[@props.level_field] || {}
    delete level_field[field]
    @props.setApplicationField(@props.level_field, level_field)

  getDetailField: ->
    @props.application[@props.detail_field] || {}

  setDetailValue: (field, value) ->
    detail_field = @getDetailField()
    detail_field[field] = value
    @props.setApplicationField(@props.detail_field, detail_field)

  removeDetailValue: (field) ->
    detail_field = @getDetailField()
    delete detail_field[field]
    @props.setApplicationField(@props.detail_field, detail_field)

  renderInfo: (option) ->
    if @props.detail_field && @props.level_field && @props.application[@props.field] && @props.application[@props.field].indexOf(option.value) > -1
      React.DOM.div null,
        React.createElement(ApplicationSelectField,
          key: 'level_' + option.value,
          options: @experienceLevels(),
          field: option.value,
          placeholder: "Select the level of expertise",
          value: @getLevelField()[option.value] || ''
          application: @props.level_field,
          setApplicationField: @setLevelValue),
        React.createElement(ApplicationTextArea,
          key: 'detail_' + option.value,
          field: option.value,
          placeholder: "Tell us about projects that you have worked on. Paste a link to the code if you want/have.",
          value: @getDetailField()[option.value] || ''
          application: @props.detail_field,
          setApplicationField: @setDetailValue)

  render: ->
    React.DOM.div
      className: 'form-group'
      React.DOM.label null
        @props.placeholder
        React.DOM.div
        for option in @props.options
          final_id = option.value
          if (@props.groupId)
            final_id = @props.groupId + '_' + option.value
          React.DOM.div
            key: final_id + "_container",
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
