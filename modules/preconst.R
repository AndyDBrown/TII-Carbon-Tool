##### Pre-Construction submodule ##############################################################################################################

# Last modified by Andy Brown (11/01/2022)
# - JM (15/09/2021):  Added "stretchH" keyword to rhandsontable to stretch columns across full width of tab
# - JM (16/09/2021):  Added Water Use and carbon savings rhandsontables
# - JM (22/09/2021):  Added 
# - AB (11/01/2022):  Changed units from kg to tonnes for all outputs, kgConversion object used to do this (search global.R). N.B still as kg/unit for emissions inventory

###############################################################################################################################################

# This will be the same UI layout for each of the ten possible road and rail options, so 
# hence the modularisation here
preconst_ui <- function(id, tabName){
  ns <- NS(id)

  tabItem(tabName = tabName, #box(width = 12), title = textOutput(ns("some_title"))),
          box(width = 12,# title = h3(precon_road_icon, textOutput(ns("some_title"), inline = T)),
              
              fluidRow(
                column(width = 7,
                       h6(HTML("<br>")),
                       h3(tagList(HTML("&nbsp;"), precon_road_icon, HTML("&nbsp;"), textOutput(ns("some_title"), inline = T)))
                       #h3(tagList(HTML("&nbsp;"), span(img(src="TIICarbonLogo.jpg", width = 180)), HTML("&nbsp;"), HTML("&nbsp;"), precon_road_icon, HTML("&nbsp;"),
                        #          textOutput(ns("some_title"), inline = T)))
                ),
                column(width = 5, align = "right",
                       h3(tagList(HTML("&nbsp;"), span(img(src="TIICarbonLogo.jpg", width = 220)), HTML("&nbsp;"))),
                       h6(HTML("<br>")),
                       h4(tagList(eflibrary_icon, " Total Pre-Construction Emissions (tCO2e):  ", textOutput(outputId = ns("sum_preconst_tCO2"), inline = T),
                                  HTML("&nbsp;"), HTML("&nbsp;")))
                )
              ),
              
              fluidRow(column(width = 12,
                              box(width = 12,
                                  actionButton(inputId = ns("button"), label = "Toggle Guidance Notes", style=toggle_guid_btn_style),
                                  hidden(
                                    div(id = ns("guid_notes"),
                                        p(HTML("<br> </br>The <b>Pre-Construction stage</b> considers activities that will take place at the pre-construction stage of a project, specifically clearance and demolition works.<br><br>
                          Use the Add/Edit/Delete buttons to add, modify or delete rows respectively, or use the download/upload template buttons below the table to import data from Excel. 
                          The data input tables require:<br>
                            <ul><li>Drop-down selection of clearance activities</li> 
                            <li>The area of land to be cleared (must be a <b>positive</b> value, in the units provided in the Units column of the table)</li>
                            <li>The volume of water, in litres, to be used during clearance and demolition activities</li></ul><br>
                          When the land clearance type is unknown, the 'General Clearance - general site clearance' factor should be selected, which represents an average factor taking into account a combination of different clearance types.<br>
                          Carbon savings opportunities (both proposed and implemented) should be entered in the tables provided for each activity detailed, as applicable."))
                                    ))),
                          hr()
              )),
              
              tabBox(width = 12, side = "left", id = ns("tabbox"), selected = "cada",
                     tabPanel(title = tagList("Clearance and Demolition Activities ", icon("arrow-circle-right")), value = "cada",
                              fluidRow(
                                column(width = 12,
                                       h4("Clearance and Demolition Activities Emissions (tCO2e):   ", textOutput(outputId = ns("sum_cada_tCO2"), inline = T)),
                                       HTML("<br> </br>"),
                                       # h5("Select rows to add to table:"),
                                       # splitLayout(numericInput(ns("cada_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                                       #             actionButton(inputId = ns("cada_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                       # rHandsontableOutput(ns("cadaTbl")),
                                       # tags$style(type="text/css", paste0("#",ns("cadaTbl"), rhandsontable_headstyle)),
                                       # # p(HTML("* Additional rows can be added to the table by right-clicking on the table.<br> <br>
                                       # #        * Please enter a <b>positive</b> value for the quantity of land cleared."))
                                       # p(HTML("* Please enter a <b>positive</b> value for the quantity of land cleared."))
                                       column(6,offset = 6,
                                              HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                              ### tags$head() This is to change the color of "Add a new row" button
                                              tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                              div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("cada_Add_row_head"),label = "Add", class="butt2") ),
                                              tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                              div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("cada_mod_row_head"),label = "Edit", class="butt4") ),
                                              tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                              div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("cada_Del_row_head"),label = "Delete", class="butt3") ),
                                              ### Optional: a html button
                                              # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                              HTML('</div>') ),

                                       column(12,
                                              DT::DTOutput(ns("cadaTbl"))
                                       ),
                                       tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                       div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("Cada_Template_download"),label = "Download Template", class="butt5") ),
                                       tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                       tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;",
                                               fileInput2(inputId = ns("Cada_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                          accept = ".xlsx", multiple = F, width = "100px", progress = F))
                                )
                              )
                     ),
                     
                     tabPanel(title = tagList("Land Use Change and Vegetation Loss ", icon("arrow-circle-right")), value = "lucavl",
                              fluidRow(
                                column(width = 12,
                                       h4("Land Use Change and Vegetation Loss Emissions (tCO2e):   ", textOutput(outputId = ns("sum_lucavl_tCO2"), inline = T)),
                                       HTML("<br> </br>"),
                                       # h5("Select rows to add to table:"),
                                       # splitLayout(numericInput(ns("lucavl_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                                       #             actionButton(inputId = ns("lucavl_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                       # rHandsontableOutput(ns("lucavlTbl")),
                                       # tags$style(type="text/css", paste0("#",ns("lucavlTbl"), rhandsontable_headstyle)),
                                       # p(HTML("* Please enter a <b>positive</b> value for the quantity of vegetation loss.<br>
                                       #        Gains in vegetated land can be entered under the Operational Use tab."))
                                       column(6,offset = 6,
                                              HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                              ### tags$head() This is to change the color of "Add a new row" button
                                              tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                              div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("lucavl_Add_row_head"),label = "Add", class="butt2") ),
                                              tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                              div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("lucavl_mod_row_head"),label = "Edit", class="butt4") ),
                                              tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                              div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("lucavl_Del_row_head"),label = "Delete", class="butt3") ),
                                              ### Optional: a html button
                                              # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                              HTML('</div>') ),
                                       
                                       column(12,
                                              DT::DTOutput(ns("lucavlTbl"))
                                       ),
                                       tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                       div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("lucavl_Template_download"),label = "Download Template", class="butt5") ),
                                       tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                       tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;",
                                               fileInput2(inputId = ns("lucavl_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                          accept = ".xlsx", multiple = F, width = "100px", progress = F))
                                )
                              )
                     ),
                     
                     tabPanel(title = tagList("Water Use During Clearance and Demolition Activities ", icon("arrow-circle-right")), value = "wudcda",
                              fluidRow(
                                column(width = 12,
                                       h4("Water Use Emissions (tCO2e):   ", textOutput(outputId = ns("sum_wudcda_tCO2"), inline = T)),
                                       HTML("<br> </br>"),
                                       # h5("Select rows to add to table:"),
                                       # splitLayout(numericInput(ns("wudcda_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                                       #             actionButton(inputId = ns("wudcda_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                       # rHandsontableOutput(ns("wudcdaTbl")),
                                       # tags$style(type="text/css", paste0("#",ns("wudcdaTbl"), rhandsontable_headstyle))
                                       column(6,offset = 6,
                                              HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                              ### tags$head() This is to change the color of "Add a new row" button
                                              tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                              div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("wudcda_Add_row_head"),label = "Add", class="butt2") ),
                                              tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                              div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("wudcda_mod_row_head"),label = "Edit", class="butt4") ),
                                              tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                              div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("wudcda_Del_row_head"),label = "Delete", class="butt3") ),
                                              ### Optional: a html button
                                              # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                              HTML('</div>') ),
                                       
                                       column(12,
                                              DT::DTOutput(ns("wudcdaTbl"))
                                       ),
                                       tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                       div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("wudcda_Template_download"),label = "Download Template", class="butt5") ),
                                       tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                       tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;",
                                               fileInput2(inputId = ns("wudcda_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                          accept = ".xlsx", multiple = F, width = "100px", progress = F))
                                )
                              )
                     ),
                     
                     tabPanel(title = tagList("Carbon Saving Opportunities ", icon("check-circle")), value = "csavo",  # "level-down-alt"
                              fluidRow(
                                column(width = 12,
                                       h4(strong("Carbon Savings Identified but not Implemented")),
                                       # rHandsontableOutput(ns("csavoNoImplTbl")),
                                       # tags$style(type="text/css", paste0("#",ns("csavoNoImplTbl"), rhandsontable_headstyle))
                                       column(6,offset = 6,
                                              HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                              ### tags$head() This is to change the color of "Add a new row" button
                                              tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                              div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoN_Add_row_head"),label = "Add", class="butt2") ),
                                              tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                              div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoN_mod_row_head"),label = "Edit", class="butt4") ),
                                              tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                              div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoN_Del_row_head"),label = "Delete", class="butt3") ),
                                              ### Optional: a html button
                                              # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                              HTML('</div>') ),
                                       column(12,
                                              DT::DTOutput(ns("csavoNoImplTbl"))
                                       )
                                )
                              ),
                              fluidRow(
                                column(width = 12,
                                       h4(strong("Carbon Savings Identified and Implemented")),
                                       # rHandsontableOutput(ns("csavoImplTbl")),
                                       # tags$style(type="text/css", paste0("#",ns("csavoImplTbl"), rhandsontable_headstyle))
                                       column(6,offset = 6,
                                              HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                              ### tags$head() This is to change the color of "Add a new row" button
                                              tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                              div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoI_Add_row_head"),label = "Add", class="butt2") ),
                                              tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                              div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoI_mod_row_head"),label = "Edit", class="butt4") ),
                                              tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                              div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("csavoI_Del_row_head"),label = "Delete", class="butt3") ),
                                              ### Optional: a html button
                                              # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                              HTML('</div>') ),
                                       column(12,
                                              DT::DTOutput(ns("csavoImplTbl"))
                                       )
                                )
                              )
                     )
              )
          )
  )
}

