@MenteeApplication = React.createClass
  getInitialState: ->
    application: @props.mentee_application
    countries: @props.countries
    timezones: @props.timezones
    programming_languages: @props.programming_languages
    time_availabilities: @props.time_availabilities
    engagements: @props.engagements
    sources: @props.sources
    step: 1

  nextStep: ->
    step = @state.step
    @setState step: step + 1

  previousStep: ->
    step = @state.step
    @setState step: step - 1

  sendApplication: ->
    @setState uploading: true

    $.ajax
      method: 'POST'
      url: "/api/mentee_applications"
      data:
        application: @state.application
      success : (data) =>
        @state.lol = 'asd'

  setApplicationField: (field, value) ->
    application = @state.application
    application[field] = value
    @setState application: application

  render: ->
    React.DOM.div
      className: 'steps'
      if @state.step == 1
        React.DOM.div
          className: 'step_1'
          React.createElement MenteeApplicationStep1, key: 'step_1', application: @state.application, countries: @state.countries, timezones: @state.timezones, setApplicationField: @setApplicationField
      else if @state.step == 2
        React.DOM.div
          className: 'step_2'
          React.createElement MenteeApplicationStep2, key: 'step_2', application: @state.application, setApplicationField: @setApplicationField
      else if @state.step == 3
        React.DOM.div
          className: 'step_3'
          React.createElement MenteeApplicationStep3, key: 'step_3', programming_languages: @state.programming_languages, time_availabilities: @state.time_availabilities, engagements: @state.engagements, sources: @state.sources, application: @state.application, setApplicationField: @setApplicationField

      React.createElement(ApplicationStepButtons, key: 'step_buttons', previousStep: @previousStep, nextStep: @nextStep, step: @state.step, sendApplication: @sendApplication)
