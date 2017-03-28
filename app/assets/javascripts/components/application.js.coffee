@Application = React.createClass
  getInitialState: ->
    application_type: @props.application_type
    application: @props.application
    countries: @props.countries
    timezones: @props.timezones
    programming_languages: @props.programming_languages
    time_availabilities: @props.time_availabilities
    engagements: @props.engagements
    sources: @props.sources
    step: 1
    steps: @props.steps

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
      url: @apiUrl()
      data:
        application: @state.application
        step: @state.step
        steps: @state.steps
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

  apiUrl: ->
    if @props.application_type == 'mentee'
      "/api/mentee_applications"
    else if @props.application_type == 'mentor'
      "/api/mentor_applications"

  renderApplication: ->
    params = @state
    params.setApplicationField = @setApplicationField
    if @props.application_type == 'mentee'
      React.createElement(MenteeApplication, params)
    else if @props.application_type == 'mentor'
      React.createElement(MentorApplication,  @state)

  render: ->
    React.DOM.div
      className: 'steps'
      @showErrors()
      @renderApplication()
      if @state.step <= @state.steps
        React.createElement(ApplicationStepButtons, key: 'step_buttons', previousStep: @previousStep, step: @state.step, steps: @state.steps, sendApplication: @sendApplication)