#----------------#
##### SERVER #####
#----------------#

preconst_server <- function(id, option_number, thetitle, theoutput, appR_returned){
  
  
  # definition of data.tables for each pre-constr stage table
  DF_clearance = data.table(`Clearance Category` = c("Demolition and Site Clearance"), Subcategory = c("General Clearance"), 
                            Activity = c("General clearance - general site clearance"), Quantity = c(0.0,0.0,0.0,0.0,0.0), Unit = c("ha"), 
                            `Activity Emissions tCO2e` = c(0.0), Comments = "", stringsAsFactors = F, check.names = FALSE)

  DF_lucavl = data.table(`Vegetation Type` = c("Mixed Forest"), Quantity = c(0.0,0.0,0.0,0.0,0.0), Unit = c("ha"), 
                            `Carbon Sink tCO2e (removed)` = c(0.0), Comments = "", stringsAsFactors = F, check.names = FALSE)
  
  DF_wudcda = data.table(`Activity Type` = c("Construction"), `Water Use` = c("Water Use - UK Average"), Quantity = c(0.0,0.0,0.0,0.0,0.0), Unit = c("litres"), 
                         `Activity tCO2e` = c(0.0), Comments = "", stringsAsFactors = F, check.names = FALSE)
  
  DF_csavoNoImpl = data.table(`Description of options and how they will lead to carbon savings` = c("","","","",""), 
                         `Rationale for why the option has not been taken forward for implementation` = c("","","","",""), stringsAsFactors = F, check.names = FALSE)
  
  DF_csavoImpl = data.table(`Description of options and how they will lead to carbon savings` = c("","","","",""), 
                         `Rationale for implementation` = c("","","","",""), stringsAsFactors = F, check.names = FALSE)
  
  
  clearancevalues <- reactiveValues(data=DF_clearance)
  lucavlvalues <- reactiveValues(data=DF_lucavl)
  wudcdavalues <- reactiveValues(data=DF_wudcda)
  csavoNoImplvalues <- reactiveValues(data=DF_csavoNoImpl)
  csavoImplvalues <- reactiveValues(data=DF_csavoImpl)
  
  sum_cada_tCO2 <- reactiveValues(data=0.0)#sum(DF_clearance$`Activity Emissions tCO2e`))
  sum_lucavl_tCO2 <- reactiveValues(data=0.0)#sum(DF_lucavl$`Carbon Sink tCO2e (removed)`))
  sum_wudcda_tCO2 <- reactiveValues(data=0.0)#sum(DF_wudcda$`Activity tCO2e`))
  
  sum_preconst_tCO2 <- reactiveValues(data=0.0) # initialise reactive for total carbon emissions for pre-construction module
  
  
  
  DF_returned <- data.table(Option = c(option_number, option_number, option_number, option_number),
                               Stage = c("Pre-Construction","Pre-Construction","Pre-Construction","Pre-Construction"),
                               Measure = c("Clearance & Demolition Activities","Land Use Change & Vegetation Loss","Water Use","Total"),
                               Value = c(0.0,0.0,0.0,0.0),
                               stringsAsFactors = F, check.names = FALSE)
  
  preconst_returned <- reactiveValues(data=DF_returned,
                                      carbsavenotimp=data.table(Option = stringr::str_sub(id, start = -1), 
                                                                Stage = c("Pre-Construction"),
                                                                Description = c(""), Rationale = c("")),
                                      carbsaveimp=data.table(Option = stringr::str_sub(id, start = -1),
                                                             Stage = c("Pre-Construction"),
                                                             Description = c(""), Rationale = c("")),
                                      cadaTblResave = DF_clearance,
                                      lucavlTblResave = DF_lucavl,
                                      wudcdaTblResave = DF_wudcda,
                                      csavoNoImplTblResave = DF_csavoNoImpl,
                                      csavoImplTblResave = DF_csavoImpl)
  

  moduleServer(id,
               function(input, output, session){
                 
                 # Sum of total carbon emissions for each activity type
                 output$sum_cada_tCO2<- renderText({formatC(round(sum_cada_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 output$sum_lucavl_tCO2<- renderText({formatC(round(sum_lucavl_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 output$sum_wudcda_tCO2<- renderText({formatC(round(sum_wudcda_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 
                 #output$sum_cada_tCO2_roadsummary <- renderText(round(sum_cada_tCO2$data, digits = 0))
                 output$sum_preconst_tCO2 <- renderText({formatC(round(sum_preconst_tCO2$data, digits = Emissions_DPlaces_menus), format="f", digits = Emissions_DPlaces_menus, big.mark=',')}) # sum of carbon emissions for full pre-construction stage
                 
                 
                 output$some_title <- renderText({thetitle})
                 #output$the_ns_id <- renderText({id})
                 
                 
                 observeEvent(appR_returned$loadReact, {
                   print("ObserveEvent   PRECONST   appR_returned$loadReact")
                   
                   ### Tracking elements 23-AUG-2023
                   cat(file=stderr(), "*** precons module load observer session token:",session$token, "**** \n")                                         # print session token ID 
                   cat(file=stderr(), "*** precons module load observer session token is unchanged:",session$token == appR_returned$token, "**** \n")  # print current session token == archived token ID
                   ### End
                   
                   clearancevalues$data=DF_clearance
                   lucavlvalues$data=DF_lucavl
                   wudcdavalues$data=DF_wudcda
                   csavoNoImplvalues$data=DF_csavoNoImpl
                   csavoImplvalues$data=DF_csavoImpl
                   
                   sum_cada_tCO2$data = 0.0
                   sum_lucavl_tCO2$data = 0.0
                   sum_wudcda_tCO2$data = 0.0
                   
                   sum_preconst_tCO2$data = 0.0
                   
                   preconst_returned$data$Value = c(0.0,0.0,0.0,0.0)
                   
                   preconst_returned$carbsaveimp$Description = c("")
                   preconst_returned$carbsaveimp$Rationale = c("")
                   preconst_returned$carbsavenotimp$Description = c("")
                   preconst_returned$carbsavenotimp$Rationale = c("")
                   
                   
                   if (is.null(appR_returned$data[[paste0(id,"_cadaTbl")]])){
                     print("LOAD DATA IS NULL")
                   } else {
                     
                   
                   
                   # Load data from the load file into rhandsontables and reactivevalues
                   tmpData <- appR_returned$data[[paste0(id,"_cadaTbl")]]
                   colnames(tmpData) <- colnames(DF_clearance)
                   tmpData$Comments <- as.character(tmpData$Comments)
                   tmpData$Unit <- as.character(tmpData$Unit)
                   clearancevalues$data <- tmpData
                   preconst_returned$cadaTblResave = tmpData
                   sum_cada_tCO2$data <- sum(na.omit(tmpData$`Activity Emissions tCO2e`)) # get total carbon emissions
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_lucavlTbl")]]
                   colnames(tmpData) <- colnames(DF_lucavl)
                   tmpData$Comments <- as.character(tmpData$Comments)
                   tmpData$Unit <- as.character(tmpData$Unit)
                   lucavlvalues$data <- tmpData
                   preconst_returned$lucavlTblResave = tmpData
                   sum_lucavl_tCO2$data <- sum(na.omit(tmpData$`Carbon Sink tCO2e`)) # get total carbon emissions
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_wudcdaTbl")]]
                   colnames(tmpData) <- colnames(DF_wudcda)
                   tmpData$Comments <- as.character(tmpData$Comments)
                   tmpData$Unit <- as.character(tmpData$Unit)
                   wudcdavalues$data <- tmpData
                   preconst_returned$wudcdaTblResave = tmpData
                   sum_wudcda_tCO2$data = sum(na.omit(tmpData$`Activity tCO2e`)) # get total carbon emissions
                   
                   
                   
                   sum_preconst_tCO2$data = sum(sum_cada_tCO2$data,
                                                sum_lucavl_tCO2$data,
                                                sum_wudcda_tCO2$data)
                   
                   
                   preconst_returned$data$Value = c(sum_cada_tCO2$data, sum_lucavl_tCO2$data, sum_wudcda_tCO2$data, sum_preconst_tCO2$data)
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_csavoNoImplTbl")]]
                   colnames(tmpData) <- colnames(DF_csavoNoImpl)
                   tmpData <- transform(tmpData, `Description of options and how they will lead to carbon savings` = as.character(`Description of options and how they will lead to carbon savings`),
                                        `Rationale for why the option has not been taken forward for implementation` = as.character(`Rationale for why the option has not been taken forward for implementation`))
                   colnames(tmpData) <- colnames(DF_csavoNoImpl)
                   preconst_returned$csavoNoImplTblResave <- tmpData
                   csavoNoImplvalues$data <- tmpData
                   
                   tmpdat <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(tmpData)),
                                        Stage = rep("Pre-Construction", nrow(tmpData)))
                   tmpdat[, `:=` (Description = tmpData$`Description of options and how they will lead to carbon savings`,
                                  Rationale = tmpData$`Rationale for why the option has not been taken forward for implementation`)]
                   preconst_returned$carbsavenotimp = tmpdat
                   
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_csavoImplTbl")]]
                   colnames(tmpData) <- colnames(DF_csavoImpl)
                   tmpData <- transform(tmpData, `Description of options and how they will lead to carbon savings` = as.character(`Description of options and how they will lead to carbon savings`),
                                        `Rationale for implementation` = as.character(`Rationale for implementation`))
                   colnames(tmpData) <- colnames(DF_csavoImpl)
                   preconst_returned$csavoImplTblResave <- tmpData
                   csavoImplvalues$data <- tmpData
                   
                   tmpdat <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(tmpData)),
                                        Stage = rep("Pre-Construction", nrow(tmpData)))
                   tmpdat[, `:=` (Description = tmpData$`Description of options and how they will lead to carbon savings`,
                                  Rationale = tmpData$`Rationale for implementation`)]
                   preconst_returned$carbsaveimp = tmpdat
                   
                   }
                   
                 })
                 
                 
                 # New Clearance and Demolition Activities Table-----------------------------------------------
                 
                 ns <- session$ns

                 output$cadaTbl <- DT::renderDT({
                   DT = clearancevalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(6), currency = "", interval = 3, mark = ",", digits = 3)
                 })

                 observeEvent(input$cada_Add_row_head, {
                   ### This is the pop up board for input a new row
                   # browser()
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("cada_add_col1"), label = "Clearance Category", choices = c("Demolition and Site Clearance")),
                     selectizeInput(ns("cada_add_col2"), label = "SubCategory", choices = c("General Clearance")),
                     selectizeInput(ns("cada_add_col3"), label = "Activity", choices = preconst_cada_activity_dropdown %>% 
                                      unique %>% stringr::str_sort(numeric = TRUE)),
                     numericInput(ns("cada_add_col4"), label = "Quantity", value = 0),
                     selectizeInput(ns("cada_add_col5"), label = "Unit", choices = c("ha")),
                     textInput(ns("cada_add_col6"), label = "Comments"),
                     actionButton(ns("cada_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                   
                 })
                 
                 observeEvent(input$cada_add_row_go, {
                   # browser()
                   new_row = data.frame(input$cada_add_col1,
                                        input$cada_add_col2,
                                        input$cada_add_col3,
                                        input$cada_add_col4,
                                        input$cada_add_col5,
                                        "Activity Emissions tCO2e" = 0,
                                        input$cada_add_col6) %>%
                     dplyr::left_join(., efs$Activity_Road, by = c("input.cada_add_col3" = "Activity")) %>%
                     dplyr::mutate(Activity.Emissions.tCO2e = input.cada_add_col4 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -c(Category:Reference))
                   
                   clearancevalues$data <- data.table(rbind(clearancevalues$data, new_row, use.names = F))
                   sum_cada_tCO2$data <- sum(na.omit(clearancevalues$data$`Activity Emissions tCO2e`))
                   sum_preconst_tCO2$data = sum(sum_cada_tCO2$data,
                                                sum_lucavl_tCO2$data,
                                                sum_wudcda_tCO2$data)
                   preconst_returned$data$Value = c(sum_cada_tCO2$data, sum_lucavl_tCO2$data, sum_wudcda_tCO2$data, sum_preconst_tCO2$data)
                   preconst_returned$cadaTblResave = clearancevalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$cada_Del_row_head,{
                   showModal(
                     if(length(input$cadaTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$cadaTbl_rows_selected),
                               ifelse(length(input$cadaTbl_rows_selected)>1,"rows?","row?")),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("cada_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                     
                   )
                 })
                 
                 observeEvent(input$cada_del_row_ok, {
                   #browser()
                   clearancevalues$data=clearancevalues$data[-input$cadaTbl_rows_selected,]
                   sum_cada_tCO2$data <- sum(na.omit(clearancevalues$data$`Activity Emissions tCO2e`))
                   sum_preconst_tCO2$data = sum(sum_cada_tCO2$data,
                                                sum_lucavl_tCO2$data,
                                                sum_wudcda_tCO2$data)
                   preconst_returned$data$Value <- c(sum_cada_tCO2$data, sum_lucavl_tCO2$data, sum_wudcda_tCO2$data, sum_preconst_tCO2$data)
                   preconst_returned$details <- as.data.table(clearancevalues$data)[, c("Clearance Category","Activity Emissions tCO2e")][, Option := as.numeric(stringr::str_sub(id, start = -1))]
                   preconst_returned$cadaTblResave = clearancevalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$cada_mod_row_head,{
                   showModal(
                     if(length(input$cadaTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         selectizeInput(ns("cada_add_col1"), label = "Clearance Category", choices = c("Demolition and Site Clearance")),
                         selectizeInput(ns("cada_add_col2"), label = "SubCategory", choices = c("General Clearance")),
                         selectizeInput(ns("cada_add_col3"), label = "Activity", choices = preconst_cada_activity_dropdown %>% 
                                          unique %>% stringr::str_sort(numeric = TRUE), selected = clearancevalues$data[input$cadaTbl_rows_selected,3]),
                         numericInput(ns("cada_add_col4"), label = "Quantity", value = clearancevalues$data[input$cadaTbl_rows_selected,4]),
                         selectizeInput(ns("cada_add_col5"), label = "Unit", choices = c("ha")),
                         textInput(ns("cada_add_col6"), label = "Comments"),
                         
                         hidden(numericInput(ns("cada_mod_rown"), value = input$cadaTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("cada_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$cada_confirm_mod, {
                   new_row = data.frame(input$cada_add_col1,
                                        input$cada_add_col2,
                                        input$cada_add_col3,
                                        input$cada_add_col4,
                                        input$cada_add_col5,
                                        "Activity Emissions tCO2e" = 0,
                                        input$cada_add_col6) %>%
                     dplyr::left_join(., efs$Activity_Road, by = c("input.cada_add_col3" = "Activity")) %>%
                     dplyr::mutate(Activity.Emissions.tCO2e = input.cada_add_col4 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -c(Category:Reference))
                   
                   clearancevalues$data[input$cada_mod_rown,] <- new_row
                   sum_cada_tCO2$data <- sum(na.omit(clearancevalues$data$`Activity Emissions tCO2e`))
                   sum_preconst_tCO2$data = sum(sum_cada_tCO2$data,
                                                sum_lucavl_tCO2$data,
                                                sum_wudcda_tCO2$data)
                   preconst_returned$data$Value = c(sum_cada_tCO2$data, sum_lucavl_tCO2$data, sum_wudcda_tCO2$data, sum_preconst_tCO2$data)
                   preconst_returned$cadaTblResave = clearancevalues$data
                   
                   removeModal()
                 })
                 
                 output$Cada_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_Preconstruction_CDA.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_Preconstruction_CDA.xlsx",to = file)}
                 )
                 
                 observeEvent(input$Cada_Template_upload$name, {
                   #browser()
                   templateIn <- readxl::read_xlsx(input$Cada_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:3], names(clearancevalues$data)[1:3])){
                     
                     if (typeof(templateIn$Quantity) == "character"){templateIn$Quantity <- as.numeric(templateIn$Quantity)}
                     
                     templateIn_data <- bind_rows(clearancevalues$data, templateIn) %>%
                       dplyr::left_join(., efs$Activity_Road[, c("Activity","kgCO2e per unit")], by = c("Activity" = "Activity")) %>%
                       dplyr::mutate(`Activity Emissions tCO2e` = Quantity * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::filter(Quantity > 0)
                     
                     
                     clearancevalues$data <- templateIn_data
                     
                     sum_cada_tCO2$data <- sum(na.omit(clearancevalues$data$`Activity Emissions tCO2e`))
                     sum_preconst_tCO2$data = sum(sum_cada_tCO2$data, sum_lucavl_tCO2$data, sum_wudcda_tCO2$data)
                     preconst_returned$data$Value = c(sum_cada_tCO2$data, sum_lucavl_tCO2$data, sum_wudcda_tCO2$data, sum_preconst_tCO2$data)
                     preconst_returned$cadaTblResave = clearancevalues$data
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })
                 # LUCAVL New Tables ------------------------------------------------------------------------------------ 
                 
                 output$lucavlTbl <- DT::renderDT({
                   DT = lucavlvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(4), currency = "", interval = 3, mark = ",", digits = 3)
                 })
                 
                 observeEvent(input$lucavl_Add_row_head, {
                   ### This is the pop up board for input a new row
                   # browser()
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("lucavl_add_col1"), label = "Vegetation Type", choices = preconst_lucavl_activity_dropdown),
                     numericInput(ns("lucavl_add_col2"), label = "Quantity", value = 0),
                     selectizeInput(ns("lucavl_add_col3"), label = "Unit", choices = c("ha")),
                     textInput(ns("lucavl_add_col4"), label = "Comments"),
                     actionButton(ns("lucavl_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$lucavl_add_row_go, {
                   #browser()
                   new_row = data.frame(input$lucavl_add_col1,
                                        input$lucavl_add_col2,
                                        input$lucavl_add_col3,
                                        "Carbon Sink tCO2e (removed)" = 0,
                                        input$lucavl_add_col4) %>%
                     dplyr::left_join(., efs$Carbon[, c("Carbon Sink","kgCO2e per unit")], by = c("input.lucavl_add_col1" = "Carbon Sink")) %>%
                     dplyr::mutate(Carbon.Sink.tCO2e..removed. = input.lucavl_add_col2 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   lucavlvalues$data <- data.table(rbind(lucavlvalues$data, new_row, use.names = F))
                   sum_lucavl_tCO2$data <- sum(na.omit(lucavlvalues$data$`Carbon Sink tCO2e (removed)`))
                   sum_preconst_tCO2$data = sum(sum_cada_tCO2$data,
                                                sum_lucavl_tCO2$data,
                                                sum_wudcda_tCO2$data)
                   preconst_returned$data$Value = c(sum_cada_tCO2$data, sum_lucavl_tCO2$data, sum_wudcda_tCO2$data, sum_preconst_tCO2$data)
                   preconst_returned$lucavlTblResave = lucavlvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$lucavl_Del_row_head,{
                   showModal(
                     if(length(input$lucavlTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$lucavlTbl_rows_selected),
                               ifelse(length(input$lucavlTbl_rows_selected)>1,"rows?","row?")),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("lucavl_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                     
                   )
                 })
                 
                 observeEvent(input$lucavl_del_row_ok, {
                   #browser()
                   lucavlvalues$data=lucavlvalues$data[-input$lucavlTbl_rows_selected,]
                   sum_lucavl_tCO2$data <- sum(na.omit(lucavlvalues$data$`Activity Emissions tCO2e`))
                   sum_preconst_tCO2$data = sum(sum_cada_tCO2$data,
                                                sum_lucavl_tCO2$data,
                                                sum_wudcda_tCO2$data)
                   preconst_returned$data$Value <- c(sum_cada_tCO2$data, sum_lucavl_tCO2$data, sum_wudcda_tCO2$data, sum_preconst_tCO2$data)
                   preconst_returned$details <- as.data.table(lucavlvalues$data)[, c("Vegetation Type","Carbon Sink tCO2e (removed)")][, Option := as.numeric(stringr::str_sub(id, start = -1))]
                   preconst_returned$lucavlTblResave = lucavlvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$lucavl_mod_row_head,{
                   showModal(
                     if(length(input$lucavlTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         selectizeInput(ns("lucavl_add_col1"), label = "Vegetation Type", choices = preconst_lucavl_activity_dropdown %>% 
                                          unique %>% stringr::str_sort(numeric = TRUE), selected = lucavlvalues$data[input$lucavlTbl_rows_selected,1]),
                         numericInput(ns("lucavl_add_col2"), label = "Quantity", value = lucavlvalues$data[input$lucavlTbl_rows_selected,2]),
                         selectizeInput(ns("lucavl_add_col3"), label = "Unit", choices = c("ha")),
                         textInput(ns("lucavl_add_col4"), label = "Comments"),

                         hidden(numericInput(ns("lucavl_mod_rown"), value = input$lucavlTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("lucavl_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$lucavl_confirm_mod, {
                   
                   new_row = data.frame(input$lucavl_add_col1,
                                        input$lucavl_add_col2,
                                        input$lucavl_add_col3,
                                        "Carbon Sink tCO2e (removed)" = 0,
                                        input$lucavl_add_col4) %>%
                     dplyr::left_join(., efs$Carbon[, c("Carbon Sink","kgCO2e per unit")], by = c("input.lucavl_add_col1" = "Carbon Sink")) %>%
                     dplyr::mutate(Carbon.Sink.tCO2e..removed. = input.lucavl_add_col2 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   lucavlvalues$data[input$lucavl_mod_rown,] <- new_row
                   sum_lucavl_tCO2$data <- sum(na.omit(lucavlvalues$data$`Carbon Sink tCO2e (removed)`))
                   sum_preconst_tCO2$data = sum(sum_cada_tCO2$data,
                                                sum_lucavl_tCO2$data,
                                                sum_wudcda_tCO2$data)
                   preconst_returned$data$Value = c(sum_cada_tCO2$data, sum_lucavl_tCO2$data, sum_wudcda_tCO2$data, sum_preconst_tCO2$data)
                   preconst_returned$lucavlTblResave = lucavlvalues$data
                   
                   removeModal()
                 })
                 
                 output$lucavl_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_Preconstruction_LUCAVL.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_Preconstruction_LUCAVL.xlsx",to = file)}
                 )
                 
                 observeEvent(input$lucavl_Template_upload$name, {
                   #browser()
                   templateIn <- readxl::read_xlsx(input$lucavl_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:3], names(lucavlvalues$data)[1:3])){
                     
                     if (typeof(templateIn$Quantity) == "character"){templateIn$Quantity <- as.numeric(templateIn$Quantity)}
                     
                     templateIn_data <- bind_rows(lucavlvalues$data, templateIn) %>%
                       dplyr::left_join(., efs$Carbon[, c("Carbon Sink","kgCO2e per unit")], by = c("Vegetation Type" = "Carbon Sink")) %>%
                       dplyr::mutate(`Carbon Sink tCO2e (removed)` = Quantity * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::filter(Quantity > 0)
                     
                     lucavlvalues$data <- templateIn_data
                     
                     sum_lucavl_tCO2$data <- sum(na.omit(lucavlvalues$data$`Carbon Sink tCO2e (removed)`))
                     sum_preconst_tCO2$data = sum(sum_cada_tCO2$data, sum_lucavl_tCO2$data, sum_wudcda_tCO2$data)
                     preconst_returned$data$Value = c(sum_cada_tCO2$data, sum_lucavl_tCO2$data, sum_wudcda_tCO2$data, sum_preconst_tCO2$data)
                     preconst_returned$lucavlTblResave = lucavlvalues$data
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })
                 
                 
                 # WUDCDA New Tables ------------------------------------------------------------------------------------ 
                 output$wudcdaTbl <- DT::renderDT({
                   DT = wudcdavalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(5), currency = "", interval = 3, mark = ",", digits = 3)
                 })
                 
                 observeEvent(input$wudcda_Add_row_head, {
                   ### This is the pop up board for input a new row
                   # browser()
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("wudcda_add_col1"), label = "Activity Type", choices = c("Construction", "Demolition and Site Clearance", "Earthworks")),
                     selectizeInput(ns("wudcda_add_col2"), label = "Water Use", choices = c("Water Use - UK Average")),
                     numericInput(ns("wudcda_add_col3"), label = "Quantity", value = 0),
                     selectizeInput(ns("wudcda_add_col4"), label = "Unit", choices = c("litres")),
                     textInput(ns("wudcda_add_col5"), label = "Comments"),
                     actionButton(ns("wudcda_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$wudcda_add_row_go, {
                   #browser()
                   new_row = data.frame(input$wudcda_add_col1,
                                        input$wudcda_add_col2,
                                        input$wudcda_add_col3,
                                        input$wudcda_add_col4,
                                        "Activity tCO2e" = 0,
                                        input$wudcda_add_col5) %>%
                     dplyr::left_join(., efs$Water[, c("Water","kgCO2e per unit")], by = c("input.wudcda_add_col2" = "Water")) %>%
                     dplyr::mutate(`Activity tCO2e` = input.wudcda_add_col3 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   wudcdavalues$data <- data.table(rbind(wudcdavalues$data, new_row, use.names = F))
                   sum_wudcda_tCO2$data <- sum(na.omit(wudcdavalues$data$`Activity tCO2e`))
                   sum_preconst_tCO2$data = sum(sum_cada_tCO2$data,
                                                sum_lucavl_tCO2$data,
                                                sum_wudcda_tCO2$data)
                   preconst_returned$data$Value = c(sum_cada_tCO2$data, sum_lucavl_tCO2$data, sum_wudcda_tCO2$data, sum_preconst_tCO2$data)
                   preconst_returned$wudcdaTblResave = wudcdavalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$wudcda_Del_row_head,{
                   showModal(
                     if(length(input$wudcdaTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$wudcdaTbl_rows_selected),
                               ifelse(length(input$wudcdaTbl_rows_selected)>1,"rows?","row?")),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("wudcda_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$wudcda_del_row_ok, {
                   #browser()
                   wudcdavalues$data=wudcdavalues$data[-input$wudcdaTbl_rows_selected,]
                   sum_wudcda_tCO2$data <- sum(na.omit(wudcdavalues$data$`Activity tCO2e`))
                   sum_preconst_tCO2$data = sum(sum_cada_tCO2$data,
                                                sum_lucavl_tCO2$data,
                                                sum_wudcda_tCO2$data)
                   preconst_returned$data$Value <- c(sum_cada_tCO2$data, sum_lucavl_tCO2$data, sum_wudcda_tCO2$data, sum_preconst_tCO2$data)
                   preconst_returned$wudcdaTblResave = wudcdavalues$data
                   #preconst_returned$details <- as.data.table(lucavlvalues$data)[, c("Vegetation Type","Carbon Sink tCO2e (removed)")][, Option := as.numeric(stringr::str_sub(id, start = -1))]
                   
                   removeModal()
                 })
                 
                 observeEvent(input$wudcda_mod_row_head,{
                   showModal(
                     if(length(input$wudcdaTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         
                         selectizeInput(ns("wudcda_add_col1"), label = "Activity Type", choices = c("Construction", "Demolition and Site Clearance", "Earthworks"), 
                                        selected = wudcdavalues$data[input$wudcdaTbl_rows_selected,1]),
                         selectizeInput(ns("wudcda_add_col2"), label = "Water Use", choices = c("Water Use - UK Average")),
                         numericInput(ns("wudcda_add_col3"), label = "Quantity", value = wudcdavalues$data[input$wudcdaTbl_rows_selected,3]),
                         selectizeInput(ns("wudcda_add_col4"), label = "Unit", choices = c("litres")),
                         textInput(ns("wudcda_add_col5"), label = "Comments"),
                         
                         hidden(numericInput(ns("wudcda_mod_rown"), value = input$wudcdaTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("wudcda_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$wudcda_confirm_mod, {
                   #browser()
                   new_row = data.frame(input$wudcda_add_col1,
                                        input$wudcda_add_col2,
                                        input$wudcda_add_col3,
                                        input$wudcda_add_col4,
                                        "Activity tCO2e" = 0,
                                        input$wudcda_add_col5) %>%
                     dplyr::left_join(., efs$Water[, c("Water","kgCO2e per unit")], by = c("input.wudcda_add_col2" = "Water")) %>%
                     dplyr::mutate(`Activity.tCO2e` = input.wudcda_add_col3 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   wudcdavalues$data[input$wudcda_mod_rown,] <- new_row
                   sum_wudcda_tCO2$data <- sum(na.omit(wudcdavalues$data$`Activity tCO2e`))
                   sum_preconst_tCO2$data = sum(sum_cada_tCO2$data,
                                                sum_lucavl_tCO2$data,
                                                sum_wudcda_tCO2$data)
                   preconst_returned$data$Value = c(sum_cada_tCO2$data, sum_lucavl_tCO2$data, sum_wudcda_tCO2$data, sum_preconst_tCO2$data)
                   preconst_returned$wudcdaTblResave = wudcdavalues$data
                   
                   removeModal()
                 })
                 
                 
                 output$wudcda_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_Preconstruction_WUDCDA.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_Preconstruction_WUDCDA.xlsx",to = file)}
                 )
                 
                 observeEvent(input$wudcda_Template_upload$name, {
                   
                   templateIn <- readxl::read_xlsx(input$wudcda_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:3], names(wudcdavalues$data)[1:3])){
                     
                     if (typeof(templateIn$Quantity) == "character"){templateIn$Quantity <- as.numeric(templateIn$Quantity)}
                     
                     templateIn <- templateIn %>% filter(!is.na(`Quantity`))
                     
                     templateIn_data <- bind_rows(wudcdavalues$data, templateIn) %>%
                       dplyr::left_join(., efs$Water[, c("Water","kgCO2e per unit")], by = c("Water Use" = "Water")) %>%
                       dplyr::mutate(`Activity tCO2e` = Quantity * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::filter(Quantity > 0)
                     
                     wudcdavalues$data <- templateIn_data
                     
                     sum_wudcda_tCO2$data <- sum(na.omit(wudcdavalues$data$`Activity tCO2e`))
                     sum_preconst_tCO2$data = sum(sum_cada_tCO2$data, sum_lucavl_tCO2$data, sum_wudcda_tCO2$data)
                     preconst_returned$data$Value = c(sum_cada_tCO2$data, sum_lucavl_tCO2$data, sum_wudcda_tCO2$data, sum_preconst_tCO2$data)
                     preconst_returned$wudcdaTblResave = wudcdavalues$data
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })
                 
                 
                 
                 # Carbon saving options (non-implementation) ----
                 output$csavoNoImplTbl <- DT::renderDT({
                   DT = csavoNoImplvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE)
                 })
                 
                 observeEvent(input$csavoN_Add_row_head, {
                   showModal(modalDialog(
                     title = "Add a new row",
                     textInput(ns("csavoN_add_col1"), label = "Description of options and how they will lead to carbon savings"),
                     textInput(ns("csavoN_add_col2"), label = "Rationale for why the option has not been taken forward for implementation"),
                     actionButton(ns("csavoN_Add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$csavoN_Add_row_go, {
                   new_row = data.frame(input$csavoN_add_col1, input$csavoN_add_col2)
                   csavoNoImplvalues$data <- data.table(rbind(csavoNoImplvalues$data, new_row, use.names = F))
                   
                   csavo_tmp <- data.table(csavoNoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("Pre-Construction", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   preconst_returned$carbsavenotimp <- tmpdf
                   preconst_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$csavoN_Del_row_head,{
                   showModal(
                     if(length(input$csavoNoImplTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$csavoNoImplTbl_rows_selected),
                               ifelse(length(input$csavoNoImplTbl_rows_selected)>1,"rows?","row?")),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("csavoN_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$csavoN_del_row_ok, {
                   csavoNoImplvalues$data = csavoNoImplvalues$data[-input$csavoNoImplTbl_rows_selected,]
                   
                   csavo_tmp <- data.table(csavoNoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("Pre-Construction", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   preconst_returned$carbsavenotimp <- tmpdf
                   preconst_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$csavoN_mod_row_head,{
                   showModal(
                     if(length(input$csavoNoImplTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         textInput(ns("csavoN_mod_col1"), label = "Description of options and how they will lead to carbon savings", value = csavoNoImplvalues$data[input$csavoNoImplTbl_rows_selected,1]),
                         textInput(ns("csavoN_mod_col2"), label = "Rationale for why the option has not been taken forward for implementation", value = csavoNoImplvalues$data[input$csavoNoImplTbl_rows_selected,2]),
                         hidden(numericInput(ns("csavoN_mod_rown"), value = input$csavoNoImplTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("csavoN_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$csavoN_confirm_mod, {
                   new_row = data.frame(input$csavoN_mod_col1, input$csavoN_mod_col2)
                   csavoNoImplvalues$data[input$csavoN_mod_rown,] <- new_row
                   
                   csavo_tmp <- data.table(csavoNoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("Pre-Construction", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   preconst_returned$carbsavenotimp <- tmpdf
                   preconst_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
                   removeModal()
                 })
                 
                 
                 
                 # Carbon saving options (Implementation) ----
                 output$csavoImplTbl <- DT::renderDT({
                   DT = csavoImplvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE)
                 })
                 
                 observeEvent(input$csavoI_Add_row_head, {
                   showModal(modalDialog(
                     title = "Add a new row",
                     textInput(ns("csavoI_add_col1"), label = "Description of options and how they will lead to carbon savings"),
                     textInput(ns("csavoI_add_col2"), label = "Rationale for implementation"),
                     actionButton(ns("csavoI_Add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$csavoI_Add_row_go, {
                   new_row = data.frame(input$csavoI_add_col1, input$csavoI_add_col2)
                   csavoImplvalues$data <- data.table(rbind(csavoImplvalues$data, new_row, use.names = F))
                   
                   csavo_tmp <- data.table(csavoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("Pre-Construction", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   preconst_returned$carbsaveimp <- tmpdf
                   preconst_returned$csavoImplTblResave = csavoImplvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$csavoI_Del_row_head,{
                   showModal(
                     if(length(input$csavoImplTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$csavoImplTbl_rows_selected),
                               ifelse(length(input$csavoImplTbl_rows_selected)>1,"rows?","row?")),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("csavoI_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$csavoI_del_row_ok, {
                   csavoImplvalues$data = csavoImplvalues$data[-input$csavoImplTbl_rows_selected,]
                   
                   csavo_tmp <- data.table(csavoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("Pre-Construction", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   preconst_returned$carbsaveimp <- tmpdf
                   preconst_returned$csavoImplTblResave = csavoImplvalues$data
                   
                   removeModal()
                 })
                 
                 observeEvent(input$csavoI_mod_row_head,{
                   showModal(
                     if(length(input$csavoImplTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         textInput(ns("csavoI_mod_col1"), label = "Description of options and how they will lead to carbon savings", value = csavoImplvalues$data[input$csavoImplTbl_rows_selected,1]),
                         textInput(ns("csavoI_mod_col2"), label = "Rationale for why the option has not been taken forward for implementation", value = csavoImplvalues$data[input$csavoImplTbl_rows_selected,2]),
                         hidden(numericInput(ns("csavoI_mod_rown"), value = input$csavoImplTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("csavoI_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$csavoI_confirm_mod, {
                   new_row = data.frame(input$csavoI_mod_col1, input$csavoI_mod_col2)
                   csavoImplvalues$data[input$csavoI_mod_rown,] <- new_row
                   
                   csavo_tmp <- data.table(csavoImplvalues$data); names(csavo_tmp) <- c("Description","Rationale")
                   tmpdf <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(csavo_tmp)),
                                       Stage = rep("Pre-Construction", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   preconst_returned$carbsaveimp <- tmpdf
                   preconst_returned$csavoImplTblResave = csavoImplvalues$data
                   
                   removeModal()
                 })
                 
                 
                 
                 observeEvent(input$button, {
                   shinyjs::toggle("guid_notes")
                 })
                 
                 return(sum_preconst_tCO2)
                 
               }, session = getDefaultReactiveDomain()
               
               )
  
  return(preconst_returned)
  
}
