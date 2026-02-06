##### Baseline submodule #####
# This will be the same UI layout for each of the ten possible road and rail options, so 
# hence the modularisation here

#  choices for selectizeInputs could be saved externally somewhere
# and loaded when the app starts. Then if extra options need to be added 
# at a later date this can be done in the external data file

baseline_ui <- function(id, tabName){
  ns <- NS(id)
  
  tabItem(tabName = tabName,
          box(width = 12,# title = h3(tagList(base_road_icon, textOutput(ns("some_title"), inline = T))),
              
              fluidRow(
                column(width = 7,
                       h6(HTML("<br>")),
                       h3(tagList(HTML("&nbsp;"), base_road_icon, HTML("&nbsp;"), textOutput(ns("some_title"), inline = T))),
                       h6(HTML("<br>"))
                ),
                column(width = 5, align = "right",
                       h3(tagList(HTML("&nbsp;"), span(img(src="TIICarbonLogo.jpg", width = 220)), HTML("&nbsp;")))
                )
              ),
              
              fluidRow(
                column(width = 12,
                       box(width = 12,
                           actionButton(inputId = ns("baselinebutton"), label = "Toggle Guidance Notes",
                                        style=toggle_guid_btn_style),
                           hidden(
                             div(id = ns("baseline_guid_notes"),
                                 p(HTML("<br> </br>The <b>Project Baseline</b> represents existing conditions. This should include a description of existing land use and traffic flows (where applicable).<br>
                             The baseline data are collated to set the context for the development but do not influence the calculations.<br>"))
                             )
                           )
                       ),
                       
                       box(width = 12,
                           
                           selectizeInput(ns("schemeType"), width = 600, label = "Select the Scheme Type", choices = c("Completely New Infrastructure",
                                                                                                          "Replacement or Upgrade of Existing Infrastructure",
                                                                                                          "Combination of New Infrastructure and Replacement/Upgrade of Existing Infrastructure")),
                           
                           # Conditional panel only shown if user selects Completely New Infrastructure in Scheme Type
                           conditionalPanel(condition = "input.schemeType == 'Completely New Infrastructure'", ns = ns,
                                            selectizeInput(ns("existingLandCondition"), width = 600, label = "Select the existing land use",
                                                           choices = c("Untouched land", "Land used for another purpose", "Combination of used and untouched land"))
                           ),
                           
                           numericInput(inputId = ns("baseline_aadt"), width = 600, label = "24-hour Annual Average Daily Traffic (AADT) for Do Minimum Scenario", value = 0, min=0, max=500000),
                           
                           radioGroupButtons(inputId = ns("baseline_addt_chg"), width = 600, label = "Under Business-As-Usual Conditions how is AADT expected to change relative to the Do Minimum Scenario?",
                                             choices = c("Increase", "No change", "Decrease"), checkIcon = list(yes = icon("ok", lib = "glyphicon"))
                           ),
                           
                           numericInput(inputId = ns("baseline_aadt_chg_percent"), width = 600, label = "Enter the expected percentage change in AADT per year",
                                        value = 0, step = 0.1)
                       )
                )
              )
          )
  )
}


baseline_server <- function(id, option_number, thetitle, theoutput, appR_returned){
  
  moduleServer(id,
               function(input, output, session){
                 #ns <- session$ns
                 output$some_title <- renderText({thetitle})

                 # load numeric/text inputs for road/rail options
                 numModInputs <- c("schemeType", "existingLandCondition", "baseline_aadt", "baseline_aadt_chg_percent")
                 radModInputs <- "baseline_addt_chg"
                 
                 observeEvent(appR_returned$loadReact, {
                   print("ObserveEvent   BASELINE   appR_returned$loadReact")
                   
                   loadedInput <- appR_returned$data$inputs_data_frame
                   
                   for (i in 1:length(numModInputs)){
                     
                     loadedInputValue <- loadedInput %>% filter(Module %in% id) %>% filter(idInput %in% numModInputs[i])
                     loadedInputValue  <- loadedInputValue[1,4]
                     updateNumericInput(getDefaultReactiveDomain(), input = numModInputs[i], value = loadedInputValue)
                     
                   }
                   
                   
                   for (i in 1:length(radModInputs)){
                     
                     loadedInputValue <- loadedInput %>% filter(Module %in% id) %>% filter(idInput %in% radModInputs[i])
                     loadedInputValue  <- loadedInputValue[1,4]
                     updateRadioGroupButtons(getDefaultReactiveDomain(), input = radModInputs[i], selected = loadedInputValue)
                     
                   }
                   
                 })
                 
                 observeEvent(input$baselinebutton, {
                   shinyjs::toggle("baseline_guid_notes")
                 })
                 
               }, session = getDefaultReactiveDomain()
  )
}
