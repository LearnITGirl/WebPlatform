@MentorApplicationStep4 = React.createClass
  render: ->
    React.DOM.div
      className: 'fields'
      React.createElement(ApplicationTextArea, key: 'suggestion', field: 'application_idea', label: "Which idea/application would you suggest for a complete beginner to work on during 12 weeks (part-time)?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationTextArea, key: 'challenging', field: 'concept_explanation', label: "Looking back at the time when you were still a beginner - which concept do you remember was challenging for you to understand? Who or what helped you to finally grasp it?", application: @props.application, setApplicationField: @props.setApplicationField)
