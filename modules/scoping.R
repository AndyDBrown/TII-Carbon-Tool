# Scoping Module
# Last updated by A. Thorpe (11/07/2023)
# Updated selectInput objects choices to use number of options as defined in global.R
scoping_ui <- function(id,tabName){
  ns <- NS(id)
  
  tabItem(
    tabName = tabName,
    
    box(width = 12,
        
        fluidRow(
          column(width = 8,
                 h6(HTML("<br>")),
                 h3(tagList(HTML("&nbsp;"), scoping_icon, HTML("&nbsp;"), textOutput(ns("some_title"), inline = T)))
          ),
          column(width = 4, align = "right",
                 h3(tagList(HTML("&nbsp;"), span(img(src="TIICarbonLogo.jpg", width = 220)), HTML("&nbsp;")))
                 )
        ),
        br(),
        box(width = 12,
            h4(strong(HTML("Road and Rail Options"))),
                      p("Enter the number of road and rail schemes assessed in this tool"),
              column(width = 3,
                     selectInput(inputId = "NumRoadOpts", label = "Number of Road Options", choices = c(0:total_num_options), selected = 1, multiple = F, selectize = T)
              ),
              column(width = 3,
                     selectInput(inputId = "NumRailOpts", label = "Number of Light Rail Options", choices = c(0:total_num_options), selected = 0, multiple = F, selectize = T)
              ),
            column(width = 3,
                   selectInput(inputId = "NumGreenwayOpts", label = "Number of Greenway Options", choices = c(0:total_num_options), selected = 0, multiple = F, selectize = T)
              )
            
        ),
        hr(),
        fluidRow(column(width = 12,
                        box(width = 12,
                            actionButton(inputId = ns("button"), label = "Toggle Guidance Notes", style=toggle_guid_btn_style),
                            #hidden(
                              div(id = ns("guid_notes"),
                                  p(HTML("Complete the scoping sections displayed in tabs below according to which elements are to be 
                                         included and excluded in the carbon assessment. Where activities are scoped out, an explanation as to why must be included."))
                              )),
                        hr()
        )),
        
        tabBox(width = 12, side = "left", id = ns("tabbox"),
               
               tabPanel(title = tagList("Pre-construction stage", icon("arrow-circle-right")),
                        
                        h4(strong(HTML("Clearance and demolition activities"))),
                        fluidRow(
                          column(width = 4,
                                 selectInput(width = 400, inputId = ns("preconCadaEmis"), label = "GHG emissions associated with clearance and demolition activities", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                          ),
                          column(width = 6, 
                                 hidden(
                                   div(id = ns("preconCadaEmisRatnldiv"),
                                       textInput(width = 600, inputId = ns("preconCadaEmisRatnl"), label = "Rationale", value = "", placeholder = NULL)
                                   )
                                 )
                          )
                        ),
                        
                        h4(strong(HTML("Land use change and vegetation loss"))),
                        fluidRow(
                          column(width = 4,
                                 selectInput(width = 400, inputId = ns("preconLucavlEmis"), label = "GHG emissions associated with land use change and vegetation loss", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                          ),
                          column(width = 6, 
                                 hidden(
                                   div(id = ns("preconLucavlEmisRatnldiv"),
                                       textInput(width = 600, inputId = ns("preconLucavlEmisRatnl"), label = "Rationale", value = "", placeholder = NULL)
                                   )
                                 )
                          )
                        ),
                        
                        h4(strong(HTML("Water use during clearance and demolition activities"))),
                        fluidRow(
                          column(width = 4,
                                 selectInput(width = 400, inputId = ns("preconWudcdaEmis"), label = "GHG emissions from water use during clearance and demolition activities", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                          ),
                          column(width = 6, 
                                 hidden(
                                   div(id = ns("preconWudcdaEmisRatnldiv"),
                                       textInput(width = 600, inputId = ns("preconWudcdaEmisRatnl"), label = "Rationale", value = "", placeholder = NULL)
                                   )
                                 )
                          )
                        )
                        
                        
               ),
               
               tabPanel(title = tagList("Product stage", icon("arrow-circle-right")),
                        
                        h4(strong(HTML("Raw material extraction and manufacturing of products required for proposed Scheme"))),
                        
                        fluidRow(
                          column(width = 4,
                                 selectInput(width = 400, inputId = ns("MatTransp"), label = "GHG emissions from transport of materials", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                          ),
                          column(width = 6, 
                                 hidden(
                                   div(id = ns("MatTranspRatnldiv"),
                                       textInput(width = 600, inputId = ns("MatTranspRatnl"), label = "Rationale", value = "", placeholder = NULL)
                                   )
                                 )
                          )
                        ),
                        
                        fluidRow(
                          column(width = 4,
                                 selectInput(width = 400, inputId = ns("embGHGem"), label = "Embodied GHG emissions of materials", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                          ),
                          column(width = 6,
                                 hidden(
                                   div(id = ns("embGHGemRatnldiv"),
                                       textInput(width = 600, inputId = ns("embGHGemRatnl"), label = "Rationale", value = "", placeholder = NULL)
                                   )
                                 )
                          )
                        ),
                        
                        h4(strong(HTML("Raw material lifetime to inform maintenance cycle"))),
                        fluidRow(
                          column(width = 4,
                                 selectInput(width = 400, inputId = ns("GHGrep"), label = "GHG emissions from replacing the material during the project lifetime", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                          ),
                          column(width = 6, 
                                 hidden(
                                   div(id = ns("GHGrepRatnldiv"),
                                       textInput(width = 600, inputId = ns("GHGrepRatnl"), label = "Rationale", value = "", placeholder = NULL)
                                   )
                                 )
                          )
                        )
               ),
               
               tabPanel(title = tagList("Construction process stage", icon("arrow-circle-right")),
                        
                        h4(strong(HTML("Clearance activities"))),
                        fluidRow(
                          column(width = 4,
                                 selectInput(width = 400, inputId = ns("clearanceEmis"), label = "GHG emissions from plant use during land clearance", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                          ),
                          column(width = 6, 
                                 hidden(
                                   div(id = ns("clearanceEmisRatnldiv"),
                                       textInput(width = 600, inputId = ns("clearanceEmisRatnl"), label = "Rationale", value = "", placeholder = NULL)
                                   )
                                 )
                          )
                        ),
                        
                        h4(strong(HTML("Excavation activities"))),
                        fluidRow(
                          column(width = 4,
                                 selectInput(width = 400, inputId = ns("excavationEmis"), label = "GHG emissions from excavation activities", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                          ),
                          column(width = 6, 
                                 hidden(
                                   div(id = ns("excavationEmisRatnldiv"),
                                       textInput(width = 600, inputId = ns("excavationEmisRatnl"), label = "Rationale", value = "", placeholder = NULL)
                                   )
                                 )
                          )
                        ),
                        
                        h4(strong(HTML("On-site construction activity"))),
                        fluidRow(
                          column(width = 4,
                                 selectInput(width = 400, inputId = ns("constplantEmis"), label = "GHG emissions from vehicle/plant use during construction", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                          ),
                          column(width = 6, 
                                 hidden(
                                   div(id = ns("constplantEmisRatnldiv"),
                                       textInput(width = 600, inputId = ns("constplantEmisRatnl"), label = "Rationale", value = "", placeholder = NULL)
                                   )
                                 )
                          )
                        ),
                        
                        h4(strong(HTML("On-site water use"))),
                        fluidRow(
                          column(width = 4,
                                 selectInput(width = 400, inputId = ns("constwaterEmis"), label = "GHG emissions from water use on site during construction", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                          ),
                          column(width = 6, 
                                 hidden(
                                   div(id = ns("constwaterEmisRatnldiv"),
                                       textInput(width = 600, inputId = ns("constwaterEmisRatnl"), label = "Rationale", value = "", placeholder = NULL)
                                   )
                                 )
                          )
                        ),
                        
                        h4(strong(HTML("Waste arising from construction"))),
                        fluidRow(
                          column(width = 4,
                                 selectInput(width = 400, inputId = ns("constwasteEmis"), label = "GHG emissions from waste arising during construction and the transport of waste materials arising during construction", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                          ),
                          column(width = 6, 
                                 hidden(
                                   div(id = ns("constwasteEmisRatnldiv"),
                                       textInput(width = 600, inputId = ns("constwasteEmisRatnl"), label = "Rationale", value = "", placeholder = NULL)
                                   )
                                 )
                          )
                        )
                        
                        
                        
               ),
               
               tabPanel(title = tagList("Operation and Use stage", icon("arrow-circle-right")),
                        
                        h4(strong(HTML("Operation of associated infrastructure equipment and signalling"))),
                        fluidRow(
                          column(width = 4,
                                 selectInput(width = 400, inputId = ns("operationEmis"), label = "GHG emissions from energy and fuel use in depots, other buildings, lighting, signs, etc.", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                          ),
                          column(width = 6, 
                                 hidden(
                                   div(id = ns("operationEmisRatnldiv"),
                                       textInput(width = 600, inputId = ns("operationEmisRatnl"), label = "Rationale", value = "", placeholder = NULL)
                                   )
                                 )
                          )
                        ),
                        
                        h4(strong(HTML("Water use associated with infrastructure use"))),
                        fluidRow(
                          column(width = 4,
                                 selectInput(width = 400, inputId = ns("operwaterEmis"), label = "GHG emissions from water use during operation", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                          ),
                          column(width = 6, 
                                 hidden(
                                   div(id = ns("operwaterEmisRatnldiv"),
                                       textInput(width = 600, inputId = ns("operwaterEmisRatnl"), label = "Rationale", value = "", placeholder = NULL)
                                   )
                                 )
                          )
                        ),
                        
                        h4(strong(HTML("Waste associated with infrastructure use"))),
                        fluidRow(
                          column(width = 4,
                                 selectInput(width = 400, inputId = ns("operwasteEmis"), label = "GHG emissions from waste arising during operation", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                          ),
                          column(width = 6, 
                                 hidden(
                                   div(id = ns("operwasteEmisRatnldiv"),
                                       textInput(width = 600, inputId = ns("operwasteEmisRatnl"), label = "Rationale", value = "", placeholder = NULL)
                                   )
                                 )
                          )
                        ),
                        
                        h4(strong(HTML("Maintenance plant use"))),
                        fluidRow(
                          column(width = 4,
                                 selectInput(width = 400, inputId = ns("maintplantEmis"), label = "GHG emissions associated with maintenance plant use", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                          ),
                          column(width = 6, 
                                 hidden(
                                   div(id = ns("maintplantEmisRatnldiv"),
                                       textInput(width = 600, inputId = ns("maintplantEmisRatnl"), label = "Rationale", value = "", placeholder = NULL)
                                   )
                                 )
                          )
                        ),
                        
                        # h4(strong(HTML("Vehicle journeys"))),
                        # fluidRow(
                        #   column(width = 4,
                        #          selectInput(width = 400, inputId = ns("vehEmis"), label = "GHG emissions per vehicle km", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                        #   ),
                        #   column(width = 6, 
                        #          hidden(
                        #            div(id = ns("vehEmisRatnldiv"),
                        #                textInput(width = 600, inputId = ns("vehEmisRatnl"), label = "Rationale", value = "", placeholder = NULL)
                        #            )
                        #          )
                        #   )
                        # )
                        
               ),
               
               tabPanel(title = tagList("Decommissioning", icon("check-circle")),
                        
                        h4(strong(HTML("Decommissioning or deconstruction"))),
                        
                        fluidRow(
                          column(width = 4,
                                 selectInput(width = 400, inputId = ns("MatDisposal"), label = "GHG emissions from reuse and/or disposal of materials", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                          ),
                          column(width = 6, 
                                 hidden(
                                   div(id = ns("MatDisposalRatnldiv"),
                                       textInput(width = 600, inputId = ns("MatDisposalRatnl"), label = "Rationale", value = "", placeholder = NULL)
                                   )
                                 )
                          )
                        ),
                        
                        fluidRow(
                          column(width = 4,
                                 selectInput(width = 400, inputId = ns("decomPlant"), label = "GHG emissions associated with plant used for decommissioning or deconstruction", choices = c("Scoped In", "Scoped Out",""), selected = "Scoped In")
                          ),
                          column(width = 6,
                                 hidden(
                                   div(id = ns("decomPlantRatnldiv"),
                                       textInput(width = 600, inputId = ns("decomPlantRatnl"), label = "Rationale", value = "", placeholder = NULL)
                                   )
                                 )
                          )
                        )
               )
        )
    )
  )
}

scoping_server <- function(id, thetitle, appR_returned){
  moduleServer(id,
               function(input, output, session){
                 output$some_title <- renderText({thetitle})
                 
                 
                 #modInputs <- c("GHGrep", "MatTransp", "MatTranspRatnl", "embGHGem", "embGHGemRatnl", "constplantEmis", "maintplantEmis", "HighLevelInfo")
                 
                 modInputs <- c('preconCadaEmis', 'preconCadaEmisRatnl', 'preconLucavlEmis', 'preconLucavlEmisRatnl', 'preconWudcdaEmis', 'preconWudcdaEmisRatnl',
                                'MatTransp',  'MatTranspRatnl',  'embGHGem',  'embGHGemRatnl',  'GHGrep',
                                'GHGrepRatnl',  'clearanceEmis',  'clearanceEmisRatnl',  'excavationEmis',  'excavationEmisRatnl',
                                'constplantEmis',  'constplantEmisRatnl',  'constwaterEmis',  'constwaterEmisRatnl',  'constwasteEmis',
                                'constwasteEmisRatnl',  'operationEmis',  'operationEmisRatnl',  'operwaterEmis',  'operwaterEmisRatnl',
                                'operwasteEmis',  'operwasteEmisRatnl',  'maintplantEmis',  'maintplantEmisRatnl',  'MatDisposal',
                                'MatDisposalRatnl',  'decomPlant',  'decomPlantRatnl')
                 
                 observeEvent(appR_returned$loadReact, {
                   print("ObserveEvent   SCOPING   appR_returned$loadReact")
                   
                   
                   loadedInput <- appR_returned$data$inputs_data_frame
                   
                   for (i in 1:length(modInputs)){
                     
                       loadedInputValue <- loadedInput %>% filter(idInput %in% modInputs[i])
                       loadedInputValue  <- loadedInputValue[1,4]
                       updateNumericInput(session, input = modInputs[i], value = loadedInputValue)
                       
                   }
                 })
                 
                 
                 # Hide/show Rationale field if item is scoped in / scoped out
                 
                 # preconstruction stage
                 observeEvent(input$preconCadaEmis, {
                   if (input$preconCadaEmis == "Scoped Out"){
                     shinyjs::show("preconCadaEmisRatnldiv")
                   } else {
                     shinyjs::hide("preconCadaEmisRatnldiv")
                   }
                 })
                 
                 observeEvent(input$preconLucavlEmis, {
                   if (input$preconLucavlEmis == "Scoped Out"){
                     shinyjs::show("preconLucavlEmisRatnldiv")
                   } else {
                     shinyjs::hide("preconLucavlEmisRatnldiv")
                   }
                 })
                 
                 observeEvent(input$preconWudcdaEmis, {
                   if (input$preconWudcdaEmis == "Scoped Out"){
                     shinyjs::show("preconWudcdaEmisRatnldiv")
                   } else {
                     shinyjs::hide("preconWudcdaEmisRatnldiv")
                   }
                 })
                 
                 
                 # product stage
                 observeEvent(input$MatTransp, {
                   if (input$MatTransp == "Scoped Out"){
                     shinyjs::show("MatTranspRatnldiv")
                   } else {
                     shinyjs::hide("MatTranspRatnldiv")
                   }
                 })
                 
                 observeEvent(input$embGHGem, {
                   if (input$embGHGem == "Scoped Out"){
                     shinyjs::show("embGHGemRatnldiv")
                   } else {
                     shinyjs::hide("embGHGemRatnldiv")
                   }
                 })
                 
                 observeEvent(input$GHGrep, {
                   if (input$GHGrep == "Scoped Out"){
                     shinyjs::show("GHGrepRatnldiv")
                   } else {
                     shinyjs::hide("GHGrepRatnldiv")
                   }
                 })
                 
                 # construction process stage
                 observeEvent(input$clearanceEmis, {
                   if (input$clearanceEmis == "Scoped Out"){
                     shinyjs::show("clearanceEmisRatnldiv")
                   } else {
                     shinyjs::hide("clearanceEmisRatnldiv")
                   }
                 })
                 
                 observeEvent(input$excavationEmis, {
                   if (input$excavationEmis == "Scoped Out"){
                     shinyjs::show("excavationEmisRatnldiv")
                   } else {
                     shinyjs::hide("excavationEmisRatnldiv")
                   }
                 })
                 
                 observeEvent(input$constplantEmis, {
                   if (input$constplantEmis == "Scoped Out"){
                     shinyjs::show("constplantEmisRatnldiv")
                   } else {
                     shinyjs::hide("constplantEmisRatnldiv")
                   }
                 })
                 
                 observeEvent(input$constwaterEmis, {
                   if (input$constwaterEmis == "Scoped Out"){
                     shinyjs::show("constwaterEmisRatnldiv")
                   } else {
                     shinyjs::hide("constwaterEmisRatnldiv")
                   }
                 })
                 
                 observeEvent(input$constwasteEmis, {
                   if (input$constwasteEmis == "Scoped Out"){
                     shinyjs::show("constwasteEmisRatnldiv")
                   } else {
                     shinyjs::hide("constwasteEmisRatnldiv")
                   }
                 })
                 
                 # operational and use stage
                 observeEvent(input$operationEmis, {
                   if (input$operationEmis == "Scoped Out"){
                     shinyjs::show("operationEmisRatnldiv")
                   } else {
                     shinyjs::hide("operationEmisRatnldiv")
                   }
                 })
                 
                 observeEvent(input$operwaterEmis, {
                   if (input$operwaterEmis == "Scoped Out"){
                     shinyjs::show("operwaterEmisRatnldiv")
                   } else {
                     shinyjs::hide("operwaterEmisRatnldiv")
                   }
                 })
                 
                 observeEvent(input$operwasteEmis, {
                   if (input$operwasteEmis == "Scoped Out"){
                     shinyjs::show("operwasteEmisRatnldiv")
                   } else {
                     shinyjs::hide("operwasteEmisRatnldiv")
                   }
                 })
                 
                 observeEvent(input$maintplantEmis, {
                   if (input$maintplantEmis == "Scoped Out"){
                     shinyjs::show("maintplantEmisRatnldiv")
                   } else {
                     shinyjs::hide("maintplantEmisRatnldiv")
                   }
                 })
                 
                 # observeEvent(input$vehEmis, {
                 #   if (input$vehEmis == "Scoped Out"){
                 #     shinyjs::show("vehEmisRatnldiv")
                 #   } else {
                 #     shinyjs::hide("vehEmisRatnldiv")
                 #   }
                 # })

                 # decommissioning stage
                 observeEvent(input$MatDisposal, {
                   if (input$MatDisposal == "Scoped Out"){
                     shinyjs::show("MatDisposalRatnldiv")
                   } else {
                     shinyjs::hide("MatDisposalRatnldiv")
                   }
                 })
                 
                 observeEvent(input$decomPlant, {
                   if (input$decomPlant == "Scoped Out"){
                     shinyjs::show("decomPlantRatnldiv")
                   } else {
                     shinyjs::hide("decomPlantRatnldiv")
                   }
                 })
                 
                 observeEvent(input$button, {
                   shinyjs::toggle("guid_notes")
                 })
                 
               }, session = getDefaultReactiveDomain()
  )
}
