
proj_details_ui <- function(id,tabName){
  ns <- NS(id)
  
  tabItem(
    tabName = tabName,
    
    box(width = 12, height = 800,
        
        fluidRow(
          column(width = 8,
                 h6(HTML("<br>")),
                 h3(tagList(HTML("&nbsp;"), proj_details_icon, HTML("&nbsp;"), textOutput(ns("some_title"), inline = T)))
          ),
          column(width = 4, align = "right",
                 h3(tagList(HTML("&nbsp;"), span(img(src="TIICarbonLogo.jpg", width = 220)), HTML("&nbsp;")))
          )
          #column(width = 12,
          #       h3(tagList(HTML("&nbsp;"), span(img(src="TIICarbonLogo.jpg", width = 180)), HTML("&nbsp;"), HTML("&nbsp;"), proj_details_icon, HTML("&nbsp;"),
          #                  textOutput(ns("some_title"), inline = T)))
          #)
        ),
        
        br(),
        box(width = 12,
            
            h5(HTML("Enter key project details here. Some of this data is used in the outputs, so this section should be completed as accurately as possible.
                    <br/><br/>Rows marked with a * must be completed to allow calculations to function correctly.<br/><br/>")),
            column(width = 6, 
                   textInput(width = 500, inputId = ns("projRef"), label = "TII Project Reference", value = "", placeholder = NULL),
                   textInput(width = 500, inputId = ns("nameUser"), label = "Name of person using tool", value = "", placeholder = NULL),
                   textInput(width = 500, inputId = ns("nameCompany"), label = "Name of company using tool", value = "", placeholder = NULL),
                   textInput(width = 500, inputId = ns("namecontractors"), label = "Name of any other contractors", value = "", placeholder = NULL),
                   #textInput(width = 500, inputId = "nameProj", label = "Name of project", value = "Big Republic of Ireland Road Upgrade Project No. 1", placeholder = NULL)
                   textInput(width = 500, inputId = ns("nameProj"), label = "Name of project", value = "Project", placeholder = NULL),
                   shinyWidgets::autonumericInput(width = 500, inputId = ns("projValue"), label = "Value of Project*",
                                                  value = 0, digitGroupSeparator = ",",decimalPlaces = 0, align = "left", currencySymbol = "\u20ac"),
                   selectInput(width = 500, inputId = ns("projPhase"), label = "Project Phase*", 
                               list(`Road Project` = road_proj_phase_list, 
                                    `Light Rail Project` = rail_proj_phase_list,
									`Greenway Project` = greenway_proj_phase_list),
                               selected = "", multiple = F)
            ),
            column(width = 6,
                   #numericInput(width = 500, inputId = ns("projValue"), label = "Value of Project (euro)*", value = 1, min = 1),
                   dateInput(width = 500, inputId = ns("dateProj"), label = "Date of data input", value = NULL, format = "dd-M-yyyy"),
                   dateInput(width = 500, inputId = ns("dateStart"), label = "Construction Start Date", value = NULL, format = "dd-M-yyyy"),
                   dateInput(width = 500, inputId = ns("dateEnd"), label = "Construction End Date", value = NULL, format = "dd-M-yyyy"),
                   numericInput(width = 500, inputId = ns("lifeTime"), label = "Scheme design life (years)*", value = 1, min = 1, max = 100),
                   textAreaInput(width = 500, height =100, inputId = ns("projDesc"), label = "Project description (qualitative description, to 
                                include length of infrastructure, key assets, number of interchanges etc.)", value = "", placeholder = NULL),
                   
            )
        )
    )
  )
}

proj_details_server <- function(id, thetitle, appR_returned){
  
  projectdetails_values <- reactiveValues(projValue=0.0, lifeTime = 0) # reactiveValues object for the project value

  moduleServer(id,
               function(input, output, session){
                 
                 output$some_title <- renderText({thetitle})
                 
                 observe(projectdetails_values$projValue <- as.numeric(input$projValue))
                 
                 observe({
                   #browser()
                   projectdetails_values$lifeTime <- input$lifeTime
                 })
                 observe(projectdetails_values$projPhase <- input$projPhase)
                 
                 
                 txtModInputs <- c("projRef","nameUser","nameCompany","namecontractors","nameProj","projDesc")
                 numModInputs <- c("projValue","projPhase","lifeTime")
                 datModInputs <- c("dateProj", "dateStart", "dateEnd")
                 
                 observeEvent(input$dateProj, {
                   if (length(input$dateProj) == 0) {
                     shinyalert("<h4>Date of input cannot be blank. If unknown enter today's date</h4>", 
                                type = "error", showConfirmButton = T, 
                                animation = T, closeOnEsc = T, html = T)
                     updateDateInput(session, "dateProj", value = "2024-01-01")
                   }
                 })
                 
                 observeEvent(input$dateStart, {
                   if (length(input$dateStart) == 0) {
                     shinyalert("<h4>Construction start date cannot be blank. If unknown enter today's date</h4>", 
                                type = "error", showConfirmButton = T, 
                                animation = T, closeOnEsc = T, html = T)
                     updateDateInput(session, "dateStart", value = "2024-01-01")
                   }
                 })
                 
                 observeEvent(input$dateEnd, {
                   if (length(input$dateEnd) == 0) {
                     shinyalert("<h4>Construction end date cannot be blank. If unknown enter today's date</h4>", 
                                type = "error", showConfirmButton = T, 
                                animation = T, closeOnEsc = T, html = T)
                     updateDateInput(session, "dateEnd", value = "2024-01-01")
                   }
                 })
                 
                 observeEvent(appR_returned$loadReact, {
                   print("ObserveEvent   PROJECT DETAILS   appR_returned$loadReact")
                   
                   #shinyalert("File Loaded", timer = 2000, immediate = T, showConfirmButton = F, animation = T, closeOnEsc = T, type = "success")#, inputId = "load_button_ok")
                   
                   loadedInput <- appR_returned$data$inputs_data_frame
                   
                   
                   for (i in 1:length(txtModInputs)){
                     
                     loadedInputValue <- loadedInput %>% filter(Module %in% id) %>% filter(idInput %in% txtModInputs[i])
                     loadedInputValue <- loadedInputValue[1,4]
                     updateTextInput(getDefaultReactiveDomain(), input = txtModInputs[i], value = loadedInputValue)
                     
                   }
                   
                   for (i in 1:length(numModInputs)){
                     
                     loadedInputValue <- loadedInput %>% filter(Module %in% id) %>% filter(idInput %in% numModInputs[i])
                     loadedInputValue <- loadedInputValue[1,4]
                     updateNumericInput(getDefaultReactiveDomain(), input = numModInputs[i], value = loadedInputValue)
                     
                   }
                   
                   
                   for (i in 1:length(datModInputs)){
                     
                     loadedInputValue <- loadedInput %>% filter(idInput %in% datModInputs[i])
                     loadedInputValue <- as.numeric(loadedInputValue[1,4])
                     loadedInputValue <- as.Date(loadedInputValue, origin = as.Date("1970-01-01"))
                     updateDateInput(getDefaultReactiveDomain(), input = datModInputs[i], value = loadedInputValue)
                     
                   }
                   
                 })
               }, session = getDefaultReactiveDomain()
  )
  
  return(projectdetails_values)
  
}
