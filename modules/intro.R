
intro_ui <- function(id,tabName){
  ns <- NS(id)
  
  tabItem(
    tabName = tabName,
    box(width = 12, #title = textOutput(ns("some_title")), 
        span(HTML("<center>"),img(src="TIICarbonLogo.jpg", width = 650),HTML("</center>")),
        h3(HTML("<center><br/><br/>Welcome to the TII Carbon Assessment Tool.<br/><br/>")),
        h4(HTML("This tool has been designed to allow for the carbon footprint of road, light rail and greenway projects to be calculated, as required by the
                revised Environmental Impact Assessment (EIA) Directive 2014/52/EU. The tool is customised for road, light rail and greenway projects in Ireland
                and will also help to facilitate the integration of environmental issues and considerations into transport infrastructure planning,
                design, construction, operation and maintenance.<br/><br/>")),
        h4(strong(HTML("Who should use this tool?"))),
        h4(HTML("The tool is designed to be used by contractors and consultants as part of activities leading up to the design and submission process for road and light
                rail projects.<br/><br/>")),
        h4(strong(HTML("When should this tool be used?"))),
        h4(HTML("The tool should be used throughout the project phases from design to operation. It is designed to integrate with the existing planning and design cycle. 
                The outputs from the tool allow TII and scheme designers to compare and evaluate the lifecycle carbon impacts of multiple design options for any given road, light rail or greenway scheme.<br/><br/>")),
        h4(strong(HTML("How does this tool work?"))),
        h4(HTML("The tool uses a series of calculations, emission factors and assumptions to calculate a carbon footprint for a road, light rail or greenway
                project. The carbon footprint calculation is broken down according to Transport Infrastructure Ireland's project phases for road, light rail and greenway projects,
                as well as PAS 2080 (Carbon Management in Infrastructure). The user should enter data available on the scheme into the relevant data entry cells for each
                stage. Additional road, rail and greenway options can be added in the Scoping menu item")),
        h4(HTML("The tool will allow for the evaluation and comparison of the lifecycle carbon impacts of multiple design options for any given road, light rail or greenway scheme.")),
        h4(HTML("It is acknowledged that, dependent upon the stage and maturity of the project, data availability may be limited at the time of the tool's use.
                However, users are encouraged to complete each stage of the tool with as much information as possible, noting any assumptions or limitations
                in the 'Comments/Notes/Assumptions' of the data input tables.")),
        h4(HTML("The sidebar menu can be used to navigate through the tool. Further guidance on use of the tool can be found on each data input page by clicking the 'Toggle Guidance Notes' button.")),
        h6(HTML(paste("Version", ToolVersion))), tagList(h6(HTML("<br/>For technical issues please contact "), mailto))
    )
  )
}

intro_server <- function(id,thetitle){
  moduleServer(id,
               function(input, output, session){
                 output$some_title <- renderText({thetitle})
               }, session = getDefaultReactiveDomain()
  )
}
