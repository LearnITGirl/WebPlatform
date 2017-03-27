@MenteeApplication = React.createClass
  render: ->
    React.DOM.div null,
      if @props.step == 1
        React.DOM.div
          className: 'step_1'
          React.createElement ApplicationPersonalInfo, key: 'step_1', application_type: @props.application_type, application: @props.application, countries: @props.countries, timezones: @props.timezones, setApplicationField: @props.setApplicationField
      else if @props.step == 2
        React.DOM.div
          className: 'step_2'
          React.createElement ApplicationExperience, key: 'step_2', application_type: @props.application_type, application: @props.application, setApplicationField: @props.setApplicationField
      else if @props.step == 3
        React.DOM.div
          className: 'step_3'
          React.createElement MenteeApplicationStep3, key: 'step_3', programming_languages: @props.programming_languages, time_availabilities: @props.time_availabilities, engagements: @props.engagements, application: @props.application, setApplicationField: @props.setApplicationField
