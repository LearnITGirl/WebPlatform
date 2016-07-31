@MenteeApplicationStep4 = React.createClass
  getInitialState: ->
    application: @props.application
    time_availabilities: @props.time_availabilities
    engagements: @props.engagements
    sources: @props.sources
    step: 4

  render: ->
    React.DOM.div
      className: 'fields'
      if @state.application.errors
        React.DOM.div
          className: "alert alert-danger text-center"
          @application.errors.full_messages.join(", ")
      React.createElement(ApplicationRadioGroup, key: 'time_availability', field: 'time_availability', options: @state.time_availabilities, placeholder: "How much time can you dedicate to learning through the program?", application: @state.application)
      React.createElement(ApplicationCheckboxGroup, key: 'engagements', field: 'engagements', options: @state.engagements, placeholder: "Do you have any other engagements during the 3-month program period? Check all that apply", application: @state.application)
      React.createElement(ApplicationCheckboxGroup, key: 'sources', field: 'sources', options: @state.sources, sources: true, placeholder: "Where did you find out about the program?", application: @state.application)
