@MenteeApplication = React.createClass
  getInitialState: ->
    application: @props.mentee_application
    countries: @props.countries
    timezones: @props.timezones
    step: 1

  render: ->
    console.log @state.timezones
    if @state.step == 1
      React.DOM.div
        className: 'step_1'
        React.createElement MenteeApplicationStep1, key: 'step_1', step: @state.step, application: @state.application, countries: @state.countries, timezones: @state.timezones
    else if @state.step == 2
      className: 'step_2'

    else if @state.step == 3
      className: 'step_3'

    else if @state.step == 4
      className: 'step_4'
