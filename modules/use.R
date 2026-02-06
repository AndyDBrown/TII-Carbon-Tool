##### Use submodule ##############################################################################################################

# Last modified by Andy Brown (12/01/2022)
# - AB (11/01/2022):  Changed units from kg to tonnes for all outputs, kgConversion object used to do this (search global.R). N.B still as kg/unit for emissions inventory

##################################################################################################################################

use_ui <- function(id,tabName){
  ns <- NS(id)
  
  # Switch selection depending on Road or Rail Option
  if(stringr::str_detect(id, pattern = "ro[0-9]{1,2}$")){
    use_stage_icon <- use_road_icon
    roadorrail <- "Road"
  } else if(stringr::str_detect(id, pattern = "ra[0-9]{1,2}$")){
    use_stage_icon <- use_rail_icon
    roadorrail <- "Rail"
  } else if(stringr::str_detect(id, pattern = "gw[0-9]{1,2}$")){
    use_stage_icon <- use_road_icon
    roadorrail <- "Greenway"
  }
  
  tabItem(
    tabName = tabName,
    box(width = 12,
        
        fluidRow(
          column(width = 7,
                 h6(HTML("<br>")),
                 h3(tagList(HTML("&nbsp;"), use_stage_icon, HTML("&nbsp;"), textOutput(ns("some_title"), inline = T)))
          ),
          column(width = 5, align = "right",
                 h3(tagList(HTML("&nbsp;"), span(img(src="TIICarbonLogo.jpg", width = 220)), HTML("&nbsp;"))),
                 h6(HTML("<br>")),
                 h4(tagList(eflibrary_icon, "Total Use Emissions (tCO2e):  ", textOutput(outputId = ns("sum_use_tCO2"), inline = T), 
                            HTML("&nbsp;"), HTML("&nbsp;")))
          )
        ),
        
        fluidRow(column(width = 12,
                        box(width = 12,
                            actionButton(inputId = ns("button"), label = "Toggle Guidance Notes", style=toggle_guid_btn_style),
                            hidden(
                              div(id = ns("guid_notes"),
                                  p(HTML(paste0("<br> </br>The <b> Operational Use</b> page calculates emissions associated with the operation of the infrastructure scheme such as energy, water and waste.<br><br>
                          Use the Add/Edit/Delete buttons to add, modify or delete rows respectively, or use the download/upload template buttons below the table to import data from Excel. 
                          The data input tables require:<br>
                            <ul><li>Drop-down selection of energy use category and energy type</li>
                            <li>Input of annual energy consumption (in accordance with the units provided in the Units column of the table)</li>
                            <li>Input of annual water consumption (in accordance with the units provided in the Units column of the table)</li>
                            <li>Drop-down selection of waste use category, sub category and route</li>
                            <li>Input of annual waste production (in accordance with the units provided in the Units column of the table)</li>
                            <li>Input of waste transportation mode and distance in kilometres per year</li></ul><br>
                          
                          Carbon savings opportunities (both proposed and implemented) should be entered in the tables provided for each activity detailed, as applicable.")))
                              ))))),
        
        tags$style(".nav-tabs {background: #f4f4f4;}"),
        
        tabBox(width = 12, side = "left", id = ns("tabbox"), selected = "oeu",
               
               tabPanel(title = tagList("Operational Energy Use", icon("arrow-circle-right")), value = "oeu", #  tagList("Clearance and Demolition Activities ", icon("arrow-circle-right"))   check-circle
                        fluidRow(
                          column(width = 12,
                                 tags$div(title="This is Annual Emissions multiplied by Scheme Design Life",
                                          h4("Operational Energy Use Emissions (tCO2e):  ",textOutput(outputId = ns("sum_oeu_tCO2"), inline = T), tags$sup(icon("question-circle"))) #HTML("<sup>&#x2610;<sup/>"))
                                 ),
                                 h4("Scheme design life (years):  ", textOutput(outputId = ns("lifeTime1"), inline = T)),
                                 br(),
                                 # h5("Select rows to add to table:"),
                                 # splitLayout(numericInput(ns("oeu_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                                 #             actionButton(inputId = ns("oeu_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                 # rHandsontableOutput(ns("oeuTbl")),
                                 # tags$style(type="text/css", paste0("#",ns("oeuTbl"), rhandsontable_headstyle))#,
                                 # p("* Additional rows can be added to the table by right-clicking on the table")
                                 column(6,offset = 6,
                                        HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                        ### tags$head() This is to change the color of "Add a new row" button
                                        tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("oeu_Add_row_head"),label = "Add", class="butt2") ),
                                        tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("oeu_mod_row_head"),label = "Edit", class="butt4") ),
                                        tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("oeu_Del_row_head"),label = "Delete", class="butt3") ),
                                        ### Optional: a html button
                                        # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                        HTML('</div>') ),
                                 
                                 column(12,
                                        DT::DTOutput(ns("oeuTbl"))
                                 ),
                                 tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                 div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("oeu_Template_download"),label = "Download Template", class="butt5") ),
                                 tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                 tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;",
                                         fileInput2(inputId = ns("oeu_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                    accept = ".xlsx", multiple = F, width = "100px", progress = F))
                          )
                        )
               ),
               
               tabPanel(title = tagList("Operational Water Use", icon("arrow-circle-right")), value = "owu",
                        fluidRow(
                          column(width = 12,
                                 tags$div(title="This is Annual Emissions multiplied by Scheme Design Life",
                                          h4("Operational Water Use Emissions (tCO2e):  ", textOutput(outputId = ns("sum_owu_tCO2"), inline = T), tags$sup(icon("question-circle"))) #HTML("<sup>&#x2610;<sup/>"))
                                 ),
                                 h4("Scheme design life (years):  ", textOutput(outputId = ns("lifeTime2"), inline = T)),
                                 br(),
                                 # h5("Select rows to add to table:"),
                                 # splitLayout(numericInput(ns("owu_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                                 #             actionButton(inputId = ns("owu_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                 # rHandsontableOutput(ns("owuTbl")),
                                 # tags$style(type="text/css", paste0("#",ns("owuTbl"), rhandsontable_headstyle)),
                                 column(6,offset = 6,
                                        HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                        ### tags$head() This is to change the color of "Add a new row" button
                                        tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("owu_Add_row_head"),label = "Add", class="butt2") ),
                                        tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("owu_mod_row_head"),label = "Edit", class="butt4") ),
                                        tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("owu_Del_row_head"),label = "Delete", class="butt3") ),
                                        ### Optional: a html button
                                        # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                        HTML('</div>') ),
                                 
                                 column(12,
                                        DT::DTOutput(ns("owuTbl"))
                                 ),
                                 tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                 div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("owu_Template_download"),label = "Download Template", class="butt5") ),
                                 tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                 tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;",
                                         fileInput2(inputId = ns("owu_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                    accept = ".xlsx", multiple = F, width = "100px", progress = F))
                          )
                        )
               ),
               
               tabPanel(title = tagList("Operational Waste", icon("arrow-circle-right")), value = "owaste",
                        fluidRow(
                          column(width = 12,
                                 tags$div(title="This is Annual Emissions multiplied by Scheme Design Life",
                                          h4("Operational Waste Emissions (tCO2e):  ", textOutput(outputId = ns("sum_owaste_tCO2"), inline = T), tags$sup(icon("question-circle"))) #HTML("<sup>&#x2610;<sup/>"))
                                 ),
                                 h4("Scheme design life (years):  ", textOutput(outputId = ns("lifeTime3"), inline = T)),
                                 br(),
                                 # h5("Select rows to add to table:"),
                                 # splitLayout(numericInput(ns("owaste_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                                 #             actionButton(inputId = ns("owaste_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                 # rHandsontableOutput(ns("operwasteTbl")),
                                 # tags$style(type="text/css", paste0("#",ns("operwasteTbl"), rhandsontable_headstyle))
                                 column(6,offset = 6,
                                        HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                        ### tags$head() This is to change the color of "Add a new row" button
                                        tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("operwaste_Add_row_head"),label = "Add", class="butt2") ),
                                        tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("operwaste_mod_row_head"),label = "Edit", class="butt4") ),
                                        tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("operwaste_Del_row_head"),label = "Delete", class="butt3") ),
                                        ### Optional: a html button
                                        # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                        HTML('</div>') ),
                                 
                                 column(12,
                                        DT::DTOutput(ns("operwasteTbl"))
                                 ),
                                 tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                 div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("operwaste_Template_download"),label = "Download Template", class="butt5") ),
                                 tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                 tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;", 
                                         fileInput2(inputId = ns("operwaste_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                    accept = ".xlsx", multiple = F, width = "100px", progress = F))
                          )
                        )
                        
               ),
               
               # tabPanel(title = tagList("Maintenance Plant Fuel Use", icon("arrow-circle-right")), value = "maintfuel",
               #          fluidRow(
               #            column(width = 12,
               #                   tags$div(title="This is Annual Emissions multiplied by Scheme Design Life",
               #                            h4("Maintenance Plant Fuel Use Emissions (tCO2e):  ", textOutput(outputId = ns("sum_mpfu_tCO2"), inline = T), HTML("<sup>&#x2610;<sup/>"))
               #                   ),
               #                   h4("Scheme design life (years):  ", textOutput(outputId = ns("lifeTime4"), inline = T)),
               #                   rHandsontableOutput(ns("mpfuTbl")),
               #                   tags$style(type="text/css", paste0("#",ns("mpfuTbl"), rhandsontable_headstyle))
               #            )
               #          )
               # ),
               
               # tabPanel(title = tagList("Vehicle Use", icon("arrow-circle-right")), value = "vehicleuse",
               #          fluidRow(
               #            column(width = 12,
               #                   tags$div(title="This is Annual Emissions multiplied by Scheme Design Life",
               #                            h4("Vehicle Use Emissions (tCO2e):  ", textOutput(outputId = ns("sum_vehu_tCO2"), inline = T), HTML("<sup>&#x2610;<sup/>"))
               #                   ),
               #                   h4("Scheme design life (years):  ", textOutput(outputId = ns("lifeTime5"), inline = T)),
               #                   rHandsontableOutput(ns("vehuTbl")),
               #                   tags$style(type="text/css", paste0("#",ns("vehuTbl"), rhandsontable_headstyle))
               #            )
               #          )
               # ),
               
               tabPanel(title = tagList("Landscaping and Vegetation", icon("arrow-circle-right")), value = "landvegconstract",
                        fluidRow(
                          column(width = 12,
                                 h4("Landscaping and Vegetation Emissions (tCO2e):  ", textOutput(outputId = ns("sum_landv_tCO2"), inline = T)),
                                 HTML("<br> </br>"),
                                 # h5("Select rows to add to table:"),
                                 # splitLayout(numericInput(ns("lveg_add_n_rows"), label = NULL, value = 5, min = 1, max = 20),
                                 #             actionButton(inputId = ns("lveg_run_add_rows"), label = "Add rows"), cellWidths = c("10%", "90%")),
                                 # rHandsontableOutput(ns("landvegconstrTbl")),
                                 # tags$style(HTML(rhandsontable_headstyle))
                                 column(6,offset = 6,
                                        HTML('<div class="btn-group" role="group" aria-label="Basic example" style = "padding:10px">'),
                                        ### tags$head() This is to change the color of "Add a new row" button
                                        tags$head(tags$style(".butt2{background-color:#231651;} .butt2{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("landv_Add_row_head"),label = "Add", class="butt2") ),
                                        tags$head(tags$style(".butt4{background-color:#4d1566;} .butt4{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("landv_mod_row_head"),label = "Edit", class="butt4") ),
                                        tags$head(tags$style(".butt3{background-color:#590b25;} .butt3{color: #e6ebef;}")),
                                        div(style="display:inline-block;width:30%;text-align: center;",actionButton(inputId = ns("landv_Del_row_head"),label = "Delete", class="butt3") ),
                                        ### Optional: a html button
                                        # HTML('<input type="submit" name="Add_row_head" value="Add">'),
                                        HTML('</div>') ),
                                 
                                 column(12,
                                        DT::DTOutput(ns("landvegconstrTbl"))
                                 ),
                                 tags$head(tags$style(".butt5{background-color:#231651;} .butt5{color: #e6ebef;}")),
                                 div(style="display:inline-block;width:30%;text-align: center;",downloadButton(outputId = ns("landv_Template_download"),label = "Download Template", class="butt5") ),
                                 tags$head(tags$style(".fileinput_2 {width: 0.1px; height: 0.1px; opacity: 0; overflow: hidden; position: absolute; z-index: -1;}")),
                                 tags$li(class = "dropdown", style="display:inline-block;width:30%;text-align: center;",
                                         fileInput2(inputId = ns("landv_Template_upload"), label = "Upload from Template", labelIcon = "file-upload",
                                                    accept = ".xlsx", multiple = F, width = "100px", progress = F))
                          )
                        )
               ),
               
               tabPanel(title = tagList("Carbon Saving Opportunities", icon("check-circle")), value = "csavo",
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

use_server <- function(id, option_number, thetitle, theoutput, appR_returned, projectdetails_values){
  
  # Switch selection depending on Road or Rail Option
  if(stringr::str_detect(id, pattern = "ro[0-9]{1,2}$")){
    dropdown_options <- wasteTbl_dropdown_opts_road
    trans_mode_options <- transmodewasteTbl_dropdown_opts_road
    dropdown_options_landvegconstrTbl <- landvegconstrTbl_dropdown_opts_road
  } else if(stringr::str_detect(id, pattern = "ra[0-9]{1,2}$")){
    dropdown_options <- wasteTbl_dropdown_opts_rail
    trans_mode_options <- transmodewasteTbl_dropdown_opts_rail
    dropdown_options_landvegconstrTbl <- landvegconstrTbl_dropdown_opts_rail
  } else if(stringr::str_detect(id, pattern = "gw[0-9]{1,2}$")){
    dropdown_options <- wasteTbl_dropdown_opts_road
    trans_mode_options <- transmodewasteTbl_dropdown_opts_road
    dropdown_options_landvegconstrTbl <- landvegconstrTbl_dropdown_opts_road
  } else {
    print("No matching data")
  }
  
  ### Initial Waste Type values for DF waste tables
  waste_init_options <- dropdown_options %>% pull(`Waste Type`) %>% unique
  landveg_options_init <- dropdown_options_landvegconstrTbl %>% pull(`Carbon Sink`) %>% unique %>% stringr::str_sort(numeric = TRUE)
  
  # definition of data.tables for each use stage table
  DF_energyuse = data.table(`Energy Use Category` = "Lighting",
                            `Energy Type` = "Grid Electricity - Ireland",
                            `Annual Consumption` = c(0.0,0.0,0.0,0.0,0.0),
                            Unit = "kWh", 
                            `Annual Emissions tCO2e` = 0.0,
                            `Comments` = "",
                            stringsAsFactors = F, check.names = FALSE)
  
  DF_wateruse = data.table(`Water Use` = "Water Use - UK Average",
                           `Annual Water Consumption` = c(0.0,0.0,0.0,0.0,0.0),
                           `Unit` = "litres",
                           `Annual Emissions tCO2e` = 0.0,
                           `Comments` = "",
                           stringsAsFactors = F, check.names = FALSE)
  
  DF_operwaste = data.table(`Waste Type` = as.character(rep(waste_init_options[1], 5)), #+# change 5 to object defined in global.r
                              `Waste Route` = as.character(NA),
                              `Annual Quantity` = 0.0,
                              Unit = as.character(NA),
                              `Transport Mode` = as.character(NA),
                              `Annual Distance` = 0.0,
                              `Distance Unit` = as.character(NA),
                              `Waste Processing Carbon tCO2e` = 0.0,
                              `Transport tCO2e` = 0.0,
                              Comments = as.character(NA),
                              stringsAsFactors = F, check.names = FALSE)
  
  DF_landvegconstrTbl = data.table(`Vegetation Type` = rep(landveg_options_init[1], rhot_rows),
                                   Quantity = 0.0, 
                                   Unit = NA_character_, 
                                   `Carbon Sink tCO2e (added)` = 0.0,
                                   `Comments` = NA_character_,
                                   stringsAsFactors = F, check.names = F)
  
  DF_landvegconstrTbl = data.table(`Vegetation Type` = rep(landveg_options_init[1], rhot_rows),
                              Quantity = 0.0,
                              Unit = NA_character_,
                              `Carbon Sink tCO2e (added)` = 0.0,
                              `Comments` = NA_character_,
                              stringsAsFactors = F, check.names = F)
  
  # DF_mpfueluse = data.table(`Fuel Type` = "Grid Electricity - Ireland",
  #                           `Annual Quantity` = c(0.0,0.0,0.0,0.0,0.0),
  #                           Unit = "kWh", 
  #                           `Annual Emissions tCO2e` = 0.0,
  #                           `Comments` = "",
  #                           stringsAsFactors = F, check.names = FALSE)
  # 
  # DF_vehuse = data.table(`REM Outputs: Do Nothing Scenario (tCO2e)` = c(0.0,0.0,0.0,0.0,0.0),
  #                        `REM Outputs: Do Something Scenario (tCO2e)` = 0.0,
  #                        `Difference DS-DN Scenarios (tCO2e)` = 0.0, 
  #                        #`Time period covered by REM data (years)` = 0.0,
  #                        `Comments` = "",
  #                        stringsAsFactors = F, check.names = FALSE)
  
  
  DF_csavoNoImpl = data.table(`Description of options and how they will lead to carbon savings` = c("","","","",""), 
                              `Rationale for why the option has not been taken forward for implementation` = c("","","","",""), stringsAsFactors = F, check.names = FALSE)
  
  DF_csavoImpl = data.table(`Description of options and how they will lead to carbon savings` = c("","","","",""), 
                            `Rationale for implementation` = c("","","","",""), stringsAsFactors = F, check.names = FALSE)
  
  
  oeuvalues <- reactiveValues(data=DF_energyuse)
  owuvalues <- reactiveValues(data=DF_wateruse)
  operwastevalues <- reactiveValues(data=DF_operwaste)
  landvegconstrvalues <- reactiveValues(data=DF_landvegconstrTbl)
  #mpfuvalues <- reactiveValues(data=DF_mpfueluse)
  #vehuvalues <- reactiveValues(data=DF_vehuse)
  csavoNoImplvalues <- reactiveValues(data=DF_csavoNoImpl)
  csavoImplvalues <- reactiveValues(data=DF_csavoImpl)
  
  
  sum_oeu_tCO2 <- reactiveValues(data=0.0) # sum(DF_energyuse$`Emissions tCO2e`))
  sum_owu_tCO2 <- reactiveValues(data=0.0) # sum(DF_wateruse$`Emissions tCO2e`))
  sum_owaste_tCO2 <- reactiveValues(data=0.0)
  sum_owaste_trans_tCO2 <- reactiveValues(data=0.0)
  sum_landv_tCO2 <- reactiveValues(data=0.0)
  #sum_mpfu_tCO2 <- reactiveValues(data=0.0) # sum(DF_mpfueluse$`Emissions tCO2e`))
  #sum_vehu_tCO2 <- reactiveValues(data=0.0) # sum(DF_vehuse$`Difference DS-DN Scenarios (tCO2e)`))
  
  sum_use_tCO2 <- reactiveValues(data=0.0)
  
  
  DF_returned <- data.table(Option = rep(option_number, 6), # c(option_number, option_number, option_number, option_number, option_number),
                            Stage = rep("Operational Use", 6), # c("Use","Use","Use","Use","Use"),
                            Measure = c("Energy Use","Water Use","Operational Waste Disposal","Operational Waste Transport","Landscaping and Vegetation",
                                        "Total"), # "Maintenance Plant Fuel Use","Vehicle Use",
                            Value = rep(0.0, 6), # c(0.0,0.0,0.0,0.0,0.0),
                            stringsAsFactors = F, check.names = FALSE)
  
  use_returned <- reactiveValues(data=DF_returned,
                                 carbsavenotimp=data.table(Option = stringr::str_sub(id, start = -1), 
                                                           Stage = c("Use"),
                                                           Description = c(""), Rationale = c("")),
                                 carbsaveimp=data.table(Option = stringr::str_sub(id, start = -1),
                                                        Stage = c("Use"),
                                                        Description = c(""), Rationale = c("")),
                                 oeuTblResave = DF_energyuse,
                                 owuTblResave = DF_wateruse,
                                 operwasteTblResave = DF_operwaste,
                                 landvegconstrTblResave = DF_landvegconstrTbl,
                                 csavoNoImplTblResave = DF_csavoNoImpl,
                                 csavoImplTblResave = DF_csavoImpl)
  
  
  moduleServer(id,
               function(input, output, session){
                 
                 ns <- session$ns
                 
                 # Sum of total carbon emissions for each activity type
                 output$sum_oeu_tCO2<- renderText({formatC(round(sum_oeu_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 output$sum_owu_tCO2<- renderText({formatC(round(sum_owu_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 output$sum_owaste_tCO2 <- renderText({formatC(round(sum(sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data), digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 
                 #output$sum_mpfu_tCO2<- renderText({formatC(round(sum_mpfu_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 #output$sum_vehu_tCO2<- renderText({formatC(round(sum_vehu_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 
                 output$sum_landv_tCO2 <- renderText({formatC(round(sum_landv_tCO2$data, digits = Emissions_DPlaces_tabs), format="f", digits = Emissions_DPlaces_tabs, big.mark=',')})
                 
                 output$sum_use_tCO2<- renderText({formatC(round(sum_use_tCO2$data, digits = Emissions_DPlaces_menus), format="f", digits = Emissions_DPlaces_menus, big.mark=',')})
                 
                 output$some_title <- renderText({thetitle})
                 
                 
                 output$lifeTime1 <- reactive({projectdetails_values$lifeTime})
                 output$lifeTime2 <- reactive({projectdetails_values$lifeTime})
                 output$lifeTime3 <- reactive({projectdetails_values$lifeTime})
                 #output$lifeTime4 <- reactive({projectdetails_values$lifeTime})
                 #output$lifeTime5 <- reactive({projectdetails_values$lifeTime})
                 
                 
                 # Observe Event on load button click (via global reactive expression) - clears rhandsontable once on press
                 observeEvent(appR_returned$loadReact, {
                   #if (id == "usero1"){browser()}
                   print("ObserveEvent   USE   appR_returned$loadReact")
                   oeuvalues$data = DF_energyuse
                   owuvalues$data = DF_wateruse
                   landvegconstrvalues$data = DF_landvegconstrTbl
                   #mpfuvalues$data = DF_mpfueluse
                   #vehuvalues$data = DF_vehuse
                   csavoNoImplvalues$data = DF_csavoNoImpl
                   csavoImplvalues$data = DF_csavoImpl
                   
                   sum_oeu_tCO2$data = 0.0
                   sum_owu_tCO2$data = 0.0
                   sum_owaste_tCO2$data = 0.0
                   sum_owaste_trans_tCO2$data = 0.0
                   sum_landv_tCO2$data = 0.0
                   #sum_mpfu_tCO2$data = 0.0
                   #sum_vehu_tCO2$data = 0.0
                   sum_use_tCO2$data = 0.0
                   use_returned$data$Value = c(0.0,0.0,0.0,0.0,0.0,0.0) # c(0.0,0.0,0.0,0.0,0.0,0.0,0.0)
                   
                   use_returned$carbsaveimp$Description = c("")
                   use_returned$carbsaveimp$Rationale = c("")
                   use_returned$carbsavenotimp$Description = c("")
                   use_returned$carbsavenotimp$Rationale = c("")
                   
                   
                   if (is.null(appR_returned$data[[paste0(id,"_oeuTbl")]])){
                     print("LOAD DATA IS NULL")
                   } else {
                   
                   
                   # Load data from the load file into rhandsontables and reactivevalues
                   tmpData <- appR_returned$data[[paste0(id,"_oeuTbl")]]
                   colnames(tmpData) <- colnames(DF_energyuse)
                   tmpData$`Comments` <- as.character(tmpData$`Comments`)
                   tmpData$Unit <- as.character(tmpData$Unit)
                   oeuvalues$data <- tmpData
                   use_returned$oeuTblResave = tmpData
                   
                   sum_oeu_tCO2$data = sum(na.omit(tmpData$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime
                   
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_owuTbl")]]
                   colnames(tmpData) <- colnames(DF_wateruse)
                   tmpData$`Comments` <- as.character(tmpData$`Comments`)
                   tmpData$Unit <- as.character(tmpData$Unit)
                   owuvalues$data <- tmpData
                   use_returned$owuTblResave = tmpData
                   
                   sum_owu_tCO2$data = sum(na.omit(tmpData$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime
                   
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_operwasteTbl")]]
                   colnames(tmpData) <- colnames(DF_operwaste)
                   tmpData$Comments <- as.character(tmpData$Comments)
                   tmpData$Unit <- as.character(tmpData$Unit)
                   tmpData$`Distance Unit` <- as.character(tmpData$`Distance Unit`)
                   operwastevalues$data <- tmpData
                   use_returned$operwasteTblResave = tmpData
                   
                   sum_owaste_tCO2$data = sum(na.omit(tmpData$`Waste Processing Carbon tCO2e`)) * projectdetails_values$lifeTime
                   sum_owaste_trans_tCO2$data = sum(na.omit(tmpData$`Transport tCO2e`)) * projectdetails_values$lifeTime
                   
                   #
                   tmpData <- appR_returned$data[[paste0(id,"_landvegconstrTbl")]]
                   colnames(tmpData) <- colnames(DF_landvegconstrTbl)
                   tmpData$Unit <- as.character(tmpData$Unit)
                   tmpData$`Comments` <- as.character(tmpData$`Comments`)
                   landvegconstrvalues$data <- tmpData
                   use_returned$landvegconstrTblResave = tmpData

                   sum_landv_tCO2$data = sum(na.omit(as.numeric(tmpData$`Carbon Sink tCO2e (added)`))) * -1.0 # get carbon emissions
                   
                   
                  
                   
                   
                   
                   # tmpData <- appR_returned$data[[paste0(id,"_mpfuTbl")]]
                   # colnames(tmpData) <- colnames(DF_mpfueluse)
                   # tmpData$`Comments` <- as.character(tmpData$`Comments`)
                   # tmpData$Unit <- as.character(tmpData$Unit)
                   # mpfuvalues$data <- tmpData
                   # use_returned$mpfuTblResave = tmpData
                   # 
                   # sum_mpfu_tCO2$data = sum(na.omit(tmpData$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime
                   
                   
                   
                   # tmpData <- appR_returned$data[[paste0(id,"_vehuTbl")]]
                   # colnames(tmpData) <- colnames(DF_vehuse)
                   # tmpData$`Comments` <- as.character(tmpData$`Comments`)
                   # vehuvalues$data <- tmpData
                   # use_returned$vehuTblResave = tmpData
                   # 
                   # sum_vehu_tCO2$data = sum(na.omit(tmpData$`Difference DS-DN Scenarios (tCO2e)`)) * projectdetails_values$lifeTime
                   
                   
                   sum_use_tCO2$data = sum(sum_oeu_tCO2$data,
                                           sum_owu_tCO2$data,
                                           sum_owaste_tCO2$data,
                                           sum_owaste_trans_tCO2$data,
                                           sum_landv_tCO2$data
                                           #sum_mpfu_tCO2$data,
                                           #sum_vehu_tCO2$data
                                           )
                   
                   use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data,
                                               #sum_mpfu_tCO2$data, sum_vehu_tCO2$data,
                                               sum_use_tCO2$data)
                   
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_csavoNoImplTbl")]]
                   colnames(tmpData) <- colnames(DF_csavoNoImpl)
                   tmpData <- transform(tmpData, `Description of options and how they will lead to carbon savings` = as.character(`Description of options and how they will lead to carbon savings`),
                                        `Rationale for why the option has not been taken forward for implementation` = as.character(`Rationale for why the option has not been taken forward for implementation`))
                   colnames(tmpData) <- colnames(DF_csavoNoImpl)
                   use_returned$csavoNoImplTblResave <- tmpData
                   csavoNoImplvalues$data <- tmpData
                   
                   tmpdat <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(tmpData)),
                                        Stage = rep("Use", nrow(tmpData)))
                   tmpdat[, `:=` (Description = tmpData$`Description of options and how they will lead to carbon savings`,
                                  Rationale = tmpData$`Rationale for why the option has not been taken forward for implementation`)]
                   use_returned$carbsavenotimp = tmpdat
                   
                   
                   
                   tmpData <- appR_returned$data[[paste0(id,"_csavoImplTbl")]]
                   colnames(tmpData) <- colnames(DF_csavoImpl)
                   tmpData <- transform(tmpData, `Description of options and how they will lead to carbon savings` = as.character(`Description of options and how they will lead to carbon savings`),
                                        `Rationale for implementation` = as.character(`Rationale for implementation`))
                   colnames(tmpData) <- colnames(DF_csavoImpl)
                   use_returned$csavoImplTblResave <- tmpData
                   csavoImplvalues$data <- tmpData
                   
                   tmpdat <- data.table(Option = rep(stringr::str_sub(id, start = -1), nrow(tmpData)),
                                        Stage = rep("Use", nrow(tmpData)))
                   tmpdat[, `:=` (Description = tmpData$`Description of options and how they will lead to carbon savings`,
                                  Rationale = tmpData$`Rationale for implementation`)]
                   use_returned$carbsaveimp = tmpdat
                   
                   }
                   
                 })
                 
                 
                 ### add rows
                 
                 # observeEvent(input$oeu_run_add_rows, {
                 #   #
                 #   tmpData <- as.data.frame(hot_to_r(input$oeuTbl))
                 #   
                 #   n_rows_to_add <- input$oeu_add_n_rows
                 #   
                 #   df_to_add = data.table(`Energy Use Category` = "Lighting",
                 #                          `Energy Type` = "Grid Electricity - Ireland",
                 #                          `Annual Consumption` = c(0.0),
                 #                          Unit = "kWh", 
                 #                          `Annual Emissions tCO2e` = 0.0,
                 #                          `Comments` = "",
                 #                          stringsAsFactors = F, check.names = FALSE) %>%
                 #     slice(rep(1:n(), each = n_rows_to_add))
                 #   
                 #   tmpData <- rbind(tmpData, df_to_add)
                 #   oeuvalues$data <- tmpData
                 #   
                 # })	
                 
                 # observeEvent(input$owu_run_add_rows, {
                 #   #
                 #   tmpData <- as.data.frame(hot_to_r(input$owuTbl))
                 #   
                 #   n_rows_to_add <- input$owu_add_n_rows
                 #   
                 #   df_to_add = data.table(`Water Use` = "Water Use - UK Average",
                 #                          `Annual Water Consumption` = c(0.0),
                 #                          `Unit` = "litres",
                 #                          `Annual Emissions tCO2e` = 0.0,
                 #                          `Comments` = "",
                 #                          stringsAsFactors = F, check.names = FALSE) %>%
                 #     slice(rep(1:n(), each = n_rows_to_add))
                 #   
                 #   tmpData <- rbind(tmpData, df_to_add)
                 #   owuvalues$data <- tmpData
                 #   
                 # })
                 
                 # observeEvent(input$owaste_run_add_rows, {
                 #   #
                 #   tmpData <- as.data.frame(hot_to_r(input$operwasteTbl))
                 #   
                 #   n_rows_to_add <- input$owaste_add_n_rows
                 #   
                 #   df_to_add = data.table(`Waste Type` = as.character(rep(waste_init_options[1], n_rows_to_add)), #+# change 5 to object defined in global.r
                 #                          `Waste Route` = as.character(NA),
                 #                          `Annual Quantity` = 0.0,
                 #                          Unit = as.character(NA),
                 #                          `Transport Mode` = as.character(NA),
                 #                          `Annual Distance` = 0.0,
                 #                          `Distance Unit` = as.character(NA),
                 #                          `Waste Processing Carbon tCO2e` = 0.0,
                 #                          `Transport tCO2e` = 0.0,
                 #                          Comments = as.character(NA),
                 #                          stringsAsFactors = F, check.names = FALSE)
                 #   
                 #   tmpData <- rbind(tmpData, df_to_add)
                 #   operwastevalues$data <- tmpData
                 #   
                 # })
                 
                 # observeEvent(input$lveg_run_add_rows, {
                 #   #
                 #   tmpData <- as.data.frame(hot_to_r(input$landvegconstrTbl))
                 #   
                 #   n_rows_to_add <- input$lveg_add_n_rows
                 #   
                 #   df_to_add = data.table(`Vegetation Type` = rep(landveg_options_init[1], n_rows_to_add),
                 #                          Quantity = 0.0, 
                 #                          Unit = NA_character_, 
                 #                          `Carbon Sink tCO2e (added)` = 0.0,
                 #                          `Comments` = NA_character_,
                 #                          stringsAsFactors = F, check.names = F)
                 #   
                 #   tmpData <- rbind(tmpData, df_to_add)
                 #   landvegconstrvalues$data <- tmpData
                 #   
                 # })
                 
                 
                 # Operational Energy Use - change to datatables ----
                 output$oeuTbl <- DT::renderDT({
                   DT = oeuvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(5), currency = "", interval = 3, mark = ",", digits = 3)
                 })
                 
                 observeEvent(input$oeu_Add_row_head, {
                   ### This is the pop up board for input a new row
                   # browser()
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("oeu_add_col1"), label = "Energy Use Category", choices = use_oeu_en_use_cat_dropdown),
                     selectizeInput(ns("oeu_add_col2"), label = "Energy Type", choices = use_oeu_energytype_dropdown),
                     numericInput(ns("oeu_add_col3"), label = "Annual Consumption", value = 0),
                     uiOutput(ns("oeu_add_col4_out")),
                     #selectizeInput(ns("oeu_add_col4"), label = "Unit", choices = c("kWh (Net CV)","Litre","Tonnes")),
                     textInput(ns("oeu_add_col5"), label = "Comments"),
                     actionButton(ns("oeu_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                   
                 })
                 
                 observeEvent(input$oeu_add_row_go, {
                   #browser()
                   new_row = data.frame(input$oeu_add_col1,
                                        input$oeu_add_col2,
                                        input$oeu_add_col3,
                                        input$oeu_add_col4,
                                        "Annual Emissions tCO2e" = 0,
                                        input$oeu_add_col5) %>%
                     dplyr::left_join(., efs$Fuel[, c("Fuel","kgCO2e per unit")], by = c("input.oeu_add_col2" = "Fuel")) %>%
                     dplyr::mutate(`Annual.Emissions.tCO2e` = input.oeu_add_col3 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   oeuvalues$data <- data.table(rbind(oeuvalues$data, new_row, use.names = F))
                   sum_oeu_tCO2$data <- sum(na.omit(oeuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime
                   
                   sum_use_tCO2$data = sum(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data)
                   use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data,
                                               sum_use_tCO2$data)
                   use_returned$oeuTblResave <- oeuvalues$data
                   removeModal()
                 })
                 
                 output$oeu_add_col4_out <- renderUI({
                   selectizeInput(ns("oeu_add_col4"), label = "Unit", choices = oeu_unit_choices())
                 })
                 
                 oeu_unit_choices <- reactive({
                   unit_options <- efs$Fuel %>% 
                     filter(`Fuel` == input$oeu_add_col2) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 
                 
                 observeEvent(input$oeu_Del_row_head,{
                   showModal(
                     if(length(input$oeuTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$oeuTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("oeu_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$oeu_del_row_ok, {
                   #browser()
                   oeuvalues$data=oeuvalues$data[-input$oeuTbl_rows_selected,]
                   sum_oeu_tCO2$data <- sum(na.omit(oeuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime
                   
                   sum_use_tCO2$data = sum(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data)
                   use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data,
                                               sum_use_tCO2$data)
                   use_returned$oeuTblResave <- oeuvalues$data
                   removeModal()
                 })
                 
                 observeEvent(input$oeu_mod_row_head,{
                   showModal(
                     if(length(input$oeuTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         
                         selectizeInput(ns("oeu_mod_col1"), label = "Energy Use Category", choices = use_oeu_en_use_cat_dropdown,
                                        selected = oeuvalues$data[input$oeuTbl_rows_selected,1]),
                         selectizeInput(ns("oeu_mod_col2"), label = "Energy Type", choices = use_oeu_energytype_dropdown,
                                        selected = oeuvalues$data[input$oeuTbl_rows_selected,2]),
                         numericInput(ns("oeu_mod_col3"), label = "Annual Consumption", value = oeuvalues$data[input$oeuTbl_rows_selected,3]),
                         uiOutput(ns("oeu_mod_col4_out")),
                         #selectizeInput(ns("oeu_add_col4"), label = "Unit", choices = c("kWh (Net CV)","Litre","Tonnes")),
                         textInput(ns("oeu_mod_col5"), label = "Comments", value = oeuvalues$data[input$oeuTbl_rows_selected,6]),
                         
                         hidden(numericInput(ns("oeu_mod_rown"), value = input$oeuTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("oeu_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 output$oeu_mod_col4_out <- renderUI({
                   selectizeInput(ns("oeu_mod_col4"), label = "Unit", choices = oeu_unit_choices_mod())
                 })
                 
                 oeu_unit_choices_mod <- reactive({
                   unit_options <- efs$Fuel %>% 
                     filter(`Fuel` == input$oeu_mod_col2) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 
                 observeEvent(input$oeu_confirm_mod, {
                   #browser()
                   new_row = data.frame(input$oeu_mod_col1,
                                        input$oeu_mod_col2,
                                        input$oeu_mod_col3,
                                        input$oeu_mod_col4,
                                        "Annual Emissions tCO2e" = 0,
                                        input$oeu_mod_col5) %>%
                     dplyr::left_join(., efs$Fuel[, c("Fuel","kgCO2e per unit")], by = c("input.oeu_mod_col2" = "Fuel")) %>%
                     dplyr::mutate(`Annual.Emissions.tCO2e` = input.oeu_mod_col3 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   oeuvalues$data[input$oeu_mod_rown,] <- new_row
                   sum_oeu_tCO2$data <- sum(na.omit(oeuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime
                   
                   sum_use_tCO2$data = sum(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data)
                   use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data,
                                               sum_use_tCO2$data)
                   
                   use_returned$oeuTblResave <- oeuvalues$data
                   ###use_returned$data$oeuTbl_returned <- oeuvalues$data
                   removeModal()
                 })
                 
                 
                 output$oeu_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_Operational_Energy.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_Operational_Energy.xlsx",to = file)}
                 )
                 
                 observeEvent(input$oeu_Template_upload$name, {
                   
                   templateIn <- readxl::read_xlsx(input$oeu_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:3], names(oeuvalues$data)[1:3])){
                     
                     if (typeof(templateIn$`Annual Consumption`) == "character"){templateIn$`Annual Consumption` <- as.numeric(templateIn$`Annual Consumption`)}
                     
                     templateIn_data <- bind_rows(oeuvalues$data, templateIn) %>%
                       dplyr::left_join(., efs$Fuel[, c("Fuel","kgCO2e per unit")], by = c("Energy Type" = "Fuel")) %>%
                       dplyr::mutate(`Annual Emissions tCO2e` = `Annual Consumption` * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::filter(`Annual Consumption` > 0)
                     
                     oeuvalues$data <- templateIn_data
                     
                     sum_oeu_tCO2$data <- sum(na.omit(oeuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime
                     
                     sum_use_tCO2$data = sum(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data)
                     use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data,
                                                 sum_use_tCO2$data)
                     use_returned$oeuTblResave <- oeuvalues$data
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })
                 
                 
                 # Operational Water Use - change to datatables ----
                 output$owuTbl <- DT::renderDT({
                   DT = owuvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(4), currency = "", interval = 3, mark = ",", digits = 3)
                 })
                 
                 observeEvent(input$owu_Add_row_head, {
                   ### This is the pop up board for input a new row
                   # browser()
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("owu_add_col1"), label = "Water Use", choices = c("Water Use - UK Average")),
                     numericInput(ns("owu_add_col2"), label = "Annual Water Consumption", value = 0),
                     selectizeInput(ns("owu_add_col3"), label = "Unit", choices = c("litres")),
                     textInput(ns("owu_add_col4"), label = "Comments"),
                     actionButton(ns("owu_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$owu_add_row_go, {
                   #browser()
                   new_row = data.frame(input$owu_add_col1,
                                        input$owu_add_col2,
                                        input$owu_add_col3,
                                        "Annual Emissions tCO2e" = 0,
                                        input$owu_add_col4) %>%
                     dplyr::left_join(., efs$Water[, c("Water","kgCO2e per unit")], by = c("input.owu_add_col1" = "Water")) %>%
                     dplyr::mutate(`Annual.Emissions.tCO2e` = input.owu_add_col2 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   owuvalues$data <- data.table(rbind(owuvalues$data, new_row, use.names = F))
                   sum_owu_tCO2$data <- sum(na.omit(owuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime
                   
                   sum_use_tCO2$data = sum(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data)
                   use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data,
                                               sum_use_tCO2$data)
                   use_returned$owuTblResave <- owuvalues$data
                   removeModal()
                 })
                 
                 observeEvent(input$owu_Del_row_head,{
                   showModal(
                     if(length(input$owuTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$owuTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("owu_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$owu_del_row_ok, {
                   #browser()
                   owuvalues$data=owuvalues$data[-input$owuTbl_rows_selected,]
                   sum_owu_tCO2$data <- sum(na.omit(owuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime
                   
                   sum_use_tCO2$data = sum(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data)
                   use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data,
                                               sum_use_tCO2$data)
                   use_returned$owuTblResave <- owuvalues$data
                   removeModal()
                 })
                 
                 observeEvent(input$owu_mod_row_head,{
                   showModal(
                     if(length(input$owuTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         
                         selectizeInput(ns("owu_mod_col1"), label = "Water Use", choices = c("Water Use - UK Average")),
                         numericInput(ns("owu_mod_col2"), label = "Annual Water Consumption", value = owuvalues$data[input$owuTbl_rows_selected,2]),
                         selectizeInput(ns("owu_mod_col3"), label = "Unit", choices = c("litres")),
                         textInput(ns("owu_mod_col4"), label = "Comments", value = owuvalues$data[input$owuTbl_rows_selected,5]),
                         
                         hidden(numericInput(ns("owu_mod_rown"), value = input$owuTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("owu_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$owu_confirm_mod, {
                   #browser()
                   new_row = data.frame(input$owu_mod_col1,
                                        input$owu_mod_col2,
                                        input$owu_mod_col3,
                                        "Annual Emissions tCO2e" = 0,
                                        input$owu_mod_col4) %>%
                     dplyr::left_join(., efs$Water[, c("Water","kgCO2e per unit")], by = c("input.owu_mod_col1" = "Water")) %>%
                     dplyr::mutate(`Annual.Emissions.tCO2e` = input.owu_mod_col2 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   owuvalues$data[input$owu_mod_rown,] <- new_row
                   sum_owu_tCO2$data <- sum(na.omit(owuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime
                   
                   sum_use_tCO2$data = sum(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data)
                   use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data,
                                               sum_use_tCO2$data)
                   
                   use_returned$owuTblResave <- owuvalues$data
                   
                   removeModal()
                 })
                 
                 
                 output$owu_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_Operational_Water.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_Operational_Water.xlsx",to = file)}
                 )
                 
                 observeEvent(input$owu_Template_upload$name, {
                   
                   templateIn <- readxl::read_xlsx(input$owu_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:3], names(owuvalues$data)[1:3])){
                     
                     if (typeof(templateIn$`Annual Water Consumption`) == "character"){templateIn$`Annual Water Consumption` <- as.numeric(templateIn$`Annual Water Consumption`)}
                     
                     templateIn_data <- bind_rows(owuvalues$data, templateIn) %>%
                       dplyr::left_join(., efs$Water[, c("Water","kgCO2e per unit")], by = c("Water Use" = "Water")) %>%
                       dplyr::mutate(`Annual Emissions tCO2e` = `Annual Water Consumption` * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::filter(`Annual Water Consumption` > 0)
                     
                     owuvalues$data <- templateIn_data
                     
                     sum_owu_tCO2$data <- sum(na.omit(owuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime
                     sum_use_tCO2$data = sum(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data)
                     use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data,
                                                 sum_use_tCO2$data)
                     use_returned$owuTblResave <- owuvalues$data
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })
                 
                 
                 # Operational Waste - change to datatables ----
                 output$operwasteTbl <- DT::renderDT({
                   DT = operwastevalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(8,9), currency = "", interval = 3, mark = ",", digits = 3)
                 })
                 
                 observeEvent(input$operwaste_Add_row_head, {
                   ### This is the pop up board for input a new row
                   # browser()
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("operwaste_add_col1"), label = "Waste Type", choices = waste_init_options),
                     uiOutput(ns("operwaste_add_col2_out")),
                     numericInput(ns("operwaste_add_col3"), label = "Quantity", value = 0),
                     uiOutput(ns("operwaste_add_col4_out")),
                     selectizeInput(ns("operwaste_add_col5"), label = "Mode", choices = trans_mode_options$Vehicle),
                     numericInput(ns("operwaste_add_col6"), label = "Distance", value = 0),
                     uiOutput(ns("operwaste_add_col7_out")),
                     textInput(ns("operwaste_add_col8"), label = "Comments"),
                     actionButton(ns("operwaste_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                 })
                 
                 observeEvent(input$operwaste_add_row_go, {
                   #browser()
                   new_row = data.frame(input$operwaste_add_col1,
                                        input$operwaste_add_col2,
                                        input$operwaste_add_col3,
                                        input$operwaste_add_col4,
                                        input$operwaste_add_col5,
                                        input$operwaste_add_col6,
                                        input$operwaste_add_col7,
                                        "Waste Processing Carbon tCO2e" = 0,
                                        "Transport tCO2e" = 0,
                                        input$operwaste_add_col8) %>%
                     dplyr::left_join(., efs$Waste[, c("Waste Type","Waste Route","kgCO2e per unit")],
                                      by = c("input.operwaste_add_col1"="Waste Type", "input.operwaste_add_col2"="Waste Route")) %>%
                     dplyr::mutate(`Waste.Processing.Carbon.tCO2e` = input.operwaste_add_col3 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`) %>%
                     dplyr::left_join(., efs$Vehicle[, c("Vehicle","kgCO2e per unit")], by = c("input.operwaste_add_col5"="Vehicle")) %>%
                     dplyr::mutate(`Transport.tCO2e` = input.operwaste_add_col6 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   operwastevalues$data <- data.table(rbind(operwastevalues$data, new_row, use.names = F))
                   
                   sum_owaste_tCO2$data <- sum(na.omit(as.numeric(operwastevalues$data$`Waste Processing Carbon tCO2e`))) * projectdetails_values$lifeTime
                   sum_owaste_trans_tCO2$data <- sum(na.omit(as.numeric(operwastevalues$data$`Transport tCO2e`))) * projectdetails_values$lifeTime
                   
                   sum_use_tCO2$data = sum(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data)
                   
                   use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data,
                                               sum_use_tCO2$data)
                   use_returned$operwasteTblResave = operwastevalues$data
                   removeModal()
                 })
                 
                 output$operwaste_add_col2_out <- renderUI({
                   selectizeInput(ns("operwaste_add_col2"), label = "Waste Route", choices = operwaste_wasteroute_choices())
                 })
                 
                 operwaste_wasteroute_choices <- reactive({
                   wasteroute_options <- efs$Waste %>% 
                     filter(`Waste Type` == input$operwaste_add_col1) %>%
                     select(`Waste Route`) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 output$operwaste_add_col4_out <- renderUI({
                   selectizeInput(ns("operwaste_add_col4"), label = "Unit", choices = operwaste_unit_choices())
                 })
                 
                 operwaste_unit_choices <- reactive({
                   unit_options <- efs$Waste %>% 
                     filter(`Waste Type` == input$operwaste_add_col1) %>%
                     filter(`Waste Route` == input$operwaste_add_col2) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 output$operwaste_add_col7_out <- renderUI({
                   selectizeInput(ns("operwaste_add_col7"), label = "Distance Unit", choices = operwaste_distunit_choices())
                 })
                 
                 operwaste_distunit_choices <- reactive({
                   unit_options <- efs$Vehicle %>% 
                     filter(`Vehicle` == input$operwaste_add_col5) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 
                 observeEvent(input$operwaste_Del_row_head,{
                   showModal(
                     if(length(input$operwasteTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$operwasteTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("operwaste_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$operwaste_del_row_ok, {
                   
                   operwastevalues$data=operwastevalues$data[-input$operwasteTbl_rows_selected,]
                   
                   sum_owaste_tCO2$data <- sum(na.omit(as.numeric(operwastevalues$data$`Waste Processing Carbon tCO2e`))) * projectdetails_values$lifeTime
                   sum_owaste_trans_tCO2$data <- sum(na.omit(as.numeric(operwastevalues$data$`Transport tCO2e`))) * projectdetails_values$lifeTime
                   
                   sum_use_tCO2$data = sum(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data)
                   
                   use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data,
                                               sum_use_tCO2$data)
                   use_returned$operwasteTblResave = operwastevalues$data
                   removeModal()
                 })
                 
                 observeEvent(input$operwaste_mod_row_head,{
                   showModal(
                     if(length(input$operwasteTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         
                         selectizeInput(ns("operwaste_mod_col1"), label = "Waste Type", choices = waste_init_options,
                                        selected = operwastevalues$data[input$operwasteTbl_rows_selected,1]),
                         uiOutput(ns("operwaste_mod_col2_out")),
                         numericInput(ns("operwaste_mod_col3"), label = "Quantity", value = operwastevalues$data[input$operwasteTbl_rows_selected,3]),
                         uiOutput(ns("operwaste_mod_col4_out")),
                         selectizeInput(ns("operwaste_mod_col5"), label = "Mode", choices = trans_mode_options$Vehicle,
                                        selected = operwastevalues$data[input$operwasteTbl_rows_selected,5]),
                         numericInput(ns("operwaste_mod_col6"), label = "Distance", value = operwastevalues$data[input$operwasteTbl_rows_selected,6]),
                         uiOutput(ns("operwaste_mod_col7_out")),
                         textInput(ns("operwaste_mod_col8"), label = "Comments", value = operwastevalues$data[input$operwasteTbl_rows_selected,10]),
                         
                         hidden(numericInput(ns("operwaste_mod_rown"), value = input$operwasteTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("operwaste_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 output$operwaste_mod_col2_out <- renderUI({
                   selectizeInput(ns("operwaste_mod_col2"), label = "Waste Route", choices = operwaste_wasteroute_choices_mod())
                 })
                 
                 operwaste_wasteroute_choices_mod <- reactive({
                   wasteroute_options <- efs$Waste %>% 
                     filter(`Waste Type` == input$operwaste_mod_col1) %>%
                     select(`Waste Route`) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 output$operwaste_mod_col4_out <- renderUI({
                   selectizeInput(ns("operwaste_mod_col4"), label = "Unit", choices = operwaste_unit_choices_mod())
                 })
                 
                 operwaste_unit_choices_mod <- reactive({
                   unit_options <- efs$Waste %>% 
                     filter(`Waste Type` == input$operwaste_mod_col1) %>%
                     filter(`Waste Route` == input$operwaste_mod_col2) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 output$operwaste_mod_col7_out <- renderUI({
                   selectizeInput(ns("operwaste_mod_col7"), label = "Distance Unit", choices = operwaste_distunit_choices_mod())
                 })
                 
                 operwaste_distunit_choices_mod <- reactive({
                   unit_options <- efs$Vehicle %>% 
                     filter(`Vehicle` == input$operwaste_mod_col5) %>%
                     select(Unit) %>% distinct() %>% pull() %>%
                     stringr::str_sort(numeric = TRUE)
                 })
                 
                 
                 observeEvent(input$operwaste_confirm_mod, {
                   #browser()
                   new_row = data.frame(input$operwaste_mod_col1,
                                        input$operwaste_mod_col2,
                                        input$operwaste_mod_col3,
                                        input$operwaste_mod_col4,
                                        input$operwaste_mod_col5,
                                        input$operwaste_mod_col6,
                                        input$operwaste_mod_col7,
                                        "Waste Processing Carbon tCO2e" = 0,
                                        "Transport tCO2e" = 0,
                                        input$operwaste_mod_col8) %>%
                     dplyr::left_join(., efs$Waste[, c("Waste Type","Waste Route","kgCO2e per unit")],
                                      by = c("input.operwaste_mod_col1"="Waste Type", "input.operwaste_mod_col2"="Waste Route")) %>%
                     dplyr::mutate(`Waste.Processing.Carbon.tCO2e` = input.operwaste_mod_col3 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`) %>%
                     dplyr::left_join(., efs$Vehicle[, c("Vehicle","kgCO2e per unit")], by = c("input.operwaste_mod_col5"="Vehicle")) %>%
                     dplyr::mutate(`Transport.tCO2e` = input.operwaste_mod_col6 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   operwastevalues$data[input$operwaste_mod_rown,] <- new_row

                   sum_owaste_tCO2$data <- sum(na.omit(as.numeric(operwastevalues$data$`Waste Processing Carbon tCO2e`))) * projectdetails_values$lifeTime
                   sum_owaste_trans_tCO2$data <- sum(na.omit(as.numeric(operwastevalues$data$`Transport tCO2e`))) * projectdetails_values$lifeTime
                   
                   sum_use_tCO2$data = sum(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data)
                   
                   use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data,
                                               sum_use_tCO2$data)
                   
                   use_returned$operwasteTblResave = operwastevalues$data
                   
                   removeModal()
                 })
                 
                 
                 output$operwaste_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_Operational_Waste.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_Operational_Waste.xlsx",to = file)}
                 )
                 
                 observeEvent(input$operwaste_Template_upload$name, {
                   
                   templateIn <- readxl::read_xlsx(input$operwaste_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:5], names(operwastevalues$data)[1:5])){
                     
                     if (typeof(templateIn$`Annual Quantity`) == "character" | typeof(templateIn$`Annual Distance`) == "character"){
                       templateIn$`Annual Quantity` <- as.numeric(templateIn$`Annual Quantity`)
                       templateIn$`Annual Distance` <- as.numeric(templateIn$`Annual Distance`)
                     }
                     
                     templateIn_data <- bind_rows(operwastevalues$data, templateIn) %>%
                       dplyr::left_join(., efs$Waste[, c("Waste Type","Waste Route","kgCO2e per unit")],
                                        by = c("Waste Type"="Waste Type", "Waste Route"="Waste Route")) %>%
                       dplyr::mutate(`Waste Processing Carbon tCO2e` = `Annual Quantity` * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::left_join(., efs$Vehicle[, c("Vehicle","kgCO2e per unit")], by = c("Transport Mode"="Vehicle")) %>%
                       dplyr::mutate(`Transport tCO2e` = `Annual Distance` * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::filter(`Annual Quantity` > 0)
                     
                     operwastevalues$data <- templateIn_data
                     
                     sum_owaste_tCO2$data <- sum(na.omit(as.numeric(operwastevalues$data$`Waste Processing Carbon tCO2e`))) * projectdetails_values$lifeTime
                     sum_owaste_trans_tCO2$data <- sum(na.omit(as.numeric(operwastevalues$data$`Transport tCO2e`))) * projectdetails_values$lifeTime
                     
                     sum_use_tCO2$data = sum(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data)
                     use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data, sum_use_tCO2$data)
                     use_returned$operwasteTblResave = operwastevalues$data
                   } else {
                     showModal(
                       modalDialog(
                         title = "Warning",
                         paste("Template upload - columns do not match. Please try another template."),easyClose = FALSE
                       )
                     )
                   }
                 })
                 
                 #### RENDER LAND VEG TABLE ####
                 
                 # Landscaping & Vegetation - change to datatables ----
                 output$landvegconstrTbl <- DT::renderDT({
                   DT = landvegconstrvalues$data
                   datatable(DT, #selection = 'single',
                             escape=F, rownames= FALSE) %>%
                     DT::formatCurrency(columns = c(4), currency = "", interval = 3, mark = ",", digits = 3)
                 })
                 
                 observeEvent(input$landv_Add_row_head, {
                   ### This is the pop up board for input a new row
                   # browser()
                   showModal(modalDialog(
                     title = "Add a new row",
                     selectizeInput(ns("landv_add_col1"), label = "Vegetation Type", choices = landvegconstrTbl_dropdown_opts_road$`Carbon Sink`),
                     numericInput(ns("landv_add_col2"), label = "Quantity", value = 0),
                     selectizeInput(ns("landv_add_col3"), label = "Unit", choices = c("Ha")),
                     textInput(ns("landv_add_col4"), label = "Comments"),
                     actionButton(ns("landv_add_row_go"), "Add item"),
                     easyClose = TRUE, footer = NULL ))
                   
                 })
                 
                 observeEvent(input$landv_add_row_go, {
                   #browser()
                   new_row = data.frame(input$landv_add_col1,
                                        input$landv_add_col2,
                                        input$landv_add_col3,
                                        "Carbon Sink tCO2e (added)" = 0,
                                        input$landv_add_col4) %>%
                     dplyr::left_join(., efs$Carbon[, c("Carbon Sink","kgCO2e per unit")], by = c("input.landv_add_col1" = "Carbon Sink")) %>%
                     dplyr::mutate(Carbon.Sink.tCO2e..added. = input.landv_add_col2 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   landvegconstrvalues$data <- data.table(rbind(landvegconstrvalues$data, new_row, use.names = F))
                   landvegconstrvalues$data$`Carbon Sink tCO2e (added)` <- as.numeric(landvegconstrvalues$data$`Carbon Sink tCO2e (added)`)
                   sum_landv_tCO2$data <- -1.0 * sum(na.omit(landvegconstrvalues$data$`Carbon Sink tCO2e (added)`))
                   
                   sum_use_tCO2$data = sum(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data)
                   use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data,
                                               sum_use_tCO2$data)
                   use_returned$landvegconstrTblResave = landvegconstrvalues$data
                   removeModal()
                 })
                 
                 observeEvent(input$landv_Del_row_head,{
                   showModal(
                     if(length(input$landvegconstrTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$landvegconstrTbl_rows_selected),"rows?" ),
                         footer = tagList(
                           modalButton("Cancel"),
                           actionButton(ns("landv_del_row_ok"), "Yes")
                         ), easyClose = TRUE)
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select row(s) that you want to delete!" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$landv_del_row_ok, {
                   #browser()
                   landvegconstrvalues$data=landvegconstrvalues$data[-input$landvegconstrTbl_rows_selected,]
                   landvegconstrvalues$data$`Carbon Sink tCO2e (added)` <- as.numeric(landvegconstrvalues$data$`Carbon Sink tCO2e (added)`)
                   sum_landv_tCO2$data <- -1.0 * sum(na.omit(landvegconstrvalues$data$`Carbon Sink tCO2e (added)`))
                   
                   sum_use_tCO2$data = sum(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data)
                   use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data,
                                               sum_use_tCO2$data)
                   use_returned$landvegconstrTblResave = landvegconstrvalues$data
                   removeModal()
                 })
                 
                 observeEvent(input$landv_mod_row_head,{
                   showModal(
                     if(length(input$landvegconstrTbl_rows_selected)==1 ){
                       modalDialog(
                         title = "Modify Row",
                         selectizeInput(ns("landv_mod_col1"), label = "Vegetation Type", choices = landvegconstrTbl_dropdown_opts_road$`Carbon Sink`,
                                        selected = landvegconstrvalues$data[input$landvegconstrTbl_rows_selected,1]),
                         numericInput(ns("landv_mod_col2"), label = "Quantity", value = landvegconstrvalues$data[input$landvegconstrTbl_rows_selected,2]),
                         selectizeInput(ns("landv_mod_col3"), label = "Unit", choices = c("Ha")),
                         textInput(ns("landv_mod_col4"), label = "Comments", value = landvegconstrvalues$data[input$landvegconstrTbl_rows_selected,5]),
                         
                         hidden(numericInput(ns("landv_mod_rown"), value = input$landvegconstrTbl_rows_selected, label = "row being edited")),
                         actionButton(ns("landv_confirm_mod"),"Confirm"),
                         easyClose = TRUE, footer = NULL )
                     }else{
                       modalDialog(
                         title = "Warning",
                         paste("Please select one row to edit" ),easyClose = TRUE
                       )
                     }
                   )
                 })
                 
                 observeEvent(input$landv_confirm_mod, {
                   
                   new_row = data.frame(input$landv_mod_col1,
                                        input$landv_mod_col2,
                                        input$landv_mod_col3,
                                        "Carbon Sink tCO2e (added)" = 0,
                                        input$landv_mod_col4) %>%
                     dplyr::left_join(., efs$Carbon[, c("Carbon Sink","kgCO2e per unit")], by = c("input.landv_mod_col1" = "Carbon Sink")) %>%
                     dplyr::mutate(Carbon.Sink.tCO2e..added. = input.landv_mod_col2 * `kgCO2e per unit` * kgConversion) %>%
                     dplyr::select(., -`kgCO2e per unit`)
                   
                   landvegconstrvalues$data[input$landv_mod_rown,] <- new_row
                   landvegconstrvalues$data$`Carbon Sink tCO2e (added)` <- as.numeric(landvegconstrvalues$data$`Carbon Sink tCO2e (added)`)
                   sum_landv_tCO2$data <- -1.0 * sum(na.omit(landvegconstrvalues$data$`Carbon Sink tCO2e (added)`))
                   
                   sum_use_tCO2$data = sum(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data)
                   use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data,
                                               sum_use_tCO2$data)
                   
                   use_returned$landvegconstrTblResave = landvegconstrvalues$data
                   
                   removeModal()
                 })
                 
                 
                 output$landv_Template_download <- downloadHandler(
                   filename = function(){"RoadRail_Operational_LANDV.xlsx"},
                   content =function(file){file.copy(from = "Templates/RoadRail_Operational_LANDV.xlsx",to = file)}
                 )
                 
                 observeEvent(input$landv_Template_upload$name, {
                   
                   templateIn <- readxl::read_xlsx(input$landv_Template_upload$datapath)
                   
                   if (identical(names(templateIn)[1:3], names(landvegconstrvalues$data)[1:3])){
                     
                     if (typeof(templateIn$Quantity) == "character"){templateIn$Quantity <- as.numeric(templateIn$Quantity)}
                     
                     templateIn_data <- bind_rows(landvegconstrvalues$data, templateIn) %>%
                       dplyr::left_join(., efs$Carbon[, c("Carbon Sink","kgCO2e per unit")], by = c("Vegetation Type"="Carbon Sink")) %>%
                       dplyr::mutate(`Carbon Sink tCO2e (added)` = Quantity * `kgCO2e per unit` * kgConversion) %>%
                       dplyr::select(., -`kgCO2e per unit`) %>%
                       dplyr::filter(Quantity > 0)
                     
                     landvegconstrvalues$data <- templateIn_data
                     
                     sum_landv_tCO2$data <- -1.0 * sum(na.omit(landvegconstrvalues$data$`Carbon Sink tCO2e (added)`))
                     
                     sum_use_tCO2$data = sum(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data)
                     use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data,
                                                 sum_use_tCO2$data)
                     use_returned$landvegconstrTblResave = landvegconstrvalues$data
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
                                       Stage = rep("Use", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   use_returned$carbsavenotimp <- tmpdf
                   use_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   removeModal()
                 })
                 
                 observeEvent(input$csavoN_Del_row_head,{
                   showModal(
                     if(length(input$csavoNoImplTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$csavoNoImplTbl_rows_selected),"rows?" ),
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
                                       Stage = rep("Use", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   use_returned$carbsavenotimp <- tmpdf
                   use_returned$csavoNoImplTblResave = csavoNoImplvalues$data
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
                                       Stage = rep("Use", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   use_returned$carbsavenotimp <- tmpdf
                   
                   use_returned$csavoNoImplTblResave = csavoNoImplvalues$data
                   
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
                                       Stage = rep("Use", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   use_returned$carbsaveimp <- tmpdf
                   use_returned$csavoImplTblResave = csavoImplvalues$data
                   removeModal()
                 })
                 
                 observeEvent(input$csavoI_Del_row_head,{
                   showModal(
                     if(length(input$csavoImplTbl_rows_selected)>=1 ){
                       modalDialog(
                         title = "Warning",
                         paste("Are you sure you want to delete",length(input$csavoImplTbl_rows_selected),"rows?" ),
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
                                       Stage = rep("Use", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   use_returned$carbsaveimp <- tmpdf
                   use_returned$csavoImplTblResave = csavoImplvalues$data
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
                                       Stage = rep("Use", nrow(csavo_tmp)))
                   tmpdf[, `:=` (Description = csavo_tmp$Description, Rationale = csavo_tmp$Rationale)]
                   use_returned$carbsaveimp <- tmpdf
                   
                   use_returned$csavoImplTblResave = csavoImplvalues$data
                   
                   removeModal()
                 })
                 
                 
                 
                 observeEvent(
                   projectdetails_values$lifeTime, # observe if any changes to scheme design life changes
                   {
                     sum_oeu_tCO2$data = sum(na.omit(oeuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime # get total carbon emissions
                     sum_owu_tCO2$data = sum(na.omit(owuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime # get total carbon emissions
                     sum_owaste_tCO2$data = sum(na.omit(as.numeric(operwastevalues$data$`Waste Processing Carbon tCO2e`))) * projectdetails_values$lifeTime
                     sum_owaste_trans_tCO2$data = sum(na.omit(as.numeric(operwastevalues$data$`Transport tCO2e`))) * projectdetails_values$lifeTime
                     #sum_mpfu_tCO2$data = sum(na.omit(mpfuvalues$data$`Annual Emissions tCO2e`)) * projectdetails_values$lifeTime
                     #sum_vehu_tCO2$data = sum(na.omit(vehuvalues$data$`Difference DS-DN Scenarios (tCO2e)`)) * projectdetails_values$lifeTime # get total carbon emissions
                     
                     # update total sum of carbon emissions when scheme design life changes
                     sum_use_tCO2$data = sum(sum_oeu_tCO2$data,
                                             sum_owu_tCO2$data,
                                             sum_owaste_tCO2$data,
                                             sum_owaste_trans_tCO2$data,
                                             sum_landv_tCO2$data
                                             #sum_mpfu_tCO2$data,
                                             #sum_vehu_tCO2$data
                                             )
                     
                     use_returned$data$Value = c(sum_oeu_tCO2$data, sum_owu_tCO2$data, sum_owaste_tCO2$data, sum_owaste_trans_tCO2$data, sum_landv_tCO2$data,
                                                 #sum_mpfu_tCO2$data, sum_vehu_tCO2$data,
                                                 sum_use_tCO2$data)
                     
                   }
                 )
                 
                 
                 observeEvent(input$button, {
                   shinyjs::toggle("guid_notes")
                 })
               }, session = getDefaultReactiveDomain()
  )
  
  return(use_returned)
  
}
