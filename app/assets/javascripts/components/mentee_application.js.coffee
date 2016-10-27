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
    steps: 3

  nextStep: ->
    step = @state.step
    @setState step: step + 1

  previousStep: ->
    step = @state.step
    @setState step: step - 1

  showErrors: ->
    if @state.application.errors
      React.DOM.div
        className: "alert alert-danger text-center"
        for error, index in @state.application.errors.messages
          React.DOM.div
            key: "step_#{@state.step}_error_#{index}"
            error

  sendApplication: ->
    return if @state.uploading
    @setState uploading: true

    $.ajax
      method: 'POST'
      url: "/api/mentee_applications"
      data:
        application: @state.application
        step: @state.step
      success: (data) =>
        application = @state.application
        application.errors = null
        @setState application: application
        if @state.step == @state.steps
          window.location.replace("/")
        else
          @nextStep()
          @setState uploading: false
      error: (data) =>
        application = @state.application
        if data.responseJSON
          application.errors = data.responseJSON.errors
        else
          application.errors = ['Something goes wrong.', 'Please, refresh the page and try again.', 'If it wont work, contact with organizator.']
        @setState application: application
        @setState uploading: false

  setApplicationField: (field, value) ->
    application = @state.application
    application[field] = value
    @setState application: application

  render: ->
    React.DOM.div
      className: 'steps'
      @showErrors()
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
          React.createElement MenteeApplicationStep3, key: 'step_3', programming_languages: @state.programming_languages, time_availabilities: @state.time_availabilities, engagements: @state.engagements, application: @state.application, setApplicationField: @setApplicationField

      if @state.step <= @state.steps
        React.createElement(ApplicationStepButtons, key: 'step_buttons', previousStep: @previousStep, step: @state.step, steps: @state.steps, sendApplication: @sendApplication)
